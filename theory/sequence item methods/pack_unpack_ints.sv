`include "uvm_macros.svh"
import uvm_pkg::*;

class seq_item extends uvm_sequence_item;

  rand bit [3:0] addr;
  rand bit wr_en;
  rand bit rd_en;
  rand bit [7:0] wr_data;
  rand bit rd_data;

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
  int unsigned bit_data[];

  initial
    begin
      seq_item inst1;
      inst1 = seq_item::type_id::create();
      assert(inst1.randomize());
      `uvm_info("original", "print inst1", UVM_LOW)
      inst1.print();

      inst1.pack_ints(bit_data);
      foreach (bit_data[i])
	`uvm_info("pack", $sformatf("bit_data[%0b] = 0x%0b", i, bit_data[i]), UVM_LOW)

      inst1.unpack_ints(bit_data);
      `uvm_info("unpack", "unpacking into inst1", UVM_LOW)
      inst1.print();
    end

endmodule
