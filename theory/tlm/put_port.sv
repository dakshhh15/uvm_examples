import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"

class put extends uvm_component;

  uvm_blocking_put_port #(transaction) put_port;
  `uvm_component_utils(put)
	transaction packet;

  function new (string name, uvm_component parent);
    super.new(name, parent);
    put_port = new("put_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    transaction packet;
    packet = transaction::type_id::create("packet");
    void'(packet.randomize());
    put_port.put(packet);
		`uvm_info("put", "packet randomized", UVM_LOW)
		packet.print();
  endtask
  
endclass


class get extends uvm_component;

  uvm_blocking_put_imp #(transaction, get) put_export;
  `uvm_component_utils(get)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    put_export = new("put_export", this);
  endfunction

  task put(transaction packet);
		`uvm_info("get", "packet recieved", UVM_LOW)
    packet.print();
  endtask

endclass


class top extends uvm_component;

  put inst1;
  get inst2;

  `uvm_component_utils(top)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    inst1 = put::type_id::create("inst1", null);
    inst2 = get::type_id::create("inst2", null);
  endfunction

  function void connect_phase (uvm_phase phase);
    inst1.put_port.connect(inst2.put_export);
  endfunction

  //function void end_of_elaboration_phase (uvm_phase phase);
    //this.print();
  //endfunction

endclass

module tb;

  top test1;

  initial
    begin
      test1 = top::type_id::create("test1", null);
      run_test();
    end

endmodule
