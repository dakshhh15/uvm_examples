  import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"

typedef class producer;
typedef class consumer_2;

class producer_consumer2 extends uvm_component;

  producer inst1;
  consumer_2 inst2;
  uvm_tlm_fifo #(transaction) fifo_inst; 

  `uvm_component_utils(producer_consumer2)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    inst1 = new("inst1", this);
    inst2 = new("inst2", this);
    fifo_inst = new("fifo_inst", this, 16);
  endfunction : new

  virtual function void connect_phase (uvm_phase phase);
    inst1.put_port.connect(fifo_inst.put_export);
    inst2.get_port.connect(fifo_inst.get_export);
  endfunction : connect_phase
  
  task run_phase (uvm_phase phase);
    `uvm_info("UVC", "fifo run phase", UVM_LOW)
    this.print();
  endtask : run_phase

endclass : producer_consumer2


class producer extends uvm_component;

  uvm_blocking_put_port #(transaction) put_port;
  `uvm_component_utils(producer)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    put_port = new("put_port", this);
  endfunction

  virtual task run_phase (uvm_phase phase);
    transaction obj1;
    obj1 = transaction::type_id::create("obj1");
    void'(obj1.randomize());
    put_port.put(obj1);
    `uvm_info("PRODUCER", "randomized data put", UVM_LOW)
    obj1.print();
  endtask

endclass


class consumer_2 extends uvm_component;
    
  uvm_blocking_get_port #(transaction) get_port;
  `uvm_component_utils(consumer_2)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    get_port = new("get_port", this);
  endfunction

  task run_phase (uvm_phase phase);
    transaction obj2;
    get_port.get(obj2);
    `uvm_info("CONSUMER", "got the randomized data", UVM_LOW)
    obj2.print();
  endtask

endclass


module tb;

  producer_consumer2 test;
    
  initial
    begin
      test = producer_consumer2::type_id::create("test", null);
      run_test();
    end

endmodule
