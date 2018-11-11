fmt
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.mat_13x13_config.all;


entity mac_parallel_13 is

    port (
            clk         : in std_logic;
            reset       : in std_logic;

            din_2a      : in std_logic_vector(7 downto 0);
            din_13_a    : in t_mat_line;
            din_13_b    : in t_mat_line;

            dout        : out std_logic_vector(17 downto 0)
        );

end entity;

architecture mac_parallel_13_arc of mac_parallel_13 is
    signal din_13_a_i   : t_mat_line;
    signal din_13_b_i   : t_mat_line;
    signal din_2a_i     : std_logic_vector(8 downto 0);
begin
    process (clk, reset)    
    begin
        if (reset = '1') then
            dout        <= (others => '0');
            din_13_a_i  <= (others => (others => '0'));
            din_13_b_i  <= (others => (others => '0'));
            din_2a_i    <= (others => '0');

        elsif rising_edge(clk) then

            dout <= std_logic_vector(
                                resize(unsigned(din_13_a_i(0)) * unsigned(din_13_b_i(0)), dout'length) +
                                resize(unsigned(din_13_a_i(1)) * unsigned(din_13_b_i(1)), dout'length) +
                                resize(unsigned(din_13_a_i(2)) * unsigned(din_13_b_i(2)), dout'length) +
                                resize(unsigned(din_13_a_i(3)) * unsigned(din_13_b_i(3)), dout'length) +
                                resize(unsigned(din_13_a_i(4)) * unsigned(din_13_b_i(4)), dout'length) +
                                resize(unsigned(din_13_a_i(5)) * unsigned(din_13_b_i(5)), dout'length) +
                                resize(unsigned(din_13_a_i(6)) * unsigned(din_13_b_i(6)), dout'length) +
                                resize(unsigned(din_13_a_i(7)) * unsigned(din_13_b_i(7)), dout'length) +
                                resize(unsigned(din_13_a_i(8)) * unsigned(din_13_b_i(8)), dout'length) +
                                resize(unsigned(din_13_a_i(9)) * unsigned(din_13_b_i(9)), dout'length) +
                                resize(unsigned(din_13_a_i(10)) * unsigned(din_13_b_i(10)), dout'length) +
                                resize(unsigned(din_13_a_i(11)) * unsigned(din_13_b_i(11)), dout'length) +
                                resize(unsigned(din_13_a_i(12)) * unsigned(din_13_b_i(12)), dout'length) +
                                resize(unsigned(din_2a_i), dout'length) -- + 2A
                            );

            -- registering input
            din_13_a_i   <= din_13_a;
            din_13_b_i   <= din_13_b;
            din_2a_i     <= din_2a & '0'; -- left shift (2x)

        end if;
    end process;


end mac_parallel_13_arc;