library verilog;
use verilog.vl_types.all;
entity CLA_4bit is
    port(
        A               : in     vl_logic_vector(3 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        Cin             : in     vl_logic;
        sum             : out    vl_logic_vector(3 downto 0);
        Cout            : out    vl_logic;
        Pout            : out    vl_logic;
        Gout            : out    vl_logic
    );
end CLA_4bit;
