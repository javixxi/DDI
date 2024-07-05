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

entity NA_8_conf is
port(umbral: in     std_logic_vector(3 downto 0);
     ent:    in     std_logic_vector(7 downto 0);
     sal:    buffer std_logic);

end entity;

architecture rtl of NA_8_conf is
  signal no_unos: std_logic_vector(2 downto 0);

begin
  
  no_unos <= ("000" & ent(7)) + ent(6) + ent(5) + ent(4) + ent(3) + ent(2) + ent(1) + ent(0);

  sal <= 	'1' when (umbral /= "000") and (no_unos > umbral) else		-- El operador para definir "distinto de" es /= no !=
			'0';

end rtl; 


