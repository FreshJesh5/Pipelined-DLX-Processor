library verilog;
use verilog.vl_types.all;
entity ALUcontrol is
    generic(
        ADD             : integer := 32;
        SUB             : integer := 34;
        \AND\           : integer := 36;
        \OR\            : integer := 37;
        \XOR\           : integer := 38;
        SLT             : integer := 42;
        \SLL\           : integer := 0;
        lwsw            : integer := 0;
        beq             : integer := 1;
        alu             : integer := 2;
        addi            : integer := 3
    );
    port(
        funct           : in     vl_logic_vector(5 downto 0);
        enable          : in     vl_logic_vector(1 downto 0);
        opSelect        : out    vl_logic_vector(2 downto 0)
    );
end ALUcontrol;
