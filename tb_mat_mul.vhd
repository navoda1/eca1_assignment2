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

  Component ts_mat_mul is
  port(
      dout_valid : in std_logic;
      
      clk    : out std_logic;
      reset  : out std_logic;

      din_a : out std_logic_vector(7 downto 0);
      din_b : out std_logic_vector(7 downto 0)
      );
  end Component;

  Component mac_serial is
  port(
      clk   : in std_logic;
      reset : in std_logic;

      din_a : in std_logic_vector(7 downto 0);
      din_b : in std_logic_vector(7 downto 0);

      dout        : out std_logic_vector(17 downto 0);
      dout_valid  : out std_logic
    );
  end component;

  signal clk_i, reset_i, dout_valid_i : std_logic;
  signal din_a_i,din_b_i: std_logic_vector(7 downto 0); 
  signal dout_i : std_logic_vector(17 downto 0); 

begin

ts_to_tb:ts_mat_mul port map(clk => clk_i, reset => reset_i, din_a => din_a_i, din_b => din_b_i, dout_valid => dout_valid_i);
ms_to_tb:mac_serial port map(clk => clk_i, reset => reset_i, din_a => din_a_i, din_b => din_b_i, dout => dout_i, dout_valid => dout_valid_i); 

end architecture;