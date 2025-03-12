class monitor extends uvm_monitor;

  `uvm_component_utils(monitor)

  function new (string name = "monitor", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Built monitor.", "", UVM_LOW)
  endfunction : build_phase

endclass
