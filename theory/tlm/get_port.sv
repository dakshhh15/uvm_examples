import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"

class creator extends uvm_component;

  uvm_blocking_get_imp #(transaction, creator) get_export;
  `uvm_component_utils(creator)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    get_export = new("get_export", this);
  endfunction
    
  task get (output transaction packet);
    transaction temp;
    temp = transaction::type_id::create("temp");
    void'(temp.randomize());
    packet = temp;
  endtask

endclass


class getter extends uvm_component;

  uvm_blocking_get_port #(transaction) get_port;
  `uvm_component_utils(getter)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    get_port = new("get_port", this);
  endfunction

  task run_phase (uvm_phase phase);
    transaction packet;
    get_port.get(packet);
    packet.print();
  endtask

endclass


class top extends uvm_component;

  creator inst1;
  getter inst2;

  `uvm_component_utils(top)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    inst1 = creator::type_id::create("inst1", null);
    inst2 = getter::type_id::create("inst2", null);
    `uvm_info("TEST", "DONEE", UVM_LOW)
  endfunction

  function void connect_phase (uvm_phase phase);
    inst2.get_port.connect(inst1.get_export);
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
