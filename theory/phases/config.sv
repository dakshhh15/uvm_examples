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


class configure extends uvm_component;

  master m1[];
  slave s1[];
  int num_m = 5;
  int num_s = 4;
  string nm = "bus_uvc";

  `uvm_component_utils_begin(configure)
    `uvm_field_int(num_m, UVM_DEFAULT)
    `uvm_field_int(num_s, UVM_DEFAULT)
    `uvm_field_string(nm, UVM_DEFAULT)
  `uvm_component_utils_end

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build();
    m1 = new[num_m];
    s1 = new[num_s];
    foreach(m1[i])
      m1[i] = master::type_id::create($sformatf("master[%0d] : ", i), this);
    foreach(s1[i])
      s1[i] = slave::type_id::create($sformatf("slave[%0d] : ", i), this);
  endfunction

  task run_phase (uvm_phase phase);
    `uvm_info("UVC", { "Hierarchy : \n ", this.sprint() }, UVM_LOW)
    `uvm_info("UVC", $sformatf("%s had %0d master and %0d slaves", nm, num_m, num_s), UVM_LOW)
  endtask

endclass


module testbench;

  configure test1;

  initial begin

	uvm_config_string::set(null, "test1", "nm", "final_bus");
	uvm_config_int::set(null, "test1", "num_m", 2);
	uvm_config_int::set(null, "test1", "num_s", 7);
    test1 = configure::type_id::create("test1", null);
    run_test();
  end
endmodule : testbench
