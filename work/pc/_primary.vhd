library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        pcOut           : out    vl_logic_vector(31 downto 0);
        pcIn            : in     vl_logic_vector(31 downto 0);
        PC_write        : in     vl_logic
    );
end pc;
