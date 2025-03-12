  //`include "package.sv"
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "test.sv"
module tb();

 test t1;

  initial
    begin
      t1 = test::type_id::create("t1", null);
      $display("Run_test called in TB.");
      run_test();
    end

endmodule
