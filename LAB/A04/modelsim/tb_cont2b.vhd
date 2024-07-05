library ieee;
use ieee.std_logic_1164.all;

--entity
entity tb_cont2b is
end entity;

--architecture
architecture test of tb_cont2b is
	signal clk	:	std_logic;
	signal nRst	:	std_logic;
	signal Q	:	std_logic_vector (1 downto 0);
	constant tclk: time := 100 ns;
begin
	dut: entity work.cont2b(rtl)
		port map(	--port => signal;
					clk		=>	clk,
					nRst	=>	nRst,
					Q		=>	Q
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
		Q <= "00";
		
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		nRst <= '1';
		wait;
	end process;

end test;
		