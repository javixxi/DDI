-- Autor: M. Garrido
-- Fecha: TBC
-- Contador BCD con conformador para habilitacion y salida con descodificador de BCD a 7 segmentos

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cont_bcd_7seg_habcp is
  port (an_rst		: in std_logic;
        clk         : in std_logic;
        pulso_hab   : in std_logic;
        disp7seg    : buffer std_logic_vector(6 downto 0));

end entity cont_bcd_7seg_habcp;

--architecture
architecture rtl of cont_bcd_7seg_habcp is
	signal conf_aux		: std_logic;
	signal pulso		: std_logic;
	signal fdc			: std_logic;
	signal cuenta		: std_logic_vector(3 downto 0);

begin

	conformador: process (clk, an_rst)
	begin
		
		if an_rst = '0' then
			conf_aux <= '0';
			
		elsif clk'event AND clk = '1' then
				conf_aux <= pulso_hab;
		end if;
	end process conformador;

	pulso <=	'1' when pulso_hab = '0' AND conf_aux = '1' else
				'0';
				
			
	contador: process (clk, an_rst)
	begin
	
		if an_rst = '0' then
			cuenta <= X"0";
		elsif clk'event AND clk = '1' then
			if pulso = '1' then
				if fdc = '1' then
					cuenta <= X"0";
				else
					cuenta <= cuenta + 1;
				end if;
			end if;
		end if;
	end process contador;
	
	fdc <= 	'1' when cuenta = "1001" else
			'0';
					
				
	disp7seg <= "0000001" when cuenta = "0000" else
				"1001111" when cuenta = "0001" else
				"0010010" when cuenta = "0010" else
				"0000110" when cuenta = "0011" else
				"1001100" when cuenta = "0100" else
				"0100100" when cuenta = "0101" else
				"0100000" when cuenta = "0110" else
				"0001111" when cuenta = "0111" else
				"0000000" when cuenta = "1000" else
				"0001100" when cuenta = "1000" else
				"-------";
end rtl;