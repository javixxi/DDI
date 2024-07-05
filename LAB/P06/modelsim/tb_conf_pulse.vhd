library ieee;
use ieee.std_logic_1164.all;

--entity
entity tb_conf_pulse is
end entity;

--architecture
architecture test of tb_conf_pulse is
	signal clk		:	std_logic;
	signal an_rst	:	std_logic;
	signal e		:	std_logic;
	signal s		:	std_logic;
	constant tclk: time:= 100 ns;
begin

	dut: entity work.conf_pulse(rtl)
		port map(	clk => clk,
					an_rst => an_rst,
					e => e,
					s => s
				);

	process_clock: process
	begin
		clk <= '1';
		wait for tclk/2;
		clk <= '0';
		wait for tclk/2;
	end process;
	
	process
	begin
		an_rst <= '0';
		e <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		an_rst <= '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		e <= '1';
		wait until clk'event AND clk = '1';
		e <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		e <= '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		e <= '0';
		wait;
	end process;
end test;
		