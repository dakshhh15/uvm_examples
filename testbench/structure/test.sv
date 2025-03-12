`include "environment.sv"

class test extends uvm_test;

  environment env;

  `uvm_component_utils(test)

  function new (string name = "test", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
   super.build_phase(phase);
   env = environment::type_id::create("env", this);
  endfunction : build_phase
  
  function void end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("UVC", { "Hierarchy : \n ", this.sprint() }, UVM_LOW)
  endfunction : end_of_elaboration_phase

endclass : test
