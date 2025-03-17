import uvm_pkg::*;
`include "uvm_macros.svh"
`include "environment.sv"
`include "sequence.sv"

class test extends uvm_test;
  
  environment env;
  load_data_seq seq1;
  hold_data_seq seq2;
  shift_right_seq seq3;
  shift_left_seq seq4;
  all_op_seq seq5;
  
  `uvm_component_utils(test)
  
  function new (string name = "test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase (uvm_phase phase);
    env = environment::type_id::create("env", this);
    seq1 = load_data_seq::type_id::create("seq1", this);
    seq2 = hold_data_seq::type_id::create("seq2", this);
    seq3 = shift_right_seq::type_id::create("seq3", this);
    seq4 = shift_left_seq::type_id::create("seq4", this);
    seq5 = all_op_seq::type_id::create("seq5", this);
    `uvm_info("CHECK", "Test built.", UVM_LOW)
  endfunction : build_phase
  
  function void end_of_elaboration_phase (uvm_phase phase);
    print();
  endfunction : end_of_elaboration_phase

  virtual task run_phase (uvm_phase phase);
    phase.raise_objection(this);
	seq5.start(env.ag.seq);
    phase.drop_objection(this);
  endtask : run_phase
  
endclass : test
