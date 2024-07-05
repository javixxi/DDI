library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity conformador is
	port(	clk	:	in std_logic;
			nRst:	in std_logic;
			e	:	in std_logic;
			s	:	buffer std_logic
		);
end entity;

--architecture
architecture rtl of conformador is
	signal Q :	std_logic;
begin

	FlipFlop:	process(clk, nRst)
	begin
		if nRst = '0' then 
			Q <= '0';
		
		elsif clk'event and clk = '1' then
			Q <= e;
		end if;
	end process;

	Comparador:	process(e, Q)
	begin
		if e = '1' and Q = '0' then
			s <= '1';
		else
			s <= '0';
		end if;
	end process;
end rtl;