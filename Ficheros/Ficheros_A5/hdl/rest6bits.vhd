-- Autor: DTE
-- Fecha: 9-9-2016
-- Modelo de restador de 6 bits con acarreo de entrada y salida y salida OV
-- Versi�n 1.1

library ieee;                    
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity rest6bits is             
port(
     B_in:  in     std_logic;
     A:     in     std_logic_vector(5 downto 0);
	   B:     in     std_logic_vector(5 downto 0);
	   R:     buffer std_logic_vector(5 downto 0);
	   B_out: buffer std_logic;
	   OV:    buffer std_logic
    );
end entity; 

architecture rtl of rest6bits is
  signal R_aux: std_logic_vector(6 downto 0);
  
begin

    R_aux <= ('0' & A) + ('0' & (not B)) + B_in;
    B_out <= R_aux(6);
    R <= R_aux(5 downto 0);
    
    OV <= '1' when (A(5) /= B(5)) and (A(5) /= R(5))
          else '0';
    
end rtl;