class driver extends uvm_driver #(seq_item);

  virtual int1 vint;

  `uvm_component_utils(driver)

  function new (string name = "driver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    if (!(uvm_config_db #(virtual int1)::get(this, "", "vint", vint)))
      `uvm_error("DRIVER", "NO VIRTUAL INTERFACE")

    `uvm_info("CHECK", "driver built", UVM_LOW)
  endfunction : build_phase

  virtual task run_phase (uvm_phase phase);
    forever begin
    seq_item_port.get_next_item(req);
    drive();
    seq_item_port.item_done(); end
  endtask : run_phase

  virtual task drive();
    vint.wr_enb <= 0;
    vint.wr_enb <= 0;

    if (req.wr_enb)
      begin
      vint.wr_enb <= req.wr_enb;
      vint.wr_data <= req.wr_data;
      vint.wr_addr <= req.wr_addr;
      `uvm_info("DRIVER", $sformatf("wr_enb = %0d | wr_addr = %0d | wr_data = %0d", req.wr_enb, req.wr_addr, req.wr_data), UVM_LOW)
      vint.rd_enb <= 0;
      end
    else if (req.rd_enb)
      begin
      vint.rd_enb <= req.rd_enb;
      vint.rd_addr <= req.rd_addr;
      `uvm_info("DRIVER", $sformatf("rd_enb = %0d | rd_addr = %0d | rd_data = %0d", req.rd_enb, req.rd_addr, req.rd_data), UVM_LOW)
       @(posedge vint.clk);
      //req.rd_data = vint.rd_data;
      end
      @(posedge vint.clk);
  endtask

endclass : driver
