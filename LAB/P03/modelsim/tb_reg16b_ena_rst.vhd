library ieee;
use ieee.std_logic_1164.all;

--entidad
entity tb_reg16b_ena_rst is
end entity;

--architecture
architecture test of tb_reg16b_ena_rst is
	signal sRST: 	std_logic;
	signal ENA:		std_logic;
	signal clk: 	std_logic;
	signal nRST:	std_logic;
	signal Din:		std_logic_vector (15 downto 0);
	signal Dout:	std_logic_vector (15 downto 0);
	constant tclk:	time:= 100 ns;
	
begin
	dut: entity work.reg16b_ena_rst(rtl)
		port map(	-- Port => Signal
					sRST	=> sRST,
					ENA		=> ENA,
					clk		=> clk,
					nRST	=> nRST,
					Din		=> Din,
					Dout	=> Dout
				);
				
	process 
	begin
		clk <= '0';
		wait for tclk/2;
		clk <= '1';
		wait for tclk/2;
	end process;
	
	process
	begin
		nRST <= '0';
		sRST <= '0';
		ENA <= '0';
		Din <= X"0000";
		
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		nRST <= '1';
		ENA <= '1';
		Din <= X"AAAA";
		
		wait until clk'event and clk = '1';
		sRST <= '1';
		
		wait until clk'event and clk = '1';
		sRST <= '0';
		Din <= X"5555";
		
		wait until clk'event and clk = '1';
		ENA <= '0';
		Din <= X"1234";
		
		wait until clk'event and clk = '1';
		sRST <= '1';
		
		wait until clk'event and clk = '1';
		wait;
	end process;
end test;