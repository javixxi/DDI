library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_NA_4_conf is
end entity;

architecture test of tb_NA_4_conf is
	signal umbral:	std_logic_vector(1 downto 0);
	signal ent:			std_logic_vector(3 downto 0);
	signal sal:			std_logic; 
	constant T_CLK : time := 100 ns;
begin

	DUT: entity work.NA_4_conf(rtl) port map(
		umbral	=> umbral,
		ent			=> ent,
		sal			=> sal);

	estimulos: process
	begin
		umbral <= "00";
		ent <= "0000";
		wait for T_CLK;
		wait for T_CLK;
		umbral <= "01";
		ent <= "0011";
		wait for T_CLK;
		wait for T_CLK;
		umbral <= "10";
		ent <= "0011";
		wait for T_CLK;
		wait for T_CLK;
		umbral <= "11";
		ent <= "0111";
		wait for T_CLK;
		wait for T_CLK;
		umbral <= "11";
		ent <= "1111";
		wait for T_CLK;
		wait for T_CLK;
		wait;
	end process;

end test;
	