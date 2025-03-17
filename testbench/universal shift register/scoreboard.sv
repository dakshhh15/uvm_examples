class scoreboard extends uvm_scoreboard;
  
  uvm_analysis_imp #(seq_item, scoreboard) recieve;
  logic [3:0] pkt_int;
  
  `uvm_component_utils(scoreboard)
  
  function new (string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    recieve = new ("recieve", this);
    `uvm_info("CHECK", "Scoreboard built.", UVM_LOW)
  endfunction 

  virtual function void write(seq_item pkt);

        if (pkt.clr)
          begin
            pkt.q = 0;
            pkt_int = 0;
          end
        else begin
          if (pkt.s == 2'b00)
            begin
              if (pkt.q == pkt_int)
                begin
                  `uvm_info("SB", { "MATCH (hold) : ", $sformatf("SEL = %b | SL = %b | SR = %b | Data = %b | Out = %b", pkt.s, pkt.sl, pkt.sr, pkt.d, pkt.q) }, UVM_LOW)
                end
              else
                begin
                  `uvm_error("SB", { "MISMATCH", $sformatf("SEL = %b | SL = %b | SR = %b | Data = %b | Out = %b", pkt.s, pkt.sl, pkt.sr, pkt.d, pkt.q) })
                end
            end
          else if (pkt.s == 2'b01) begin 
              if ((pkt.q == { pkt.sr, pkt_int[3:1]}))
                begin
                  `uvm_info("SB", { "MATCH (shift right) : ", $sformatf("SEL = %b | SL = %b | SR = %b | Data = %b | Out = %b", pkt.s, pkt.sl, pkt.sr, pkt.d, pkt.q) }, UVM_LOW)
                end
              else
                begin
                  `uvm_error("SB", { "MISMATCH", $sformatf("SEL = %b | SL = %b | SR = %b | Data = %b | Out = %b", pkt.s, pkt.sl, pkt.sr, pkt.d, pkt.q) })
                end
            end
          else if (pkt.s == 2'b10) begin
              if ((pkt.q == { pkt_int[2:0], pkt.sl }))
                begin
                  `uvm_info("SB", { "MATCH (shift left) : ", $sformatf("SEL = %b | SL = %b | SR = %b | Data = %b | Out = %b", pkt.s, pkt.sl, pkt.sr, pkt.d, pkt.q) }, UVM_LOW)
                end
              else
                begin
                  `uvm_error("SB", { "MISMATCH", $sformatf("SEL = %b | SL = %b | SR = %b | Data = %b | Out = %b", pkt.s, pkt.sl, pkt.sr, pkt.d, pkt.q) })
                end
            end
          else if (pkt.s == 2'b11) begin
              if (pkt.q == pkt.d)
                begin
                  `uvm_info("SB", { "MATCH (load) : ", $sformatf("SEL = %b | SL = %b | SR = %b | Data = %b | Out = %b", pkt.s, pkt.sl, pkt.sr, pkt.d, pkt.q) }, UVM_LOW)
                end
              else
                begin
                  `uvm_error("SB", { "MISMATCH", $sformatf("SEL = %b | SL = %b | SR = %b | Data = %b | Out = %b", pkt.s, pkt.sl, pkt.sr, pkt.d, pkt.q) })
                end
            end
          pkt_int = pkt.q;
          $display("sc : %b", pkt_int);
          end
      $display("-------------");
  endfunction : write
  
endclass : scoreboard
