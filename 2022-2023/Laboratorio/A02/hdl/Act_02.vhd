-- Modelo de un decodificador 2 a 4
-- realizado en la actividad 2 de DD1
-- Por Javier Garc�a Moreno
-- (21-09-2022)

-- Cabecera: clausulas de visibilidad
library ieee;
use ieee.std_logic_1164.all;

-- Entidad: Unidad primaria de la declaracion de la entidad.
entity decod2a4 is
port(
  E: in 	std_logic_vector(1 downto 0);
  S: buffer 	std_logic_vector(3 downto 0));
end entity;


-- Arquitectura: unidad secundaria asociadaa una
--declaracion de entidad (decod4a2)
architecture rtl of decod2a4 is
  begin
    process(e)
    begin
	if E = "00" then S <= "0001";
	elsif E = "01" then S <= "0010";
	elsif E = "10" then S <= "0100";
	elsif E = "11" then S <= "1000";
    end if;
  end process;
end rtl;