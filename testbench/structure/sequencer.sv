class sequencer extends uvm_sequencer #(uvm_sequence_item);
  
  `uvm_component_utils(sequencer)

  function new (string name = "sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    $display("Built sequencer.");
  endfunction : build_phase

function void end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("UVC", { "Hierarchy : \n ", this.sprint() }, UVM_LOW)
  endfunction : end_of_elaboration_phase

endclass : sequencer
