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
	signal acc 		: std_logic_vector(17 downto 0);
	signal count 	: integer range 0 to 13;
	signal init 	: std_logic;
begin

	process (clk, reset)	
	begin
		if (reset = '1') then
			acc 			<= (others => '0');
			count 		<= 0;
			init 			<= '1';
		elsif rising_edge(clk) then

			-- initially
			if(init = '1' and count = 1) then
				init 		<= '0';
			end if;
			
			-- counter
			if(count = 13) then
				count 	<= 1;
			else
				count 	<= count + 1;
			end if;

			-- when count = 1, start with only the MUL (no acc +)
			if(count = 1) then
				acc 		<= std_logic_vector(resize((unsigned(din_a) * unsigned(din_b)), acc'length));
			else
				acc 		<= std_logic_vector(unsigned(acc) + (unsigned(din_a) * unsigned(din_b)));
			end if;

		end if;

	end process;

	dout_valid <= '1' when (count = 1  and init /= '1') else '0';
	dout 			 <= acc;


end mac_serial_arc;