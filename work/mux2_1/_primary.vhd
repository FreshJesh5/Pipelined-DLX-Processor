library verilog;
use verilog.vl_types.all;
entity mux2_1 is
    port(
        \out\           : out    vl_logic;
        sel             : in     vl_logic;
        d0              : in     vl_logic;
        d1              : in     vl_logic
    );
end mux2_1;
