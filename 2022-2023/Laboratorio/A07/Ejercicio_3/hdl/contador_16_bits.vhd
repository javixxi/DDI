-- Contador de 16 bits descandente
-- con entrada reset asincrona de nivel alto
-- realizado para el ejercicio 3 de la actividad 7
-- (10-10-2022) versi�n 1.0

-- Clausulas de visibilidad
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Definicion de la entidad
entity contador_16_bits is
port(	clk: 	in std_logic;
	n_rst: 	in std_logic;
	Q:	buffer std_logic_vector(15 downto 0)
	);
end entity;

-- Definicion de la arquitectura
architecture rtl of contador_16_bits is
begin
  process(clk, n_rst)
  begin
    if n_rst = '1' then
      Q <= "1111111111111111";
    elsif clk'event and clk = '1' then
      Q <= Q - 1;
    end if;
  end process;
end rtl;