-- Test-bench de un decodificador
-- BCD a 7 segmentos realizado para
-- el tutorial de la actividad AINP4
-- (TBC)

-- Clausulas de visibilidad
library ieee;
use ieee.std_logic_1164.all;

-- Declaracion de entidad sin puertos
entity tb_decodBCD7seg is
end entity;

architecture test of tb_decodBCD7seg is
  signal digBCD: 	std_logic_vector (3 downto 0);
  signal segDisp: 	std_logic_vector (6 downto 0);
begin
  dut: entity Work.decodBCD7seg(rtl)
       port map( --	Puerto => señal
					digBCD => digBCD,
					segDisp => segDisp
                );
                                
  process
  begin                                        -- (3) Est�mulos
    digBCD <= "0000";  -- En T = 0 ns
    wait for 100 ns;  
    digBCD <= "0001";  -- En T = 100 ns
    wait for 100 ns;  
    digBCD <= "0010";
	wait for 100 ns;
	digBCD <= "0011";
	wait for 100 ns;
	digBCD <= "0100";
	wait for 100 ns;
	digBCD <= "0101";
	wait for 100 ns;
	digBCD <= "0110";
	wait for 100 ns;
	digBCD <= "0111";
	wait for 100 ns;
	digBCD <= "1000";
	wait for 100 ns;
	digBCD <= "1001";
	wait;	
  end process;               
end test;