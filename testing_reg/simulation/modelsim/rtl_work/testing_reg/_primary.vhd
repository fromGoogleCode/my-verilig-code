library verilog;
use verilog.vl_types.all;
entity testing_reg is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : out    vl_logic;
        seq_reg_tb      : out    vl_logic;
        seq_next_tb     : out    vl_logic;
        state_tb        : out    vl_logic_vector(1 downto 0);
        testing_reg2_tb : out    vl_logic_vector(1 downto 0)
    );
end testing_reg;
