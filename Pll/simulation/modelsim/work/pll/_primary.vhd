library verilog;
use verilog.vl_types.all;
entity pll is
    port(
        c0              : out    vl_logic;
        locked          : out    vl_logic;
        inclk0          : in     vl_logic
    );
end pll;
