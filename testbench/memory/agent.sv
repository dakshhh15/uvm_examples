`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"

class agent extends uvm_agent;

  sequencer seqr;
  driver driv;
  monitor mon;

 `uvm_component_utils(agent)

  function new (string name = "agent", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    mon = monitor::type_id::create("mon", this);

    if(get_is_active() == UVM_ACTIVE) begin
      driv    = driver::type_id::create("driv", this);
      seqr = sequencer::type_id::create("seqr", this);
    end
    
    `uvm_info("CHECK", "agent built", UVM_LOW)
  endfunction : build_phase

  function void connect_phase (uvm_phase phase);
     if(get_is_active() == UVM_ACTIVE) begin
      driv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction : connect_phase

endclass : agent 
