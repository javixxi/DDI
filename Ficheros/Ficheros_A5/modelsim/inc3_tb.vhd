-- Autor: DTE
-- Fecha: 9-9-2016
-- Test-Bench del sumador de 5 bits con una constante de valor 3 
-- Versión 1.1

library ieee;                    
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity inc_3_tb is             
end entity; 

architecture test of inc_3_tb is
  signal A: std_logic_vector(4 downto 0);
	signal S: std_logic_vector(4 downto 0);

begin  
  dut: entity work.inc_3(rtl)
  port map(
           A => A,
           S => S);
    
  process
  begin
    A <= (others => '0');
    -- Completar con bucle FOR
    
  end process;  
end test;