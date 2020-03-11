library verilog;
use verilog.vl_types.all;
entity shifter is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        ctrl            : in     vl_logic_vector(4 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end shifter;
