library verilog;
use verilog.vl_types.all;
entity SignExtend_SRAM is
    port(
        sramAddress     : in     vl_logic_vector(10 downto 0);
        sramData        : in     vl_logic_vector(15 downto 0);
        dataExtended    : out    vl_logic_vector(31 downto 0)
    );
end SignExtend_SRAM;
