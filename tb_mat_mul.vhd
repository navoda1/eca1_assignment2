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
      reset       : in std_logic;

      din_2a      : out std_logic_vector(7 downto 0);
      din_a       : out std_logic_vector(7 downto 0);
      din_b       : out std_logic_vector(7 downto 0)
      );
  end Component;

  -- generate inputs for the parallel_13 version
  Component ts_mat_mul_13 is
  port(
      clk         : in std_logic;
      reset       : in std_logic;

      din_2a      : out std_logic_vector(7 downto 0);
      din_13_a    : out t_mat_line;
      din_13_b    : out t_mat_line
      );
  end Component;


  Component ts_mat_mul_all is
  port(
      --dout_valid : in std_logic;

    clk         : in std_logic;
    reset       : in std_logic;

    index1       : out natural range 0 to 13;
    index2       : out natural range 0 to 13; 
    din_all_a_in : out std_logic_vector(7 downto 0);
    din_all_b_in : out std_logic_vector(7 downto 0);
    
    dout_all    : in std_logic_vector(18 downto 0);
    indexO1     : out natural range 0 to 13;
    indexO2     : out natural range 0 to 13

      );
  end component;



  Component mac_serial is
  port(
      clk         : in std_logic;
      reset       : in std_logic;
      
      din_2a      : in std_logic_vector(7 downto 0);
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

      din_2a       : in std_logic_vector(7 downto 0);
      din_13_a     : in t_mat_line;
      din_13_b     : in t_mat_line;

      dout         : out std_logic_vector(17 downto 0)
    );
  end component;


  component mac_parallel_all is
  port (
      clk       : in std_logic;
      reset       : in std_logic;

      din_all_a_in  : in std_logic_vector(7 downto 0);
      din_all_b_in  : in std_logic_vector(7 downto 0);
      index1        : in natural range 0 to 13;
      index2        : in natural range 0 to 13; 

      dout_all    : out std_logic_vector(18 downto 0);
      indexO1     : in natural range 0 to 13;
      indexO2     : in natural range 0 to 13

    );
end component;


  signal clk                            : std_logic := '0';
  signal reset_i, dout_valid_i          : std_logic;
  signal din_a_i, din_b_i               : std_logic_vector(7 downto 0);
  signal din_2a_i                       : std_logic_vector(7 downto 0); 
  signal din_13_a_i, din_13_b_i         : t_mat_line; 
  signal din_13_2a_i                    : std_logic_vector(7 downto 0); 
  signal din_all_a_in_i, din_all_b_in_i : std_logic_vector(7 downto 0);
  signal dout_i                         : std_logic_vector(17 downto 0); 
  signal dout_13_i                      : std_logic_vector(17 downto 0); 
  signal dout_all_i                     : std_logic_vector(18 downto 0); 
  signal index1_i                       : natural range 0 to 13;
  signal index2_i                       : natural range 0 to 13;
  signal indexO1_i                       : natural range 0 to 13;
  signal indexO2_i                       : natural range 0 to 13;

begin

  clock_gen: process
  begin
    while true loop
      clk <= not clk; 
      wait for 5 ns;
      clk   <= clk;
    end loop;    

  end process;

  reset_gen: Process
  begin
    reset_i       <= '1';
    wait for 45 ns;
    reset_i       <= '0';
    wait;
  end process; 

  ts_mat_mul_i: ts_mat_mul 
    port map(
      clk         => clk, 
      reset       => reset_i, 
      din_2a      => din_2a_i, 
      din_a       => din_a_i, 
      din_b       => din_b_i, 
      dout_valid  => dout_valid_i
    );

  ts_mat_mul_13_i: ts_mat_mul_13 
    port map(
      clk         => clk, 
      reset       => reset_i, 
      din_2a      => din_13_2a_i, 
      din_13_a    => din_13_a_i, 
      din_13_b    => din_13_b_i 
    );

    ts_mat_mul_all_i: ts_mat_mul_all
    port map(
        clk           => clk,
        reset         => reset_i,
        index1        => index1_i,
        index2        => index2_i,
        din_all_a_in  => din_all_a_in_i,
        din_all_b_in  => din_all_b_in_i,
        dout_all      => dout_all_i,
        indexO1       => indexO1_i,
        indexO2       => indexO2_i
      );

  mac_serial_i: mac_serial 
    port map(
      clk         => clk, 
      reset       => reset_i, 
      din_2a      => din_2a_i, 
      din_a       => din_a_i, 
      din_b       => din_b_i, 
      dout        => dout_i, 
      dout_valid  => dout_valid_i
    ); 

   mac_parallel_13_i:  mac_parallel_13
    port map(
      clk         => clk, 
      reset       => reset_i, 
      din_2a      => din_13_2a_i, 
      din_13_a    => din_13_a_i, 
      din_13_b    => din_13_b_i, 
      dout        => dout_13_i
    );

  mac_parallel_all_i: mac_parallel_all
   port map(
      clk            => clk,
      reset          => reset_i,
      din_all_a_in   => din_all_a_in_i,
      din_all_b_in   => din_all_b_in_i,
      index1         => index1_i,
      index2         => index2_i,
      dout_all       => dout_all_i,
      indexO1        => indexO1_i,
      indexO2        => indexO2_i
      --dout_valid => dout_valid_i
    ); 

end architecture;