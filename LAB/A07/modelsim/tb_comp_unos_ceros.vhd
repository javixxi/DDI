library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity tb_comp_unos_ceros is
end entity;

--architecture
architecture test of tb_comp_unos_ceros is
	signal e	: std_logic_vector(3 downto 0);
	signal s	: std_logic;
begin
	
	dut: entity work.comp_unos_ceros(rtl)
		port map(	e => e,
					s => s
				);
	process
	begin
		e <= "0000";
		wait for 100 ns;
		
		for i in 0 to 15 loop
			e <= e + 1;
			wait for 100 ns;
		end loop;
		wait;
	end process;
	
end test;