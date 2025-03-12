`include "agent.sv"

class environment extends uvm_env;

  agent ag;

  `uvm_component_utils(environment)

  function new (string name = "environment", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    ag = agent::type_id::create("agent", this);
    $display("Agent built.");
  endfunction : build_phase

endclass : environment
