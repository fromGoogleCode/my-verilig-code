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
        dummy_cnt       : out    vl_logic
    );
end toggle;
