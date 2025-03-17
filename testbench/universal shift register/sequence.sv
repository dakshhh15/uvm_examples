//load data
class load_data_seq extends uvm_sequence #(seq_item);
  
  int count = 5;
  
  `uvm_object_utils_begin(load_data_seq)
    `uvm_field_int(count, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new (string name = "load_data_seq");
    super.new(name);
  endfunction
  
  virtual task pre_body();
    uvm_config_int::get(null, "test.seq1", "count", count);
  endtask : pre_body
  
  virtual task body();
    repeat(count)
      begin
        `uvm_do_with(req, { req.s == 2'b11; })
      end
  endtask : body
  
endclass : load_data_seq

//hold data
class hold_data_seq extends uvm_sequence #(seq_item);
  
  int count;
  
  `uvm_object_utils_begin(hold_data_seq)
    `uvm_field_int(count, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new (string name = "hold_data_seq");
    super.new(name);
  endfunction
  
  virtual task pre_body();
    uvm_config_int::get(null, "test.seq2", "count", count);
  endtask : pre_body
  
  virtual task body();
    repeat(count)
      begin
        `uvm_do_with(req, { req.s == 2'b11; })
        `uvm_do_with(req, { req.s == 2'b00; })
      end
  endtask : body
  
endclass : hold_data_seq

//shift right 
class shift_right_seq extends uvm_sequence #(seq_item);
  
  int count;
  
  `uvm_object_utils_begin(shift_right_seq)
    `uvm_field_int(count, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new (string name = "shift_right_seq");
    super.new(name);
  endfunction
  
  virtual task pre_body();
    uvm_config_int::get(null, "test.seq3", "count", count);
  endtask : pre_body
  
  virtual task body();
    repeat(count)
      begin
        //load data
        `uvm_do_with(req, { req.s == 2'b11; })
        //shift right x4
        `uvm_do_with(req, { req.s == 2'b01; })
        `uvm_do_with(req, { req.s == 2'b01; })
        `uvm_do_with(req, { req.s == 2'b01; })
        `uvm_do_with(req, { req.s == 2'b01; })
        //hold data
        `uvm_do_with(req, { req.s == 2'b00; })
      end
  endtask : body
  
endclass : shift_right_seq

//shift left 
class shift_left_seq extends uvm_sequence #(seq_item);
  
  int count;
  
  `uvm_object_utils_begin(shift_left_seq)
    `uvm_field_int(count, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new (string name = "shift_left_seq");
    super.new(name);
  endfunction
  
  virtual task pre_body();
    uvm_config_int::get(null, "test.seq4", "count", count);
  endtask : pre_body
  
  virtual task body();
    repeat(count)
      begin
        //load data
        `uvm_do_with(req, { req.s == 2'b11; })
        //shift left x4
        `uvm_do_with(req, { req.s == 2'b10; })
        `uvm_do_with(req, { req.s == 2'b10; })
        `uvm_do_with(req, { req.s == 2'b10; })
        `uvm_do_with(req, { req.s == 2'b10; })
        //hold data
        `uvm_do_with(req, { req.s == 2'b00; })
      end
  endtask : body
  
endclass : shift_left_seq


//all operations 
class all_op_seq extends uvm_sequence #(seq_item);
  
  int count;
  
  `uvm_object_utils_begin(all_op_seq)
    `uvm_field_int(count, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new (string name = "all_op_seq");
    super.new(name);
  endfunction
  
  virtual task pre_body();
    uvm_config_int::get(null, "test.seq5", "count", count);
  endtask : pre_body
  
  virtual task body();
    repeat(count)
      begin
        //load data
        `uvm_do_with(req, { req.s == 2'b11; })
        //shift right x4
        `uvm_do_with(req, { req.s == 2'b01; })
        `uvm_do_with(req, { req.s == 2'b01; })
        `uvm_do_with(req, { req.s == 2'b01; })
        `uvm_do_with(req, { req.s == 2'b01; })
        //hold data
        `uvm_do_with(req, { req.s == 2'b00; })
        //load data
        `uvm_do_with(req, { req.s == 2'b11; })
        //shift left x4
        `uvm_do_with(req, { req.s == 2'b10; })
        `uvm_do_with(req, { req.s == 2'b10; })
        `uvm_do_with(req, { req.s == 2'b10; })
        `uvm_do_with(req, { req.s == 2'b10; })
        //hold data
        `uvm_do_with(req, { req.s == 2'b00; })
      end
  endtask : body
  
endclass : all_op_seq
