interface int1 (input logic clk, rst);

  logic [3:0] rd_addr;
  logic [3:0] wr_addr;
  logic rd_enb;
  logic wr_enb;
  logic [7:0] rd_data;
  logic [7:0] wr_data;

endinterface
