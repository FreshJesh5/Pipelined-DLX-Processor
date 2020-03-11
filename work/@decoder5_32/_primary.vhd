library verilog;
use verilog.vl_types.all;
entity Decoder5_32 is
    port(
        \in\            : in     vl_logic_vector(4 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end Decoder5_32;
