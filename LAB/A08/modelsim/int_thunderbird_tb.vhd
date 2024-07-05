library ieee;
use ieee.std_logic_1164.all;

--entity
entity int_thunderbird_tb is
end entity;

--architecture
architecture test of int_thunderbird_tb is
	signal clk, n_rst	:	std_logic;
	signal L, R			:	std_logic;
	signal LC, LB, LA	:	std_logic;
	signal RA, RB, RC	:	std_logic;
	constant tclk : time:= 100 ns;
begin

	dut: entity work.int_thunderbird(rtl)
		port map(	clk		=>	clk,
					n_rst	=>	n_rst,
					L		=>	L,
					R		=>	R,
					LC		=>	LC,
					LB		=>	LB,
					LA		=>	LA,
					RA		=>	RA,
					RB		=>	RB,
					RC		=>	RC
				);
				
	Proceso_reloj:
	process
	begin
		clk <= '1';
		wait for tclk;
		clk <= '0';
		wait for tclk;
	end process;
	
	proceso_test:
	process
	begin
		n_rst <= '0';
		L <= '0';
		R <= '0';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		n_rst <= '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		L <= '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		R <= '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		L <= '0';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		wait;
	end process;
end test;
		