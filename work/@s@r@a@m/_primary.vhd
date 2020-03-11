library verilog;
use verilog.vl_types.all;
entity SRAM is
    port(
        clk             : in     vl_logic;
        address         : in     vl_logic_vector(10 downto 0);
        data            : inout  vl_logic_vector(15 downto 0);
        we              : in     vl_logic;
        re              : in     vl_logic
    );
end SRAM;
