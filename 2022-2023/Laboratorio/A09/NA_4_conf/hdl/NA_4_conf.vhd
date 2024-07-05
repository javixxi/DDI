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
  --Sentencia concurrente 1: Se cambia el condicional de '0' a "00" 
  aux_0 <= "00" when ent(0)='0' AND ent(1)='0' else
           "10" when ent(0) = ent(1)     else                     
           "01" when ent(0) /= ent(1);
  --
		   
  --Sentencia concurrente 2: Ponemos las mismas condiciones que en la sentencia anterior
  aux_1 <= "00" when ent(2)='0' AND ent(3)='0' else
           "10" when ent(2) = ent(3)     else                     
           "01" when ent(2) /= ent(3);                                      
  --
  -- no hace la suma correcta de 10 + 10
  no_unos <= 	aux_0 + aux_1;

	-- A�adimos el else para que se contemplen todas las opciones
  sal <= '1' when umbral /= "00" and no_unos > umbral else
				 '0';

end rtl; 


