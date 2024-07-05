-- Modelo de un divisor de frecuancia entre 4
-- realizado para la practica 4
-- del bloque I de DDI
-- 29-09-2022 version 1.0 por Javier Garcia Moreno

-- cabecera: de las clausulas de visibilidad
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entidad: Unidad primaria que modela la interfaz
entity div_freq_4 is
port(
	clk:		in std_logic;
	nRST:		in std_logic;
	freq_div_4:	buffer std_logic
	);
end entity;

-- Arquitectura: Unidad primaria que declara el comportamiento
architecture rtl of div_freq_4 is
  signal Q_i: std_logic_vector(1 downto 0);

begin
  -- Proceso que modela el funcionamiento del contador
  process (clk, nRST)
  begin
    if nRST = '0' then
      Q_i <= "00";

    elsif clk'event and clk = '1' then
      Q_i <= Q_i + 1;

    end if;
  end process;

  freq_div_4 <= '1' when Q_i=3 else
		'0';


  -- Proceso que detecta el estado de cuenta a 3
--  process (Q_i)
--  begin
--    if Q_i = 3 then
--      freq_div_4 <= '1';
--
--    else
--      freq_div_4 <= '0'; 
--
--    end if;
--  end process;

end rtl;
