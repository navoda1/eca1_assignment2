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

entity tb_mat_mul is
   
end tb_mat_mul;

architecture testset of tb_mat_mul is

  -- generate inputs for the serial version
  Component ts_mat_mul is
  port(
      dout_valid  : in std_logic;
      
      clk         : in std_logic;
      reset       : out std_logic;

      din_a       : out std_logic_vector(7 downto 0);
      din_b       : out std_logic_vector(7 downto 0)
      );
  end Component;

  -- generate inputs for the parallel_13 version
  Component ts_mat_mul_13 is
  port(
      clk         : in std_logic;
      reset       : in std_logic;

      din_13_a    : out t_mat_line;
      din_13_b    : out t_mat_line
      );
  end Component;

  Component mac_serial is
  port(
      clk         : in std_logic;
      reset       : in std_logic;
      
      din_a       : in std_logic_vector(7 downto 0);
      din_b       : in std_logic_vector(7 downto 0);

      dout        : out std_logic_vector(17 downto 0);
      dout_valid  : out std_logic
    );
  end component;

  Component mac_parallel_13 is
  port(
      clk          : in std_logic;
      reset        : in std_logic;

      din_13_a     : in t_mat_line;
      din_13_b     : in t_mat_line;

      dout         : out std_logic_vector(17 downto 0)
    );
  end component;

  signal clk                            : std_logic := '0';
  signal reset_i, dout_valid_i          : std_logic;
  signal din_a_i, din_b_i               : std_logic_vector(7 downto 0); 
  signal din_13_a_i, din_13_b_i         : t_mat_line; 
  signal dout_i                         : std_logic_vector(17 downto 0); 
  signal dout_13_i                      : std_logic_vector(17 downto 0); 

begin

   clock_gen:Process
   Begin
      for i in 0 to 1000000 loop
        clk <= not clk; 
        wait for 5 ns;
        clk   <= clk;
      end loop;    
   
   end Process;

  ts_to_tb:ts_mat_mul 
    port map(
      clk => clk, 
      reset => reset_i, 
      din_a => din_a_i, 
      din_b => din_b_i, 
      dout_valid => dout_valid_i
    );

  ts_13_to_tb:ts_mat_mul_13 
    port map(
      clk => clk, 
      reset => reset_i, 
      din_13_a => din_13_a_i, 
      din_13_b => din_13_b_i 
    );

  ms_to_tb:mac_serial 
    port map(
      clk => clk, 
      reset => reset_i, 
      din_a => din_a_i, 
      din_b => din_b_i, 
      dout => dout_i, 
      dout_valid => dout_valid_i
    ); 

  ms_13_to_tb: mac_parallel_13
    port map(
      clk => clk, 
      reset => reset_i, 
      din_13_a => din_13_a_i, 
      din_13_b => din_13_b_i, 
      dout => dout_13_i
    );

end architecture;