library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divisor_3 is
port(clk:       in     std_logic;
     nRst:      in     std_logic;
     f_div_250: buffer std_logic;
     f_div_125: buffer std_logic;
     f_div_50:  buffer std_logic);
end entity;

architecture rtl of divisor_3 is
  signal cnt_div_250: std_logic_vector(5 downto 0);
  signal ff_div_125 : std_logic;
  signal cnt_div_50 : std_logic_vector(2 downto 0);
begin
  -- Complete la descripción del circuito
  



end rtl;