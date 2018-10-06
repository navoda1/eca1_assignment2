library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.mat_13x13_config.all;


entity mac_parallel_13 is

	port (
			clk : in std_logic;
			reset : in std_logic;

			din_a : in t_mat_line;
			din_b : in t_mat_line;

			dout : out std_logic_vector(17 downto 0)
		);

end entity;

architecture mac_parallel_13_arc of mac_parallel_13 is
	-- Accumulate until 13 elements
	signal acc : t_mat_line;
	signal count : integer;

begin

	process (clk)	
	begin
		if (reset = '1') then
			acc <= (others => '0');
			dout <= (others => '0');
			dout_valid <= '0';
			count <= 0;

		elsif rising_edge(clk) then

			dout <= (unsigned(din_a[0]) * unsigned(din_b[0])) +
				 	(unsigned(din_a[1]) * unsigned(din_b[1])) +
				 	(unsigned(din_a[2]) * unsigned(din_b[2])) +
				 	(unsigned(din_a[3]) * unsigned(din_b[3])) +
				 	(unsigned(din_a[4]) * unsigned(din_b[4])) +
				 	(unsigned(din_a[5]) * unsigned(din_b[5])) +
				 	(unsigned(din_a[6]) * unsigned(din_b[6])) +
				 	(unsigned(din_a[7]) * unsigned(din_b[7])) +
				 	(unsigned(din_a[8]) * unsigned(din_b[8])) +
				 	(unsigned(din_a[9]) * unsigned(din_b[9])) +
				 	(unsigned(din_a[10]) * unsigned(din_b[10])) +
				 	(unsigned(din_a[11]) * unsigned(din_b[11])) +
				 	(unsigned(din_a[12]) * unsigned(din_b[12]));

		end if;


	end process;

end mac_parallel_13_arc;