library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.mat_13x13_config.all;


entity mac_parallel_13 is

	port (
			clk 		: in std_logic;
			reset 		: in std_logic;

			din_13_a 	: in t_mat_line;
			din_13_b 	: in t_mat_line;

			dout 		: out std_logic_vector(17 downto 0)
		);

end entity;

architecture mac_parallel_13_arc of mac_parallel_13 is

begin
	process (clk, reset)	
	begin
		if (reset = '1') then
			dout <= (others => '0');

		elsif rising_edge(clk) then

			dout <= std_logic_vector(
								resize(unsigned(din_13_a(0)) * unsigned(din_13_b(0)), dout'length) +
							 	resize(unsigned(din_13_a(1)) * unsigned(din_13_b(1)), dout'length) +
							 	resize(unsigned(din_13_a(2)) * unsigned(din_13_b(2)), dout'length) +
							 	resize(unsigned(din_13_a(3)) * unsigned(din_13_b(3)), dout'length) +
							 	resize(unsigned(din_13_a(4)) * unsigned(din_13_b(4)), dout'length) +
							 	resize(unsigned(din_13_a(5)) * unsigned(din_13_b(5)), dout'length) +
							 	resize(unsigned(din_13_a(6)) * unsigned(din_13_b(6)), dout'length) +
							 	resize(unsigned(din_13_a(7)) * unsigned(din_13_b(7)), dout'length) +
							 	resize(unsigned(din_13_a(8)) * unsigned(din_13_b(8)), dout'length) +
							 	resize(unsigned(din_13_a(9)) * unsigned(din_13_b(9)), dout'length) +
							 	resize(unsigned(din_13_a(10)) * unsigned(din_13_b(10)), dout'length) +
							 	resize(unsigned(din_13_a(11)) * unsigned(din_13_b(11)), dout'length) +
							 	resize(unsigned(din_13_a(12)) * unsigned(din_13_b(12)), dout'length) +
						 	);
		end if;
	end process;
end mac_parallel_13_arc;