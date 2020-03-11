library verilog;
use verilog.vl_types.all;
entity mux4_1 is
    port(
        \out\           : out    vl_logic;
        sel1            : in     vl_logic;
        sel0            : in     vl_logic;
        d0              : in     vl_logic;
        d1              : in     vl_logic;
        d2              : in     vl_logic;
        d3              : in     vl_logic
    );
end mux4_1;
