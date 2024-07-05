library ieee;
use ieee.std_logic_1164.all;

--entity
entity tb_dff_ser is
end entity;

--architecture
architecture test of tb_dff_ser is
	signal nRST:		std_logic;
	signal clk:			std_logic;
	signal nSet_syn:	std_logic;
	signal ena:			std_logic;
	signal rst_syn:		std_logic;
	signal D:			std_logic;
	signal Q:			std_logic;
	constant tclk : time := 100 ns;
	
begin
	dut: entity work.dff_ser(rtl) 
	port map(	--Port => signal
				nRST 		=> nRST,
				clk 		=> clk,
				nSet_syn	=> nSet_syn,
				ena			=> ena,
				rst_syn		=> rst_syn,
				D			=> D,
				Q			=> Q
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
		nRST <= '0';
		nSet_syn <= '1';
		ena <= '1';
		rst_syn <= '0';
		D <= '1';
		
		wait until clk'event and clk = '1'; --Preguntar por que es necesario poner 2 (no empieza en clk=0 si no que empieza en clk=1)
		wait until clk'event and clk = '1';
		nRST <= '1';
		
		wait until clk'event and clk = '1';
		D <= '0';
		
		wait until clk'event and clk = '1';
		D <= '1';
		
		wait until clk'event and clk = '1';
		D <= '0';
		ena <= '0';
		
		wait until clk'event and clk = '1';
		D <= '1';
		rst_syn <= '1';
		
		wait until clk'event and clk = '1';
		ena <= '1';
		
		wait until clk'event and clk = '1';
		D <= '0';
		nSet_syn <= '0';
		
		wait until clk'event and clk = '1';
		nSet_syn <= '1';
		wait;
	end process;
end test;