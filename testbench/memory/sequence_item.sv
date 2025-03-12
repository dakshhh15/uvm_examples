class seq_item extends uvm_sequence_item;

  rand bit [3:0] rd_addr;
  rand bit [3:0] wr_addr;
  rand bit rd_enb;
  rand bit wr_enb;
  rand bit [7:0] wr_data;
  bit [7:0] rd_data;
  bit rst;

  `uvm_object_utils_begin(seq_item)
    `uvm_field_int(rd_addr, UVM_DEFAULT)
    `uvm_field_int(wr_addr, UVM_DEFAULT)
    `uvm_field_int(rd_enb, UVM_DEFAULT)
    `uvm_field_int(wr_enb, UVM_DEFAULT)
    `uvm_field_int(wr_data, UVM_DEFAULT)
  `uvm_object_utils_end

  function new (string name = "seq_item");
    super.new(name);
    abcd = new ();
  endfunction : new

  constraint c1 { wr_enb != rd_enb; }

endclass : seq_item

