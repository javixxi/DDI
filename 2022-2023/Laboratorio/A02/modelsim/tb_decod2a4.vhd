-- Test Bencho de un decodificador 
-- BCD 2 a 4 realizado para el tutorial
-- de la actividad 2
-- (21-09-2022)

-- Clausulas de visibilidad
library ieee;
use ieee.std_logic_1164.all;

-- Declaracion de una entidad sin puertos
entity tb_decod2a4 is
end entity;

architecture test of tb_decod2a4 is
  signal E: std_logic_vector (1 downto 0);
  signal S: std_logic_vector (3 downto 0);
begin

  dut:  entity Work.decod2a4(rtl)
	port map( E => E,
		  S => S);

process
begin
  E <= "00";
  wait for 100 ns;
  E <= "01";
  wait for 100 ns;
  E <= "10";
  wait for 100 ns;
  E <= "11";
  wait for 100 ns;
  wait;
end process;

end test;