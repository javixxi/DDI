library ieee;
use ieee.std_logic_1164.all;

--entity
entity tb_contador_unos is
end entity;

--architecture
architecture test of tb_contador_unos is
	signal clk, an_rst	:	std_logic;
	signal e			:	std_logic;
	signal s			:	std_logic_vector(1 downto 0);
	constant t_clk		:	time:=100 ns;
begin

	dut: entity work.contador_unos(rtl)
		port map(	clk		=>	clk,
					an_rst	=>	an_rst,
					e		=>	e,
					s		=>	s
				);
	
	proceso_reloj: process
	begin
		clk <= '1';
		wait for t_clk/2;
		clk <= '0';
		wait for t_clk/2;
	end process;
	
	proceso_ejecucion: process
	begin
		an_rst <= '0';
		e <= '0';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		an_rst <= '1';
		wait until clk'event and clk = '1';
		e <= '1';
		wait until clk'event and clk = '1';
		e <= '0';		
		wait until clk'event and clk = '1';
		e <= '0';
		wait until clk'event and clk = '1';
		e <= '1';
		wait until clk'event and clk = '1';
		e <= '1';
		wait until clk'event and clk = '1';
		e <= '0';
		wait until clk'event and clk = '1';
		e <= '1';
		wait until clk'event and clk = '1';
		e <= '1';
		wait until clk'event and clk = '1';
		e <= '1';
		wait until clk'event and clk = '1';
		e <= '0';
		wait until clk'event and clk = '1';
		e <= '0';
		wait until clk'event and clk = '1';
		e <= '0';
		wait;
	end process;
end test;