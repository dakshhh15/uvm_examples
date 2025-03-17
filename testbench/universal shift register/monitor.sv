class monitor extends uvm_monitor;
  
  virtual int1 vint;
  seq_item transaction;
  uvm_analysis_port #(seq_item) send;
  
  `uvm_component_utils(monitor)
  
  function new (string name = "monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    transaction = new("transaction");
    send = new ("send", this);
    
    if (!(uvm_config_db #(virtual int1)::get(this, "", "vint", vint)))
      begin
        `uvm_error("MONITOR", "No interface")
      end
    
    `uvm_info("CHECK", "Monitor built.", UVM_LOW)
  endfunction : build_phase
  
  virtual task run_phase (uvm_phase phase);
    `uvm_info ("MON", "Mon run phase started", UVM_LOW)
    forever
      begin
        @(posedge vint.clk);
        //`uvm_info ("MON", "Mon loop entered", UVM_LOW)
        transaction.d = vint.d;
        transaction.s = vint.s;
        transaction.sl = vint.sl;
        transaction.clr = vint.clr;
        transaction.sr = vint.sr;
        vint.s = 0;
        @(posedge vint.clk);

        transaction.q = vint.q;

        `uvm_info("MONITOR", $sformatf("SEL = %b | SL = %b | SR = %b | Data = %b | Out = %b", transaction.s, vint.sl, vint.sr, vint.d, vint.q), UVM_LOW)
        send.write(transaction);
      end
    //send.write(transaction);
  endtask : run_phase
  
endclass : monitor
