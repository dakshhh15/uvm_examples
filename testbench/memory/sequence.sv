class seq extends uvm_sequence #(seq_item);

  `uvm_object_utils(seq)

  function new (string name = "seq");
    super.new(name);
  endfunction : new

  virtual task body();
    repeat (10)
      begin
        req = seq_item::type_id::create("req");
        wait_for_grant();
        void'(req.randomize());
        send_request(req);
        wait_for_item_done();
      end
  endtask : body

endclass : seq


class read_seq extends uvm_sequence #(seq_item);

  `uvm_object_utils(read_seq)

  function new (string name = "read_seq");
    super.new(name);
  endfunction : new

  virtual task body();
    repeat (10)
      begin
        `uvm_do_with(req, {req.rd_enb == 1;})
      end
  endtask : body

endclass : read_seq


class write_seq extends uvm_sequence #(seq_item);
    
  `uvm_object_utils(write_seq)

  function new ( string name = "write_seq");
    super.new(name);
  endfunction : new

  virtual task body ();
    repeat (10) 
      begin
        `uvm_do_with(req, { req.wr_enb == 1; })
      end
  endtask : body

endclass : write_seq


class read_write_seq extends uvm_sequence #(seq_item);

  seq_item smp;
  `uvm_object_utils(read_write_seq)

  function new (string name = "read_write_seq");
    super.new(name);
    smp = new();
  endfunction : new

  virtual task body();
    repeat(40) begin
    `uvm_do_with(req, {req.rd_enb == 1; })
    `uvm_do_with(req, {req.wr_enb == 1; })
    smp.abcd.sample(); end
  endtask : body

endclass : read_write_seq


class write_read_seq extends uvm_sequence #(seq_item);

  `uvm_object_utils(write_read_seq)

  function new (string name = "read_write_seq");
    super.new(name);
  endfunction : new

  virtual task body();
    repeat (10)
      begin
        `uvm_do_with(req, {req.wr_enb == 1; })
        `uvm_do_with(req, {req.rd_enb == 1; })
      end
  endtask : body

endclass : write_read_seq
