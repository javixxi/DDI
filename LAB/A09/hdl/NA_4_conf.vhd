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
  signal no_unos: std_logic_vector(2 downto 0);			

begin
  --Sentencia concurrente 1 
  aux_0 <= "00" when ent(1 downto 0) = "00" else		--Antes teniamos '0' que se usa para se�ales o entradas del tipo std_logic, lo modificamos para _vector con "00"
           "10" when ent(0) = ent(1)     else                     
           "01" when ent(0) /= ent(1);
  --
		   
  --Sentencia concurrente 2
  aux_1 <= ('0' & ent(3)) + ent(2);						--Sumamos a�adiendo un bit mas para as� poder obtener todos los valores de la suma (ej:10 + 10 = 1_00)
														--Tambi�n podriamos haber creado aux_1 como (2 downto 0)
														
  -- La sentencia concurrente 1 y 2 modelan el mismo circuito, ante la misma convinaci�n de entradas obtenemos la misma salida.
		-- concurrente 1: realiza la asignaci�n analinando cada entrada y dando su valor a la salida.
		-- concurrente 2: realiza la asignaci�n sumando los bits y obteniendo ek numero de unos
  -- Cr�tica: el uso de 2 sentencias concurrentes para localizar el n�mero de unos que presenta la entrada, sum�ndole una mas para determinar el numero de unos total genera 3 procesos con las correspondientes se�ales que se han tenido que generar, pudiendo hacer solo 1 sumando los bits de la entrada en una sola salida
  
  no_unos <= ('0' & aux_0) + aux_1;

  sal <= 	'1' when (umbral /= "00") and (no_unos > umbral) else		-- El operador para definir "distinto de" es /= no !=
			'0';

end rtl; 


