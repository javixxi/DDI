library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity div_100 is
port( 
  E : in std_logic_vector(7 downto 0);
  C : buffer std_logic_vector(1 downto 0);
  R : buffer std_logic_vector(6 downto 0)
);
end entity;

architecture rtl of div_100 is
signal R_aux : std_logic_vector(7 downto 0);
begin

C <= "00" when E < 100 else
     "01" when E < 200 else
     "10";

R_aux <= E when C = "00" else
         E - 100 when C = "01" else
         E - 200;

R <= R_aux(6 downto 0);

end rtl;
