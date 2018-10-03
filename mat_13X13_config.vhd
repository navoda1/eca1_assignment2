-- ---------------------------------------------------------------------------------------------------------------------------------
-- Name			: mat_13x13_config
-- Author		: Chirag, Navoda, Megha
-- Description	: 13x13 Matrix array type declaration. 
--				  Input Matrix	: 8 bit
--				  Output Matrix	: 24 bit(?????) 
-- ---------------------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package mat_13x13_config is

   type mat_in_13x13	is array(integer range 0 to 12, integer range 0 to 12) of std_logic_vector(7 downto 0);
   type mat_out_13x13	is array(integer range 0 to 12, integer range 0 to 12) of std_logic_vector(18 downto 0);


end  mat_13x13_config;