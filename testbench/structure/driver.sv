class driver extends uvm_driver;

  `uvm_component_utils(driver)

  function new (string name = "driver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    $display("Built driver class.");
  endfunction : build_phase

endclass
