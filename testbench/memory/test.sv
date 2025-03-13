import uvm_pkg::*;
`include "uvm_macros.svh"
`include "environment.sv"
`include "sequence.sv"

class test extends uvm_test;

  environment env;
  read_write_seq seq1;

  `uvm_component_utils(test)

  function new (string name = "test", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env", this);
    seq1 = read_write_seq::type_id::create("seq1", this);
    `uvm_info("CHECK", "test built", UVM_LOW)
  endfunction : build_phase

  function void end_of_elaboration_phase (uvm_phase phase);
    print();
  endfunction : end_of_elaboration_phase

  virtual task run_phase (uvm_phase phase);
    phase.raise_objection(this);
	seq1.start(env.ag.seqr);
    phase.drop_objection(this);
  endtask : run_phase

endclass
