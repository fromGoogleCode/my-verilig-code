library verilog;
use verilog.vl_types.all;
entity nand_write is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        NandReady       : in     vl_logic;
        buffer_ready    : in     vl_logic;
        input_data      : in     vl_logic_vector(7 downto 0);
        WriteDone       : out    vl_logic;
        output_data     : out    vl_logic_vector(7 downto 0);
        outputVEC1      : out    vl_logic_vector(4 downto 0);
        outputVEC2      : out    vl_logic_vector(4 downto 0);
        outputUPTO      : out    vl_logic_vector(11 downto 0);
        clk150_tb       : out    vl_logic;
        locked_tb       : out    vl_logic;
        toggleDone_tb   : out    vl_logic;
        state_reg_tb    : out    vl_logic_vector(3 downto 0);
        CNT_reg_tb      : out    vl_logic_vector(11 downto 0);
        add_cnt_reg_tb  : out    vl_logic_vector(2 downto 0);
        toggle_enable_reg_tb: out    vl_logic
    );
end nand_write;
