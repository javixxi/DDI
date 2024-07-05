--Clausulas de visibilidad
library ieee;
use ieee.std_logic_1164.all;

--Declaracion de la entidad
entity tb_decod3a8n is
end entity;

--Declaracion de la arquitectura
architecture test of tb_decod3a8n is
	signal n_E: std_logic_vector (1 downto 0);
	signal n_S: std_logic_vector (3 downto 0);
	
	begin
		dut:	entity work.decod3a8n(rtl)
				port map(	-- Puerto => Señal
							n_E => n_E,
							n_S => n_s
						);
		
		process
			begin
				n_E <= "00";
				wait for 100 ns;
				n_E <= "01";
				wait for 100 ns;
				n_E <= "10";
				wait for 100 ns;
				n_E <= "11";
				wait;
		end process;
end test;
				