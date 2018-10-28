library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.mat_13x13_config.all;


entity mac_parallel_13_pipelined is

    port (
            clk         : in std_logic;
            reset       : in std_logic;

            din_2a      : in std_logic_vector(7 downto 0);
            din_13_a    : in t_mat_line;
            din_13_b    : in t_mat_line;

            dout        : out std_logic_vector(17 downto 0)
        );

end entity;

architecture mac_parallel_13_pipelined_arc of mac_parallel_13_pipelined is

   type t_pipe_mat_line      is array(integer range 0 to 12) of std_logic_vector(7 downto 0);

    signal din_13_a_i       : t_mat_line;
    signal din_13_b_i       : t_mat_line;
    signal pipe_din_13_a_0  : t_mat_line;
    signal pipe_din_13_b_0  : t_mat_line;
    signal pipe_din_13_a_1  : t_mat_line;
    signal pipe_din_13_b_1  : t_mat_line;
    signal pipe_din_13_a_2  : t_mat_line;
    signal pipe_din_13_b_2  : t_mat_line;
    signal pipe_din_13_a_3  : t_mat_line;
    signal pipe_din_13_b_3  : t_mat_line;
    signal pipe_din_13_a_4  : t_mat_line;
    signal pipe_din_13_b_4  : t_mat_line;
    signal pipe_din_13_a_5  : t_mat_line;
    signal pipe_din_13_b_5  : t_mat_line;
    signal din_2a_i         : std_logic_vector(8 downto 0);
    signal pipe_acc_0       : std_logic_vector(17 downto 0);
    signal pipe_acc_1       : std_logic_vector(17 downto 0);
    signal pipe_acc_2       : std_logic_vector(17 downto 0);
    signal pipe_acc_3       : std_logic_vector(17 downto 0);
    signal pipe_acc_4       : std_logic_vector(17 downto 0);
    signal pipe_acc_5       : std_logic_vector(17 downto 0);
begin
    process (clk, reset)    
    begin
        if (reset = '1') then
            dout            <= (others => '0');
            pipe_acc_0      <= (others => '0');
            pipe_acc_1      <= (others => '0');
            pipe_acc_2      <= (others => '0');
            pipe_acc_3      <= (others => '0');
            pipe_acc_4      <= (others => '0');
            pipe_acc_5      <= (others => '0');

            din_13_a_i      <= (others => (others => '0'));
            din_13_b_i      <= (others => (others => '0'));
            pipe_din_13_a_0 <= (others => (others => '0'));
            pipe_din_13_b_0 <= (others => (others => '0'));
            pipe_din_13_a_1 <= (others => (others => '0'));
            pipe_din_13_b_1 <= (others => (others => '0'));
            pipe_din_13_a_2 <= (others => (others => '0'));
            pipe_din_13_b_2 <= (others => (others => '0'));
            pipe_din_13_a_3 <= (others => (others => '0'));
            pipe_din_13_b_3 <= (others => (others => '0'));
            pipe_din_13_a_4 <= (others => (others => '0'));
            pipe_din_13_b_4 <= (others => (others => '0'));
            pipe_din_13_a_5 <= (others => (others => '0'));
            pipe_din_13_b_5 <= (others => (others => '0'));


            din_2a_i    <= (others => '0');

        elsif rising_edge(clk) then

            pipe_acc_0  <= std_logic_vector(
                                resize(unsigned(din_2a_i), dout'length) + -- + 2A
                                resize(unsigned(din_13_a_i(0)) * unsigned(din_13_b_i(0)), dout'length) +
                                resize(unsigned(din_13_a_i(1)) * unsigned(din_13_b_i(1)), dout'length) 
                            );

            pipe_acc_1  <= std_logic_vector(
                                unsigned(pipe_acc_0) + 
                                resize(unsigned(pipe_din_13_a_0(2)) * unsigned(pipe_din_13_b_0(2)), dout'length) +
                                resize(unsigned(pipe_din_13_a_0(3)) * unsigned(pipe_din_13_b_0(3)), dout'length)
                            );

            pipe_acc_2  <= std_logic_vector(
                                unsigned(pipe_acc_1) + 
                                resize(unsigned(pipe_din_13_a_1(4)) * unsigned(pipe_din_13_b_1(4)), dout'length) +
                                resize(unsigned(pipe_din_13_a_1(5)) * unsigned(pipe_din_13_b_1(5)), dout'length)
                            );

            pipe_acc_3  <= std_logic_vector(
                                unsigned(pipe_acc_2) + 
                                resize(unsigned(pipe_din_13_a_2(6)) * unsigned(pipe_din_13_b_2(6)), dout'length) +
                                resize(unsigned(pipe_din_13_a_2(7)) * unsigned(pipe_din_13_b_2(7)), dout'length) 
                            );

            pipe_acc_4  <= std_logic_vector(
                                unsigned(pipe_acc_3) + 
                                resize(unsigned(pipe_din_13_a_3(8)) * unsigned(pipe_din_13_b_3(8)), dout'length) +
                                resize(unsigned(pipe_din_13_a_3(9)) * unsigned(pipe_din_13_b_3(9)), dout'length)
                            );


            pipe_acc_5  <= std_logic_vector(
                                unsigned(pipe_acc_4) + 
                                resize(unsigned(pipe_din_13_a_4(10)) * unsigned(pipe_din_13_b_4(10)), dout'length) +
                                resize(unsigned(pipe_din_13_a_4(11)) * unsigned(pipe_din_13_b_4(11)), dout'length)
                            );

            dout        <= std_logic_vector(
                                unsigned(pipe_acc_5) + 
                                resize(unsigned(pipe_din_13_a_5(12)) * unsigned(pipe_din_13_b_5(12)), dout'length)
                            );

            -- registering input
            din_13_a_i          <= din_13_a;
            din_13_b_i          <= din_13_b;
            din_2a_i            <= din_2a & '0'; -- left shift (2x)

            pipe_din_13_a_0     <= din_13_a_i; 
            pipe_din_13_b_0     <= din_13_b_i; 

            pipe_din_13_a_1     <= pipe_din_13_a_0; 
            pipe_din_13_b_1     <= pipe_din_13_b_0; 

            pipe_din_13_a_2     <= pipe_din_13_a_1; 
            pipe_din_13_b_2     <= pipe_din_13_b_1; 

            pipe_din_13_a_3     <= pipe_din_13_a_2; 
            pipe_din_13_b_3     <= pipe_din_13_b_2; 

            pipe_din_13_a_4     <= pipe_din_13_a_3; 
            pipe_din_13_b_4     <= pipe_din_13_b_3; 

            pipe_din_13_a_5     <= pipe_din_13_a_4; 
            pipe_din_13_b_5     <= pipe_din_13_b_4; 


        end if;
    end process;


end mac_parallel_13_pipelined_arc;