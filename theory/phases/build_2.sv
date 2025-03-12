import uvm_pkg::*;
`include "uvm_macros.svh"

class master extends uvm_component;
  
  `uvm_component_utils(master)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase (uvm_phase phase);
    `uvm_info("MASTER", "executing master", UVM_LOW)
  endtask

endclass

class slave extends uvm_component;

  `uvm_component_utils(slave)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase (uvm_phase phase);
    `uvm_info("SLAVE", "executing slave", UVM_LOW)
  endtask

endclass

class top extends uvm_component;

  master m1;
  slave s1;

  `uvm_component_utils(top)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    `uvm_info("UVC", "building phase", UVM_LOW)
    m1 = master::type_id::create("m1", this);
    s1 = slave::type_id::create("s1", this);
  endfunction

  task run_phase (uvm_phase phase);
    uvm_component parent, child;
    `uvm_info("UVC", "executing run phase", UVM_LOW)
    parent = get_parent();
    `uvm_info("UVC ", { "get parent : ", parent.get_full_name() }, UVM_LOW)
    child = get_child("m1");
    `uvm_info("UVC", { "get child's full name(m1) : ", child.get_full_name() }, UVM_LOW)
    `uvm_info("UVC", { "get child(m1) : ", child.get_name() }, UVM_LOW)
    child = get_child("s1");
    `uvm_info("UVC", { "get child's full name(s1) : ", child.get_full_name() }, UVM_LOW)
    `uvm_info("UVC", { "get child(s1) : ", child.get_name() }, UVM_LOW)
  endtask

endclass

class tb extends uvm_component;
  
  top i1;

  `uvm_component_utils(tb)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build();
    i1 = top::type_id::create("i1", this);
  endfunction

  function void end_of_elaboration_phase (uvm_phase phase);
    `uvm_info("TB", { "end_of_elaboartion_phase(), Hierarchy : \n", this.sprint() }, UVM_LOW)
  endfunction

  task run_phase (uvm_phase phase);
    `uvm_info("TB", "executing run phase", UVM_LOW)
  endtask

endclass

module testbench;

  tb t1;

  initial
    begin
      t1 = tb::type_id::create("t1", null);
      run_test();
    end

endmodule
