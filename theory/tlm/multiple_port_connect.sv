import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"

typedef class producer;

class parent_producer extends uvm_component;
  
  uvm_blocking_put_port #(transaction) put_port;
  producer producer_inst;
  `uvm_component_utils(parent_producer)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    put_port = new("put_port)", this);
    producer_inst = new("producer_inst", this);
  endfunction

  function void connect();
    super.connect();
    producer_inst.put_port.connect(put_port);
  endfunction

endclass

class producer extends uvm_component;
  
  uvm_blocking_put_port #(transaction) put_port;
  `uvm_component_utils(producer)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    put_port = new("put_port", this);
  endfunction

  virtual task run_phase (uvm_phase phase);
    transaction packet;
    packet = transaction::type_id::create("packet");
    void'(packet.randomize());
    put_port.put(packet);
  endtask

endclass


class getter extends uvm_component;

  uvm_blocking_put_imp #(transaction, getter) put_export;
  `uvm_component_utils(getter)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    put_export = new("put_export", this);
  endfunction

  task put (transaction packet);
    packet.print();
  endtask

endclass


class top extends uvm_component;

  parent_producer inst1;
  getter inst2;

  `uvm_component_utils(top)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    inst1 = parent_producer::type_id::create("inst1", null);
    inst2 = getter::type_id::create("inst2", null);
  endfunction

  function void connect_phase (uvm_phase phase);
    inst1.put_port.connect(inst2.put_export);
  endfunction

endclass


module tb;

  top test;

  initial
    begin
      test = top::type_id::create("test", null);
      run_test();
    end  

endmodule
