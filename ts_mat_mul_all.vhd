-- ---------------------------------------------------------------------------------------------------------------------------------
-- Name        : ts_mat_mul
-- Author      : Chirag, Navoda, Megha
-- Description : Generates In matrix, clock and reset
-- ---------------------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.mat_13x13_config.all;

  Entity ts_mat_mul_all is
  port(
      --dout_valid : in std_logic;

    clk     : in std_logic;
    reset   : in std_logic;

	  index1       : out natural range 0 to 13;
	  index2       : out natural range 0 to 13; 
	  din_all_a_in : out std_logic_vector(7 downto 0);
	  din_all_b_in : out std_logic_vector(7 downto 0);
	  
	  dout_all		: in std_logic_vector(18 downto 0);
    indexO1     : out natural range 0 to 13;
    indexO2     : out natural range 0 to 13


      );
  end Entity;

architecture testset_all of ts_mat_mul_all is

   signal mat_a, mat_b : mat_in_13x13;
   signal clk_count : integer := 0;
   signal count_ctrl : std_logic;
   signal result_mat	: mat_out_13x13; 
   signal stopl     : std_logic := '0';   
begin

  clk_cnt_gen : process(clk,count_ctrl)
   begin
    if rising_edge(clk) then
      if (count_ctrl = '1') then
        clk_count <= clk_count + 1;
      end if;
    end if;
   end process;

   input_gen:Process

   Begin
      mat_a <= ((std_logic_vector(to_signed(28 ,8)), std_logic_vector(to_signed(122,8)), std_logic_vector(to_signed(80 ,8)), std_logic_vector(to_signed(42 ,8)), std_logic_vector(to_signed(54 ,8)), std_logic_vector(to_signed(122,8)), std_logic_vector(to_signed(98 ,8)), std_logic_vector(to_signed(42 ,8)), std_logic_vector(to_signed(99 ,8)), std_logic_vector(to_signed(58 ,8)), std_logic_vector(to_signed(124,8)), std_logic_vector(to_signed(29 ,8)), std_logic_vector(to_signed(21,8))  ),
                (std_logic_vector(to_signed(113,8)), std_logic_vector(to_signed(85 ,8)), std_logic_vector(to_signed(30 ,8)), std_logic_vector(to_signed(35 ,8)), std_logic_vector(to_signed(41 ,8)), std_logic_vector(to_signed(98 ,8)), std_logic_vector(to_signed(103,8)), std_logic_vector(to_signed(68 ,8)), std_logic_vector(to_signed(15 ,8)), std_logic_vector(to_signed(50 ,8)), std_logic_vector(to_signed(31 ,8)), std_logic_vector(to_signed(80 ,8)), std_logic_vector(to_signed(54,8))  ),
                (std_logic_vector(to_signed(47 ,8)), std_logic_vector(to_signed(37 ,8)), std_logic_vector(to_signed(23 ,8)), std_logic_vector(to_signed(96 ,8)), std_logic_vector(to_signed(59 ,8)), std_logic_vector(to_signed(47 ,8)), std_logic_vector(to_signed(84 ,8)), std_logic_vector(to_signed(26 ,8)), std_logic_vector(to_signed(84 ,8)), std_logic_vector(to_signed(72 ,8)), std_logic_vector(to_signed(51 ,8)), std_logic_vector(to_signed(118,8)), std_logic_vector(to_signed(119,8)) ),
                (std_logic_vector(to_signed(38 ,8)), std_logic_vector(to_signed(121,8)), std_logic_vector(to_signed(45 ,8)), std_logic_vector(to_signed(21 ,8)), std_logic_vector(to_signed(87 ,8)), std_logic_vector(to_signed(91 ,8)), std_logic_vector(to_signed(20 ,8)), std_logic_vector(to_signed(69 ,8)), std_logic_vector(to_signed(98 ,8)), std_logic_vector(to_signed(119,8)), std_logic_vector(to_signed(15 ,8)), std_logic_vector(to_signed(89 ,8)), std_logic_vector(to_signed(47,8))  ),
                (std_logic_vector(to_signed(40 ,8)), std_logic_vector(to_signed(71 ,8)), std_logic_vector(to_signed(105,8)), std_logic_vector(to_signed(76 ,8)), std_logic_vector(to_signed(31 ,8)), std_logic_vector(to_signed(65 ,8)), std_logic_vector(to_signed(109,8)), std_logic_vector(to_signed(30 ,8)), std_logic_vector(to_signed(127,8)), std_logic_vector(to_signed(110,8)), std_logic_vector(to_signed(17 ,8)), std_logic_vector(to_signed(64 ,8)), std_logic_vector(to_signed(64,8))  ),
                (std_logic_vector(to_signed(45 ,8)), std_logic_vector(to_signed(20 ,8)), std_logic_vector(to_signed(113,8)), std_logic_vector(to_signed(86 ,8)), std_logic_vector(to_signed(86 ,8)), std_logic_vector(to_signed(51 ,8)), std_logic_vector(to_signed(104,8)), std_logic_vector(to_signed(115,8)), std_logic_vector(to_signed(61 ,8)), std_logic_vector(to_signed(103,8)), std_logic_vector(to_signed(60 ,8)), std_logic_vector(to_signed(113,8)), std_logic_vector(to_signed(44,8))  ),
                (std_logic_vector(to_signed(101,8)), std_logic_vector(to_signed(107,8)), std_logic_vector(to_signed(33 ,8)), std_logic_vector(to_signed(63 ,8)), std_logic_vector(to_signed(39 ,8)), std_logic_vector(to_signed(47 ,8)), std_logic_vector(to_signed(120,8)), std_logic_vector(to_signed(20 ,8)), std_logic_vector(to_signed(41 ,8)), std_logic_vector(to_signed(64 ,8)), std_logic_vector(to_signed(102,8)), std_logic_vector(to_signed(59 ,8)), std_logic_vector(to_signed(86,8))  ),
                (std_logic_vector(to_signed(9  ,8)), std_logic_vector(to_signed(42 ,8)), std_logic_vector(to_signed(118,8)), std_logic_vector(to_signed(26 ,8)), std_logic_vector(to_signed(83 ,8)), std_logic_vector(to_signed(123,8)), std_logic_vector(to_signed(10 ,8)), std_logic_vector(to_signed(82 ,8)), std_logic_vector(to_signed(47 ,8)), std_logic_vector(to_signed(108,8)), std_logic_vector(to_signed(127,8)), std_logic_vector(to_signed(4  ,8)), std_logic_vector(to_signed(66,8))  ),
                (std_logic_vector(to_signed(75 ,8)), std_logic_vector(to_signed(26 ,8)), std_logic_vector(to_signed(117,8)), std_logic_vector(to_signed(80 ,8)), std_logic_vector(to_signed(47 ,8)), std_logic_vector(to_signed(111,8)), std_logic_vector(to_signed(38 ,8)), std_logic_vector(to_signed(22 ,8)), std_logic_vector(to_signed(98 ,8)), std_logic_vector(to_signed(101,8)), std_logic_vector(to_signed(92 ,8)), std_logic_vector(to_signed(100,8)), std_logic_vector(to_signed(48,8))  ),
                (std_logic_vector(to_signed(90 ,8)), std_logic_vector(to_signed(9  ,8)), std_logic_vector(to_signed(71 ,8)), std_logic_vector(to_signed(36 ,8)), std_logic_vector(to_signed(90 ,8)), std_logic_vector(to_signed(95 ,8)), std_logic_vector(to_signed(4  ,8)), std_logic_vector(to_signed(94 ,8)), std_logic_vector(to_signed(72 ,8)), std_logic_vector(to_signed(29 ,8)), std_logic_vector(to_signed(77 ,8)), std_logic_vector(to_signed(118,8)), std_logic_vector(to_signed(78,8))  ),
                (std_logic_vector(to_signed(81 ,8)), std_logic_vector(to_signed(75 ,8)), std_logic_vector(to_signed(97 ,8)), std_logic_vector(to_signed(127,8)), std_logic_vector(to_signed(22 ,8)), std_logic_vector(to_signed(8  ,8)), std_logic_vector(to_signed(96 ,8)), std_logic_vector(to_signed(80 ,8)), std_logic_vector(to_signed(100,8)), std_logic_vector(to_signed(88 ,8)), std_logic_vector(to_signed(69 ,8)), std_logic_vector(to_signed(114,8)), std_logic_vector(to_signed(16,8))  ),
                (std_logic_vector(to_signed(25 ,8)), std_logic_vector(to_signed(109,8)), std_logic_vector(to_signed(74 ,8)), std_logic_vector(to_signed(3  ,8)), std_logic_vector(to_signed(126,8)), std_logic_vector(to_signed(56 ,8)), std_logic_vector(to_signed(99 ,8)), std_logic_vector(to_signed(15 ,8)), std_logic_vector(to_signed(69 ,8)), std_logic_vector(to_signed(73 ,8)), std_logic_vector(to_signed(76 ,8)), std_logic_vector(to_signed(19 ,8)), std_logic_vector(to_signed(97,8))  ),
                (std_logic_vector(to_signed(59 ,8)), std_logic_vector(to_signed(84 ,8)), std_logic_vector(to_signed(102,8)), std_logic_vector(to_signed(53 ,8)), std_logic_vector(to_signed(30 ,8)), std_logic_vector(to_signed(34 ,8)), std_logic_vector(to_signed(33 ,8)), std_logic_vector(to_signed(105,8)), std_logic_vector(to_signed(75 ,8)), std_logic_vector(to_signed(102,8)), std_logic_vector(to_signed(60 ,8)), std_logic_vector(to_signed(121,8)), std_logic_vector(to_signed(93,8))  ));

     mat_b <=  ((std_logic_vector(to_signed(102,8)), std_logic_vector(to_signed(61 ,8)), std_logic_vector(to_signed(111,8)), std_logic_vector(to_signed(79 ,8)), std_logic_vector(to_signed(99 ,8)), std_logic_vector(to_signed(3  ,8)), std_logic_vector(to_signed(25 ,8)), std_logic_vector(to_signed(50 ,8)), std_logic_vector(to_signed(33 ,8)), std_logic_vector(to_signed(48 ,8)), std_logic_vector(to_signed(5  ,8)), std_logic_vector(to_signed(94,8)), std_logic_vector(to_signed(28 ,8)) ),
                (std_logic_vector(to_signed(106,8)), std_logic_vector(to_signed(89 ,8)), std_logic_vector(to_signed(35 ,8)), std_logic_vector(to_signed(37 ,8)), std_logic_vector(to_signed(112,8)), std_logic_vector(to_signed(51 ,8)), std_logic_vector(to_signed(13 ,8)), std_logic_vector(to_signed(70 ,8)), std_logic_vector(to_signed(3  ,8)), std_logic_vector(to_signed(110,8)), std_logic_vector(to_signed(31 ,8)), std_logic_vector(to_signed(7 ,8)), std_logic_vector(to_signed(99 ,8)) ),
                (std_logic_vector(to_signed(65 ,8)), std_logic_vector(to_signed(115,8)), std_logic_vector(to_signed(94 ,8)), std_logic_vector(to_signed(68 ,8)), std_logic_vector(to_signed(95 ,8)), std_logic_vector(to_signed(114,8)), std_logic_vector(to_signed(34 ,8)), std_logic_vector(to_signed(34 ,8)), std_logic_vector(to_signed(64 ,8)), std_logic_vector(to_signed(1  ,8)), std_logic_vector(to_signed(11 ,8)), std_logic_vector(to_signed(66,8)), std_logic_vector(to_signed(126,8)) ),
                (std_logic_vector(to_signed(114,8)), std_logic_vector(to_signed(37 ,8)), std_logic_vector(to_signed(42 ,8)), std_logic_vector(to_signed(3  ,8)), std_logic_vector(to_signed(88 ,8)), std_logic_vector(to_signed(35 ,8)), std_logic_vector(to_signed(124,8)), std_logic_vector(to_signed(50 ,8)), std_logic_vector(to_signed(74 ,8)), std_logic_vector(to_signed(95 ,8)), std_logic_vector(to_signed(25 ,8)), std_logic_vector(to_signed(34,8)), std_logic_vector(to_signed(24 ,8)) ),
                (std_logic_vector(to_signed(25 ,8)), std_logic_vector(to_signed(111,8)), std_logic_vector(to_signed(4  ,8)), std_logic_vector(to_signed(116,8)), std_logic_vector(to_signed(54 ,8)), std_logic_vector(to_signed(90 ,8)), std_logic_vector(to_signed(11 ,8)), std_logic_vector(to_signed(32 ,8)), std_logic_vector(to_signed(121,8)), std_logic_vector(to_signed(20 ,8)), std_logic_vector(to_signed(26 ,8)), std_logic_vector(to_signed(62,8)), std_logic_vector(to_signed(60 ,8)) ),
                (std_logic_vector(to_signed(45 ,8)), std_logic_vector(to_signed(41 ,8)), std_logic_vector(to_signed(20 ,8)), std_logic_vector(to_signed(33 ,8)), std_logic_vector(to_signed(89 ,8)), std_logic_vector(to_signed(75 ,8)), std_logic_vector(to_signed(89 ,8)), std_logic_vector(to_signed(2  ,8)), std_logic_vector(to_signed(28 ,8)), std_logic_vector(to_signed(19 ,8)), std_logic_vector(to_signed(96 ,8)), std_logic_vector(to_signed(46,8)), std_logic_vector(to_signed(119,8)) ),
                (std_logic_vector(to_signed(39 ,8)), std_logic_vector(to_signed(68 ,8)), std_logic_vector(to_signed(87 ,8)), std_logic_vector(to_signed(59 ,8)), std_logic_vector(to_signed(33 ,8)), std_logic_vector(to_signed(82 ,8)), std_logic_vector(to_signed(94 ,8)), std_logic_vector(to_signed(14 ,8)), std_logic_vector(to_signed(115,8)), std_logic_vector(to_signed(0  ,8)), std_logic_vector(to_signed(0  ,8)), std_logic_vector(to_signed(92,8)), std_logic_vector(to_signed(85 ,8)) ),
                (std_logic_vector(to_signed(58 ,8)), std_logic_vector(to_signed(62 ,8)), std_logic_vector(to_signed(122,8)), std_logic_vector(to_signed(106,8)), std_logic_vector(to_signed(93 ,8)), std_logic_vector(to_signed(39 ,8)), std_logic_vector(to_signed(86 ,8)), std_logic_vector(to_signed(80 ,8)), std_logic_vector(to_signed(75 ,8)), std_logic_vector(to_signed(23 ,8)), std_logic_vector(to_signed(57 ,8)), std_logic_vector(to_signed(89,8)), std_logic_vector(to_signed(7  ,8)) ),
                (std_logic_vector(to_signed(119,8)), std_logic_vector(to_signed(75 ,8)), std_logic_vector(to_signed(20 ,8)), std_logic_vector(to_signed(42 ,8)), std_logic_vector(to_signed(1  ,8)), std_logic_vector(to_signed(120,8)), std_logic_vector(to_signed(83 ,8)), std_logic_vector(to_signed(24 ,8)), std_logic_vector(to_signed(62 ,8)), std_logic_vector(to_signed(78 ,8)), std_logic_vector(to_signed(20 ,8)), std_logic_vector(to_signed(25,8)), std_logic_vector(to_signed(126,8)) ),
                (std_logic_vector(to_signed(121,8)), std_logic_vector(to_signed(42 ,8)), std_logic_vector(to_signed(78 ,8)), std_logic_vector(to_signed(45 ,8)), std_logic_vector(to_signed(8  ,8)), std_logic_vector(to_signed(17 ,8)), std_logic_vector(to_signed(52 ,8)), std_logic_vector(to_signed(38 ,8)), std_logic_vector(to_signed(44 ,8)), std_logic_vector(to_signed(13 ,8)), std_logic_vector(to_signed(104,8)), std_logic_vector(to_signed(57,8)), std_logic_vector(to_signed(62 ,8)) ),
                (std_logic_vector(to_signed(29 ,8)), std_logic_vector(to_signed(96 ,8)), std_logic_vector(to_signed(0  ,8)), std_logic_vector(to_signed(64 ,8)), std_logic_vector(to_signed(47 ,8)), std_logic_vector(to_signed(50 ,8)), std_logic_vector(to_signed(22 ,8)), std_logic_vector(to_signed(17 ,8)), std_logic_vector(to_signed(88 ,8)), std_logic_vector(to_signed(63 ,8)), std_logic_vector(to_signed(108,8)), std_logic_vector(to_signed(78,8)), std_logic_vector(to_signed(101,8)) ),
                (std_logic_vector(to_signed(70 ,8)), std_logic_vector(to_signed(108,8)), std_logic_vector(to_signed(69 ,8)), std_logic_vector(to_signed(12 ,8)), std_logic_vector(to_signed(0  ,8)), std_logic_vector(to_signed(80 ,8)), std_logic_vector(to_signed(115,8)), std_logic_vector(to_signed(107,8)), std_logic_vector(to_signed(71 ,8)), std_logic_vector(to_signed(54 ,8)), std_logic_vector(to_signed(5  ,8)), std_logic_vector(to_signed(57,8)), std_logic_vector(to_signed(3  ,8)) ),
                (std_logic_vector(to_signed(123,8)), std_logic_vector(to_signed(72 ,8)), std_logic_vector(to_signed(56 ,8)), std_logic_vector(to_signed(5  ,8)), std_logic_vector(to_signed(30 ,8)), std_logic_vector(to_signed(45 ,8)), std_logic_vector(to_signed(2  ,8)), std_logic_vector(to_signed(11 ,8)), std_logic_vector(to_signed(124,8)), std_logic_vector(to_signed(84 ,8)), std_logic_vector(to_signed(63 ,8)), std_logic_vector(to_signed(47,8)), std_logic_vector(to_signed(104,8)) ));

    count_ctrl <= '1';
          
   
    --din_all_a_in <= (others=>'0');
    --din_all_b_in <= (others=>'0');
    --wait for 5 ns;
    

    count_ctrl <= '1';
    if(reset = '0') then
    --if (dout_valid='0') then
    for i  in 0 to 12 loop
      for j in 0 to 12 loop

        --for elem in 0 to 12 loop
          
          wait until rising_edge(clk);

          din_all_a_in <= mat_a(i, j);
          din_all_b_in <= mat_b(i, j);
          index1 <= i;
          index2 <= j;

       -- end loop;
      end loop;
    end loop;
    --end if;
    end if;

    count_ctrl <= '0';
    wait for 10 ns;

  end process;  


  process
     variable count_loop : natural range 0 to 170;
	begin
		for i  in 0 to 12 loop
   			for j in 0 to 12 loop	
   			 	wait until rising_edge(clk);
				  result_mat(i,j) <= dout_all;
          indexO1 <= i;
          indexO2 <= j;

			end loop;
		end loop;	
	end process;




end architecture;