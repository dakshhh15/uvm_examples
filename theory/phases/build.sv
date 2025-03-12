module tb;
import uvm_pkg::*;
`include "uvm_macros.svh"

class street extends uvm_component;
  
  `uvm_component_utils(street)
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run();
    `uvm_info("[INFO_1]", "I vacationed here", UVM_LOW)
  endtask

endclass


class city extends uvm_component;

  street main_street;
  `uvm_component_utils(city)

  function new (string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build();
    super.build();
    main_street = street::type_id::create("main_street", this);
    `uvm_info("ABC", "BUILTTTTTTT", UVM_LOW)
  endfunction

  task run();
    uvm_component child, parent;
//parent empty as no class above it
    parent = get_parent();
    `uvm_info("RUN", { "parent : ", parent.get_full_name }, UVM_LOW)

    child = get_child("main_street");
    `uvm_info("RUN", { "child : ", child.get_full_name }, UVM_LOW)
  endtask

endclass

city c1;

  initial
    begin
      c1 = city::type_id::create("c1", null);
      run_test();
      #100 global_stop_request;
    end

endmodule
