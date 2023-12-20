library verilog;
use verilog.vl_types.all;
entity r2 is
    port(
        din             : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        r2load          : in     vl_logic;
        dout            : out    vl_logic_vector(7 downto 0)
    );
end r2;
