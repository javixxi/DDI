-- Autor: DTE
-- Fecha: 9-9-2016
-- Sumador de 8 bits con acarreo de entrada y salida y salida OV
-- Versión 1.1

library ieee;                    
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity sum8bits is             
port(
     C_in:  in     std_logic;
     A:     in     std_logic_vector(7 downto 0);
	   B:     in     std_logic_vector(7 downto 0);
	   S:     buffer std_logic_vector(7 downto 0)
    );
end entity; 

architecture rtl of sum8bits is
begin
    S <= A + B + C_in;
    
end rtl;