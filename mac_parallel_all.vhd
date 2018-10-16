library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.mat_13x13_config.all;


entity mac_parallel_all is

	port (
			clk 		: in std_logic;
			reset 		: in std_logic;

			din_all_a 	: in mat_in_13x13;
			din_all_b 	: in mat_in_13x13;

			dout 		: out mat_out_13x13
			--dout_valid  : out std_logic
		);

end entity;

architecture mac_parallel_all_arc of mac_parallel_all is


begin
	process (clk)	
	Variable acc : std_logic_vector(18 downto 0);
	begin
		if (reset = '1') then
			
		for x in 0 to 12 loop
			for y in 0 to 12 loop
				dout(x,y) <= (others => '0');
			end loop;
		end loop;	

			acc := (others=>'0');
			--dout_valid <= '0';
		elsif rising_edge(clk) then

			--for k in 
			for i  in 0 to 12 loop
	   			for j in 0 to 12 loop
	   			acc := (others=>'0');
		        	for elem in 0 to 12 loop
		        			acc := std_logic_vector((unsigned(din_all_a (i, elem)) * unsigned(din_all_b(elem,j))) + unsigned(acc));
		        	end loop;
		        	dout(i,j)  <= acc;
		    	end loop;
	    end loop;
	    --dout_valid <= '1';    	
		end if;
	end process;
end mac_parallel_all_arc;