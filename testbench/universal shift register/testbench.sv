`include "test.sv"
`include "design.sv"

module tb;
  
  bit clk, clr;
  
  int1 intf (.clk(clk),
             .clr(clr));
  
  universal_shift_reg dut (.clk(intf.clk),
                           .clr(intf.clr),
                           .d(intf.d),
                           .q(intf.q),
                           .sl(intf.sl),
                           .sr(intf.sr),
                           .s(intf.s));
  
  always #10 clk = ~clk;  

  initial
    begin
      uvm_config_db #(virtual int1)::set(null, "*", "vint", intf);
      uvm_config_int::set(null, "test.seq1", "count", 10);
      uvm_config_int::set(null, "test.seq2", "count", 10);
      uvm_config_int::set(null, "test.seq3", "count", 5);
      uvm_config_int::set(null, "test.seq4", "count", 10);
      uvm_config_int::set(null, "test.seq5", "count", 25);
    end

  initial
    begin
      clr = 1;
      #20 clr = 0;
      #100 clr = 1;
      #20 clr = 0;
    end

  initial
    begin
      run_test("test");
    end

  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end

endmodule : tb
