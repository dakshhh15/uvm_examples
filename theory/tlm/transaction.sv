class transaction extends uvm_sequence_item;

  rand int data1;
  rand int data2;
  rand int unsigned data [];

  constraint c1 { data.size() inside {4, 8, 16, 32}; }

  `uvm_object_utils_begin(transaction)
    `uvm_field_int(data1, UVM_DEFAULT)
    `uvm_field_int(data2, UVM_DEFAULT)
    `uvm_field_array_int(data, UVM_DEFAULT)
  `uvm_object_utils_end

  function new (string name = "tansaction");
    super.new(name);
  endfunction

endclass
