class driver extends uvm_driver #(seq_item);
  
  //seq_item transaction;
  virtual int1 vint;
  
  `uvm_component_utils(driver)
  
  function new (string name = "driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if (!(uvm_config_db #(virtual int1)::get(this, "", "vint", vint)))
      begin
      `uvm_error("DRIVER", "No interface")
      end
    `uvm_info("CHECK", "Driver built.", UVM_NONE)
  endfunction : build_phase
  
  virtual task run_phase (uvm_phase phase);
    forever
      begin
        seq_item_port.get_next_item(req);
        
        vint.d <= req.d;
        vint.s <= req.s;
        vint.sl <= req.sl;
        vint.sr <= req.sr;
        `uvm_info("DRIVER", $sformatf("SEL = %b | SL = %b | SR = %b | Data = %b | Out = %b", req.s, req.sl, req.sr, req.d, req.q), UVM_LOW)
        @(posedge vint.clk);
        
        seq_item_port.item_done();
        @(posedge vint.clk);
      end
      //@(posedge vint.clk);
  endtask : run_phase
  
endclass : driver
