library ieee;
use ieee.std_logic_1164.all;

--entity
entity dff_ser is
	port(	nRST: 		in std_logic; --activo a nivel bajo
			nSet_syn: 	in std_logic; --activo a nivel bajo
			clk:		in std_logic;
			ena:		in std_logic; --activo a nivel alto
			rst_syn:	in std_logic; --activo a nivel alto
			D:			in std_logic;
			Q:			buffer std_logic
		);
end entity;

--architecture
architecture rtl of dff_ser is
begin
	
	process(clk, nRST)
		begin
		if nRST = '0' then
			Q <= '0';
			
		elsif clk'event and clk = '1' then
			if nSet_syn = '0' then
				Q <= '1';
			
			elsif ena = '1' then
				if rst_syn = '1' then
					Q <= '0';
				
				else
					Q <= D;
					
				end if;
			end if;
		end if;
	end process;
end rtl;