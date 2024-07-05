library ieee;
use ieee.std_logic_1164.all;

--entity 
entity tb_mult3 is
end entity;

--architecture
architecture test of tb_mult3 is
	signal clk		:	std_logic;
	signal an_rst	:	std_logic;
	signal e		:	std_logic;
	signal s		:	std_logic;
	constant tclk: time:= 100 ns;
begin
	
	dut: entity work.mult3(rtl)
		port map(	clk 	=> clk,
					an_rst	=> an_rst,
					e		=> e,
					s		=> s
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
		e <= '0';
		an_rst <= '0';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		an_rst <= '1';
		wait until clk'event and clk = '1';
		e <= '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		e <= '0';
		wait until clk'event and clk = '1';
		e <= '1';
		wait until clk'event and clk = '1';
		e <= '0';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait;
	end process;
end test;