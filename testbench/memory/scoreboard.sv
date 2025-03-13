class scoreboard extends uvm_scoreboard;

  seq_item queue1[$];
  bit [7:0] sc_mem [16];

  uvm_analysis_imp #(seq_item, scoreboard) collected_port;

  `uvm_component_utils(scoreboard)

  function new (string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    collected_port = new("collected_port", this);
    foreach(sc_mem[i])
      sc_mem[i] = 0;
    `uvm_info("CHECK", "sb built", UVM_LOW)
  endfunction : build_phase

  virtual function void write(seq_item m_pkt);
    queue1.push_back(m_pkt);    
  endfunction : write

  virtual task run_phase (uvm_phase phase);
    seq_item pkt;
    pkt = new ();

      forever
	begin
	 wait(queue1.size() > 0);
	pkt = queue1.pop_front();

	if (pkt.rst)
	  begin
	    foreach(sc_mem[i]) sc_mem[i] = 0;
            `uvm_info("SB", "RESET DONE", UVM_LOW)
	  end

	else if (pkt.rd_enb)
	  begin
	    if (sc_mem[pkt.rd_addr] == pkt.rd_data)
	      `uvm_info("SB", { "MATCH ", $sformatf("expected : %0d | actual : %0d", pkt.rd_data, sc_mem[pkt.rd_addr]) }, UVM_LOW)
	    else
	      `uvm_info("SB", { "MISMATCH ", $sformatf("expected : %0d | actual : %0d", pkt.rd_data, sc_mem[pkt.rd_addr]) }, UVM_LOW)
	  end

	else if (pkt.wr_enb)
	  begin
	    sc_mem[pkt.wr_addr] = pkt.wr_data;
	    `uvm_info("SB", "WRITTEN", UVM_LOW)
	  end

        `uvm_info("SB", $sformatf("sc mem = %p", sc_mem), UVM_LOW)
	end
        
  endtask : run_phase

  /*virtual function void write(seq_item pkt);
    //forever
	//begin
	 //wait(queue1.size() > 0);
	//pkt = queue1.pop_front(); 

	if (pkt.rst)
	  begin
	    foreach(sc_mem[i]) sc_mem[i] = 0;
            `uvm_info("SB", "RESET DONE", UVM_LOW)
	  end

	else if (pkt.rd_enb)
	  begin
	    if (sc_mem[pkt.rd_addr] == pkt.rd_data)
	      `uvm_info("SB", { "MATCH ", $sformatf("expected : %0d | actual : %0d", pkt.rd_data, sc_mem[pkt.rd_addr]) }, UVM_LOW)
	    else
	      `uvm_info("SB", { "MISMATCH ", $sformatf("expected : %0d | actual : %0d", pkt.rd_data, sc_mem[pkt.rd_addr]) }, UVM_LOW)
	  end

	else if (pkt.wr_enb)
	  begin
	    sc_mem[pkt.wr_addr] = pkt.wr_data;
	    `uvm_info("SB", "WRITTEN", UVM_LOW)
	  end

        `uvm_info("SB", $sformatf("sc mem = %p", sc_mem), UVM_LOW)
	//end    
  endfunction : write*/

endclass : scoreboard
