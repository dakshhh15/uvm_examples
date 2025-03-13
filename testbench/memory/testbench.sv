import uvm_pkg::*;
`include "uvm_macros.svh"
`include "interface.sv"
`include "test.sv"
`include "design.sv"

module tb;

  bit rst;
  bit clk;

  test t1;
  int1 intf (.clk(clk), .rst(rst));
  memory dut (.clk(intf.clk),
	      .rst(intf.rst),
	      .rd_addr(intf.rd_addr),
	      .wr_addr(intf.wr_addr),
	      .rd_enb(intf.rd_enb),
	      .wr_enb(intf.wr_enb),
	      .rd_data(intf.rd_data),
	      .wr_data(intf.wr_data));

  always #10 clk = ~clk;  

  initial
    begin
      uvm_config_db #(virtual int1)::set(null, "*", "vint", intf);
    end

  initial
    begin
      rst = 1;
      #20 rst = 0;
      #100 rst = 1;
      #20 rst = 0;
    end

  initial
    begin
      run_test("test");
    end

endmodule
