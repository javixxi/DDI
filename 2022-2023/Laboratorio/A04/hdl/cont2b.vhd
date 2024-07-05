-- Autor: DTE
-- Fecha: 24-09-2022
-- Modelo de un contador de 2 bits realizado para la actividad 4
-- del  bloque I de Diseño digital I
-- versión 1.1 


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cont2b is
port(
     clk:  in std_logic;
     nRST: in std_logic;
     Q:    buffer std_logic_vector(1 downto 0)
     ); 
end entity;


architecture rtl of cont2b is
begin
  
  
  process(clk, nRST)
  begin  
    if nRST = '0' then
       Q <= "11";
    elsif clk'event and clk = '1' then
       Q <= Q - 1; 
    end if;              
  end process;

end rtl;


