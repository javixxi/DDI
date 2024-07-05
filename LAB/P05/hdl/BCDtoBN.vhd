-- Autor: DTE
-- fecha: 9-9-2016
-- Modelo de un conversor de BCD a binario natural 
-- Versi�n 1.1

library ieee;                    
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity BCDtoBN is             
port(
     unidades:    in     std_logic_vector(3 downto 0);
     decenas:     in     std_logic_vector(3 downto 0);
	   centenas:    in     std_logic_vector(3 downto 0);
	   num_bn_div8: buffer std_logic_vector(6 downto 0)
    );
end entity; 

architecture rtl of BCDtoBN is
  signal S1_aux: std_logic_vector(6 downto 0);
  signal S2_aux: std_logic_vector(9 downto 0);
begin
    -- S1_aux <= 10*centenas + decenas
    S1_aux <= (centenas & "000") + (centenas &  '0') + decenas;

    -- S2_aux <= 10*(10 centenas + decenas) + unidades
    S2_aux <= (S1_aux & "000") + (S1_aux &  '0') + unidades;

    -- num_bn_div8 <= (100*centenas + 10*decenas + unidades)/8   
    num_bn_div8 <= S2_aux(9 downto 3);

end rtl;