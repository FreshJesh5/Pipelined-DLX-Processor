module tb();

   reg clock;
   reg reset;

   CPU uut (.clk(clock), .rst(reset));

   // generate clock
   always begin
   #10 clock = ~clock;
   end

   initial begin
   // initialize all variables
   clock = 0; reset = 1;
   // now set reset to 0 and begin performing test in inst mem
   @(negedge clock) reset = 0;
   #2000
   $finish;
   end

endmodule