library verilog;
use verilog.vl_types.all;
entity forwarding is
    port(
        IDEX_rs         : in     vl_logic_vector(4 downto 0);
        IDEX_rt         : in     vl_logic_vector(4 downto 0);
        EXMEM_rd        : in     vl_logic_vector(4 downto 0);
        MEMWB_rd        : in     vl_logic_vector(4 downto 0);
        EXMEM_RegWrite  : in     vl_logic;
        MEMWB_RegWrite  : in     vl_logic;
        IDEX_MemWrite   : in     vl_logic;
        EXMEM_MemWrite  : in     vl_logic;
        forward_A       : out    vl_logic_vector(1 downto 0);
        forward_B       : out    vl_logic_vector(1 downto 0)
    );
end forwarding;
