library verilog;
use verilog.vl_types.all;
entity Decoder3_8 is
    port(
        en              : in     vl_logic;
        \in\            : in     vl_logic_vector(2 downto 0);
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end Decoder3_8;
