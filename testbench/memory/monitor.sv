class monitor extends uvm_monitor;
  
  virtual int1 vint;
  uvm_analysis_port #(seq_item) collected_port;
  seq_item transaction_collected;

  `uvm_component_utils(monitor)

  function new (string name = "monitor", uvm_component parent);
    super.new(name, parent);
    transaction_collected = new();
    collected_port = new("collected_port", this);
  endfunction : new

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);

    if (!(uvm_config_db #(virtual int1)::get(this, "", "vint", vint)))
      `uvm_error("MONITOR", "NO INTERFACE")
    
    `uvm_info("CHECK", "monitor built", UVM_LOW)
  endfunction : build_phase

  virtual task run_phase (uvm_phase phase);
    forever
      begin
	@(posedge vint.clk);
	if (vint.wr_enb)
	  begin
	    transaction_collected.wr_enb = vint.wr_enb;
	    transaction_collected.wr_data = vint.wr_data;
	    transaction_collected.wr_addr = vint.wr_addr;
            transaction_collected.rst = vint.rst;
            transaction_collected.rd_enb = 0;
	    `uvm_info("MONITOR", $sformatf("wr_enb = %0d | wr_data = %0d | wr_addr = %0d", vint.wr_enb, vint.wr_data, vint.wr_addr), UVM_LOW)
	  end
	else if (vint.rd_enb)
	  begin
	    transaction_collected.rd_enb = vint.rd_enb;
	    transaction_collected.rd_addr = vint.rd_addr;
            transaction_collected.rst = vint.rst;
            transaction_collected.wr_enb = 0;
            @(posedge vint.clk);
            //@(posedge vint.clk);
	    transaction_collected.rd_data = vint.rd_data;
	    `uvm_info("MONITOR", $sformatf("rd_enb = %0d | rd_data = %0d | rd_addr = %0d", vint.rd_enb, vint.rd_data, vint.rd_addr), UVM_LOW)
	  end
      end
      `uvm_info("COVERAGE", $sformatf("cov1 = %0.2f %% | cov2 = %0.2f %%", transaction_collected.abcd.aXw.get_inst_coverage(), transaction_collected.abcd.aXr.get_inst_coverage()), UVM_LOW)
      collected_port.write(transaction_collected);
  endtask : run_phase

endclass : monitor
