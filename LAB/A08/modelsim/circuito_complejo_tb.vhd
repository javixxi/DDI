library ieee;
use ieee.std_logic_1164.all;

--entity
entity circuito_complejo_tb is
end entity;

--architecture
architecture test of circuito_complejo_tb is
	signal clk, a_rst						:	std_logic;
	signal p_1, p_2							:	std_logic;
	signal l0, l1, l2, l3, l4, l5, l6, l7	:	std_logic;
	signal segDisp							:	std_logic_vector (6 downto 0);
	constant tclk: time					:=	100 ns;
begin
	
	dut: entity work.circuito_complejo(rtl)
		port map(	clk => clk,
					a_rst => a_rst,
					p_1 => p_1, p_2 => p_2,					
					l0 => l0, l1 => l1, l2 => l2, l3 => l3, l4 => l4, l5 => l5, l6 => l6, l7 => l7,
					segDisp => segDisp
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
		a_rst <= '1';
		p_1 <= '0';
		p_2 <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		a_rst <= '0';
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
		p_2 <= '1';
		wait until clk'event AND clk = '1';
		p_2 <= '0';
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
		p_1 <= '1';
		wait until clk'event AND clk = '1';
		p_1 <= '0';
		wait until clk'event AND clk = '1';
		p_2 <= '1';
		wait until clk'event AND clk = '1';
		p_2 <= '0';
		wait until clk'event AND clk = '1';
		p_2 <= '1';
		wait until clk'event AND clk = '1';
		p_2 <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		p_1 <= '1';
		wait until clk'event AND clk = '1';
		p_1 <= '0';
		wait until clk'event AND clk = '1';
		p_2 <= '1';
		wait until clk'event AND clk = '1';
		p_2 <= '0';
		wait until clk'event AND clk = '1';
		p_2 <= '1';
		wait until clk'event AND clk = '1';
		p_2 <= '0';
		wait;
	end process;

end test;