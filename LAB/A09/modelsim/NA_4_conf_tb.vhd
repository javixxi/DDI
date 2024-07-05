library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity NA_4_conf_tb is
end entity;

architecture test of NA_4_conf_tb is
	signal umbral	:	std_logic_vector(1 downto 0);
	signal ent		:	std_logic_vector(3 downto 0);
	signal sal		:	std_logic;

begin

	dut: entity work.NA_4_conf(rtl)
	port map(	umbral => umbral,
				ent => ent,
				sal => sal);
	
	process
	begin
		
		umbral <= "00";
		ent <= "0000";
		wait for 100 ns;
		for i in 0 to 3 loop
			for j in 0 to 15 loop
				ent <= ent + 1;
				wait for 100 ns;
			end loop;
			umbral <= umbral + 1;
			wait for 100 ns;
		end loop;
	end process;
	
end test;