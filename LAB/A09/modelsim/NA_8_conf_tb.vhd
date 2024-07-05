library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity NA_8_conf_tb is
end entity;

architecture test of NA_8_conf_tb is
	signal umbral	:	std_logic_vector(2 downto 0);
	signal ent		:	std_logic_vector(7 downto 0);
	signal sal		:	std_logic;

begin

	dut: entity work.NA_8_conf(rtl)
	port map(	umbral => umbral,
				ent => ent,
				sal => sal);
	
	process
	begin
		
		umbral <= "000";
		ent <= "00000000";
		wait for 1 ns;
		for i in 0 to 7 loop
			for j in 0 to 31 loop
				ent <= ent + 1;
				wait for 1 ns;
			end loop;
			umbral <= umbral + 1;
			wait for 1 ns;
		end loop;
	end process;
	
end test;