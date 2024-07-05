library ieee;
use ieee.std_logic_1164.all;

--entity
entity tb_conformador is
end entity;

--architecture
architecture test of tb_conformador is
	signal clk 	:	std_logic;
	signal nRst	:	std_logic;
	signal e	:	std_logic;
	signal s	:	std_logic;
	constant tclk: time:=	100 ns;
begin
	dut:	entity work.conformador(rtl)
		port map(	--port <= signal;
					clk 	=>	clk,
					nRst 	=>	nRst,
					e		=>	e,
					s		=>	s
				);
	
	process
	begin
		clk <= '1';
		wait for tclk/2;
		clk <= '0';
		wait for tclk/2;
	end process;
	
	process
	begin
		nRst <= '0';
		e <= '0';
		
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		nRst <= '1';
		e <= '1';
		
		wait until clk'event and clk = '1';
		e <= '0';
		wait until clk'event and clk = '1';
		e <= '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		e <= '0';
		wait;
	end process;
end test;
		