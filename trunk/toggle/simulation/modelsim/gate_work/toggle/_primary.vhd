library verilog;
use verilog.vl_types.all;
entity toggle is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        cntUPTO         : in     vl_logic_vector(11 downto 0);
        outputVEC1      : in     vl_logic_vector(4 downto 0);
        outputVEC2      : in     vl_logic_vector(4 downto 0);
        done            : out    vl_logic;
        outputVEC       : out    vl_logic_vector(4 downto 0);
        locked_out      : out    vl_logic;
        internalCNT_out : out    vl_logic_vector(11 downto 0);
        state_tb        : out    vl_logic_vector(1 downto 0);
        clk200_tb       : out    vl_logic;
        delayCNT_tb     : out    vl_logic_vector(3 downto 0);
        internalCNT_tb  : out    vl_logic_vector(11 downto 0)
    );
end toggle;
