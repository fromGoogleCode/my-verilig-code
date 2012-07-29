library verilog;
use verilog.vl_types.all;
entity readID is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        IDread_done     : out    vl_logic;
        output_data     : out    vl_logic_vector(7 downto 0);
        input_data      : in     vl_logic_vector(7 downto 0);
        toggleDone_tb   : out    vl_logic;
        dummy_cnt_tb    : out    vl_logic;
        state_reg_tb    : out    vl_logic_vector(1 downto 0);
        IDread_cnt_tb   : out    vl_logic_vector(1 downto 0);
        DevID_tb        : out    vl_logic_vector(7 downto 0);
        outputVEC_tb    : out    vl_logic_vector(4 downto 0)
    );
end readID;
