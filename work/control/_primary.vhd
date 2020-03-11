library verilog;
use verilog.vl_types.all;
entity control is
    generic(
        ADDI            : integer := 8;
        R               : integer := 0;
        LW              : integer := 35;
        SW              : integer := 43;
        J               : integer := 2;
        BEQ             : integer := 4;
        JumpR           : integer := 8
    );
    port(
        Opcode          : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        RegDst          : out    vl_logic;
        Branch          : out    vl_logic;
        Jump            : out    vl_logic;
        JR              : out    vl_logic;
        MemRead         : out    vl_logic;
        MemtoReg        : out    vl_logic;
        ALUOp           : out    vl_logic_vector(1 downto 0);
        MemWrite        : out    vl_logic;
        ALUSrc          : out    vl_logic;
        RegWrite        : out    vl_logic;
        branchCheck     : in     vl_logic;
        JumpCheck       : in     vl_logic;
        JRCheck         : in     vl_logic;
        IFflush         : out    vl_logic;
        IDflush         : out    vl_logic;
        EXflush         : out    vl_logic
    );
end control;
