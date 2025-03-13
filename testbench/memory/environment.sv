`include "sequence_item.sv"
`include "agent.sv"
`include "scoreboard.sv"

class environment extends uvm_env;

  agent ag;
  scoreboard sb;

  `uvm_component_utils(environment)

  function new (string name = "environment", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    ag = agent::type_id::create("ag", this);
    sb = scoreboard::type_id::create("sb", this);
    `uvm_info("CHECK", "environment built", UVM_LOW)
  endfunction : build_phase

  function void connect_phase (uvm_phase phase);
    ag.mon.collected_port.connect(sb.collected_port);
  endfunction : connect_phase

endclass : environment
