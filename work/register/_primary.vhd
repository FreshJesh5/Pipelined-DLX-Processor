library verilog;
use verilog.vl_types.all;
entity \register\ is
    generic(
        WIDTH           : integer := 32
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
end \register\;
