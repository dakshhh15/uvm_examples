module universal_shift_reg (output reg [3:0] q,
                            input [3:0] d,
                            input clk,clr, sl, sr,
                            input [1:0] s);
  always@(posedge clk)
    begin
      $monitor("design: [%0t] data = %b | out = %b", $time, d, q);
      if (clr)
        q <= 0;
      else
        case(s)
          2'b00 : q <= q;
          2'b01 : begin q <= q >> 1; q[3]<=sr;  end
          2'b10 : begin q <= q << 1; q[0]<=sl; end
          2'b11 : q <= d; 
          default : ;
        endcase
      //$monitor("design: [%0t] data = %b | out = %b", $time, d, q);
    end
  
endmodule


interface int1 (input logic clk, clr);
  
  logic [3:0] q;
  logic [3:0] d;
  logic [1:0] s;
  logic sl;
  logic sr;
  
endinterface
