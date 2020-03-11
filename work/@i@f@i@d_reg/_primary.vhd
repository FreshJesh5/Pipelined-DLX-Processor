library verilog;
use verilog.vl_types.all;
entity IFID_reg is
    generic(
        WIDTH           : integer := 64
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector;
        IFID_write      : in     vl_logic;
        IFflush         : in     vl_logic
    );
end IFID_reg;
