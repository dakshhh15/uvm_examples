class seq_item extends uvm_sequence_item;
  
  rand bit [3:0] d;
  rand bit [1:0] s;
  rand bit sl;
  rand bit sr;
  bit [3:0] q;
  bit clr;
  
  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(d, UVM_NONE)
  `uvm_field_int(s, UVM_NONE)
  `uvm_field_int(sl, UVM_NONE)
  `uvm_field_int(sr, UVM_NONE)
  `uvm_object_utils_end
  
  function new (string name = "seq_item");
    super.new(name);
  endfunction
  
endclass : seq_item
