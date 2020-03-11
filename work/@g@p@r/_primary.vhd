library verilog;
use verilog.vl_types.all;
entity GPR is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        rs1             : in     vl_logic_vector(4 downto 0);
        rs2             : in     vl_logic_vector(4 downto 0);
        ws              : in     vl_logic_vector(4 downto 0);
        we              : in     vl_logic;
        wData           : in     vl_logic_vector(31 downto 0);
        rData1          : out    vl_logic_vector(31 downto 0);
        rData2          : out    vl_logic_vector(31 downto 0)
    );
end GPR;
