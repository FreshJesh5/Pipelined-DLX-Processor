library verilog;
use verilog.vl_types.all;
entity ALU_rtl is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        ctrl            : in     vl_logic_vector(2 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0);
        Z               : out    vl_logic;
        V               : out    vl_logic;
        C               : out    vl_logic;
        N               : out    vl_logic
    );
end ALU_rtl;
