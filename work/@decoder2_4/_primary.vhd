library verilog;
use verilog.vl_types.all;
entity Decoder2_4 is
    port(
        en              : in     vl_logic;
        \in\            : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(3 downto 0)
    );
end Decoder2_4;
