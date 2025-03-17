`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"

class agent extends uvm_agent;
  
  sequencer seq;
  driver driv;
  monitor mon;
  
  `uvm_component_utils(agent)
  
  function new (string name = "agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    seq = sequencer::type_id::create("seq", this);
    driv = driver::type_id::create("driv", this);
    mon = monitor::type_id::create("mon", this);
    `uvm_info("CHECK", "Agent built.", UVM_LOW)
  endfunction : build_phase
  
  virtual function void connect_phase (uvm_phase phase);
    driv.seq_item_port.connect(seq.seq_item_export);
  endfunction : connect_phase
  
endclass : agent
