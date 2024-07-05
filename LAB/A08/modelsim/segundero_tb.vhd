library ieee;
use ieee.std_logic_1164.all;

--entity
entity	segundero_tb is
end entity;

--architecture
architecture test of segundero_tb is
	signal clk			: 	std_logic;
    signal nRst			: 	std_logic;
    signal nreset		:	std_logic;
    signal ena			:	std_logic;
    signal Q			:   std_logic_vector(7 downto 0);
	constant tclk: time					:=	100 ns;
begin

	dut: entity work.segundero(rtl)
		port map(	clk		=>	clk,
					nRst	=>	nRst,
					nreset	=>	nreset,
					ena		=>	ena,
					Q		=>	Q
				);
				
	Proceso_reloj:
	process
	begin
		clk <= '1';
		wait for tclk/2;
		clk <= '0';
		wait for tclk/2;
	end process;
	
	Proceso_test:
	process
	begin
		nRst <= '0';
		nreset <= '0';
		ena <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		nRst <= '1';
		wait until clk'event AND clk = '1';
		nreset <= '1';
		wait until clk'event AND clk = '1';
		ena <= '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		ena <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		ena <= '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		nreset <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait;
	end process;

end test;