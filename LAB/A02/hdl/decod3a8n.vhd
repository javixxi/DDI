--clausulas de visibilidad
library ieee;
use ieee.std_logic_1164.all;

--Definicion de la entidad
entity decod3a8n is
	port(	n_E: in std_logic_vector (1 downto 0);
			n_S: buffer std_logic_vector (3 downto 0)
		);
end entity;

architecture rtl of decod3a8n is
begin
	process(n_E)
	begin
		case n_E is
			when "00" =>
				n_S <= "0001";
			when "01" =>
				n_S <= "0010";
			when "10" =>
				n_S <= "0100";
			when "11" =>
				n_S <= "1010";
			when others =>
				n_S <= "XXXX";
		end case;
	end process;
end rtl;
	