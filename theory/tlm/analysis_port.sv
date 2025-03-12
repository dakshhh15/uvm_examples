import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"

class analysis extends uvm_component;

  uvm_analysis_port #(transaction) analysis_port;
  `uvm_component_utils(analysis)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  virtual task run_phase (uvm_phase phase);
    transaction packet;
    packet = transaction::type_id::create("packet");
    void'(packet.randomize());
    analysis_port.write(packet);
  endtask

endclass


module tb;

	analysis test;

	initial
		begin
			test = analysis::type_id::create("test", null);
			run_test();
		end

endmodule
