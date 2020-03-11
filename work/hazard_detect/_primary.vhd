library verilog;
use verilog.vl_types.all;
entity hazard_detect is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        IFID_rs         : in     vl_logic_vector(4 downto 0);
        IFID_rt         : in     vl_logic_vector(4 downto 0);
        IDEX_rt         : in     vl_logic_vector(4 downto 0);
        IDEX_MemRead    : in     vl_logic;
        PC_write        : out    vl_logic;
        IFID_write      : out    vl_logic;
        mux_ctrl        : out    vl_logic
    );
end hazard_detect;
