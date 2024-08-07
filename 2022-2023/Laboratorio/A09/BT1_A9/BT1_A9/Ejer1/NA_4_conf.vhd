-- Modelo VHDL sintetizable de una neurona artificial configurable con cuatro entradas
-- La salida se activa cuando:
--   umbral vale 01 y el numero de unos en la entrada es mayor que 1
--   umbral vale 10 y el numero de unos en la entrada es mayor que 2
--   umbral vale 11 y el numero de unos en la entrada es mayor que 3

-- Cuando umbral vale 00 la salida est� inactiva

-- Version: 1.0
-- Fecha:   17-09-2021
-- Autor:   The mothers of Invention
 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity NA_4_conf is
port(umbral: in     std_logic_vector(1 downto 0);
     ent:    in     std_logic_vector(3 downto 0);
     sal:    buffer std_logic);

end entity;

architecture rtl of NA_4_conf is
  signal aux_0:   std_logic_vector(1 downto 0);
  signal aux_1:   std_logic_vector(1 downto 0);
  signal no_unos: std_logic_vector(1 downto 0);

begin
  --Sentencia concurrente 1 
  aux_0 <= "00" when ent(1 downto 0) = '0' else
           "10" when ent(0) = ent(1)     else                     
           "01" when ent(0) /= ent(1);
  --
		   
  --Sentencia concurrente 2
  aux_1 <= ent(3) + ent(2);                                      
  --
  
  no_unos <= aux_0 + aux_1;

  sal <= '1' when umbral != 0 and no_unos > umbral;

end rtl; 


