library verilog;
use verilog.vl_types.all;
entity CLU is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        sum             : out    vl_logic_vector(31 downto 0);
        C               : out    vl_logic
    );
end CLU;
