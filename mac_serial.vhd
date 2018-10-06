library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity mac_serial is

	port (
			clk : in std_logic;
			reset : in std_logic;

			din_a : in std_logic_vector(7 downto 0);
			din_b : in std_logic_vector(7 downto 0);

			dout : out std_logic_vector(17 downto 0);
			dout_valid : out std_logic

		);

end entity;

architecture mac_serial_arc of mac_serial is
	-- Accumulate until 13 elements
	signal acc : std_logic_vector(17 downto 0);
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
			acc <= std_logic_vector(unsigned(acc) + (unsigned(din_a) * unsigned(din_b)));

			if (count = 13) then
				dout_valid <= '1';
				dout <= acc;
				count <= 0;
				acc <= (others => '0');
			else
				dout_valid <= '0';
				dout <= (others => '0');
				count <= count + 1;
			end if;

		end if;


	end process;

end mac_serial_arc;