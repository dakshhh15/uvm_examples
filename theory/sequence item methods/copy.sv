class seq_item extends uvm_sequence_item;
  
  rand bit [3:0] addr;
  rand bit wr_en;
  rand bit rd_en;
  rand bit [7:0] wr_data;
  bit [7:0] rd_data;
   
  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(addr, UVM_DEFAULT)
  `uvm_field_int(wr_en, UVM_DEFAULT)
  `uvm_field_int(rd_en, UVM_DEFAULT)
  `uvm_field_int(wr_data, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new (string name = "seq_item");
    super.new(name);
  endfunction
  
  constraint c1 { wr_en != rd_en; }
  
endclass

module tb;
  
  seq_item inst1;
  seq_item inst2;
  
  initial
    begin
      inst1 = seq_item::type_id::create();
      inst2 = seq_item::type_id::create();
      inst1.randomize();
      inst1.print();
      inst2.copy(inst1);
      inst2.print();
    end
  
endmodule
