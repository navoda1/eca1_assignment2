library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.mat_13x13_config.all;


entity mac_parallel_all is

	port (
			clk 			: in std_logic;
			reset 			: in std_logic;

			din_all_a_in 	: in std_logic_vector(7 downto 0);
      		din_all_b_in 	: in std_logic_vector(7 downto 0);
      		index1       	: in natural range 0 to 13;
      		index2      	: in natural range 0 to 13; 

			dout_all		: out std_logic_vector(18 downto 0);
			indexO1			: in natural range 0 to 13;
			indexO2			: in natural range 0 to 13

		);

end entity;

architecture mac_parallel_all_arc of mac_parallel_all is
signal	din_all_a 	: mat_in_13x13;
signal	din_all_b 	: mat_in_13x13;
signal  dout_all_i	: mat_out_13x13;
signal count_iter 	: natural range 0 to 170;
--signal cal			: std_logic;



begin
	process (clk,reset)	
	Variable acc : std_logic_vector(18 downto 0);
	begin
		if (reset = '1') then		
			for x in 0 to 12 loop
				for y in 0 to 12 loop
					dout_all_i(x,y) <= (others => '0');

				end loop;
			end loop;	
			acc := (others=>'0');
			--dout_valid <= '0';
			count_iter <= 0;
		elsif rising_edge(clk) then
			for i  in 0 to 12 loop
	   			for j in 0 to 12 loop
		   			acc := (others=>'0');
		        	for elem in 0 to 12 loop
		        		acc := std_logic_vector((unsigned(din_all_a (i, elem)) * unsigned(din_all_b(elem,j))) + unsigned(acc));
		       		end loop;
			       	dout_all_i(i,j)  <= std_logic_vector(unsigned(acc)+2*unsigned(din_all_a(i,j)));
		  		end loop;
	    	end loop;
		end if;
	end process;

	process(din_all_a_in,din_all_b_in,index1,index2)
	begin
		din_all_a(index1,index2) <= din_all_a_in;
		din_all_b(index1,index2) <= din_all_b_in;
	end process;


	process(indexO1,indexO2)
	begin
				dout_all <= dout_all_i(indexO1,indexO2);
	end process;

end mac_parallel_all_arc;