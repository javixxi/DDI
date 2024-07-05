library ieee;
use ieee.std_logic_1164.all;

entity decod_4_a_16 is
	port(	ena: in std_logic;
				Din: in std_logic_vector(3 downto 0);
				Dout: buffer std_logic_vector(15 downto 0));
end entity;

architecture rtl of decod_4_a_16 is
begin
	process(ena, Din)
	begin
		if ena = '1' then
			case Din is
				when "0000" =>
					Dout <= x"0000";
				when "0001" =>
					Dout <= x"0001";
				when "0010" =>
					Dout <= x"0002";
				when "0011" =>
					Dout <= x"0004";
				when "0100" =>
					Dout <= x"0008";
				when "0101" =>
					Dout <= x"0010";
				when "0110" =>
					Dout <= x"0020";
				when "0111" =>
					Dout <= x"0040";
				when "1000" =>
					Dout <= x"0080";
				when "1001" =>
					Dout <= x"0100";
				when "1010" =>
					Dout <= x"0200";
				when "1011" =>
					Dout <= x"0400";
				when "1100" =>
					Dout <= x"0800";
				when "1101" =>
					Dout <= x"1000";
				when "1110" =>
					Dout <= x"2000";
				when "1111" =>
					Dout <= x"4000";
				when others =>
					Dout <= (others => 'X');
			end case;
		else
			Dout <= x"0000";
		end if;
end process;
end rtl;
