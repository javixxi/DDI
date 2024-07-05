library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity tb_div_freq_4 is
end entity;

--architecture
architecture test of tb_div_freq_4 is
	signal	clk			:	std_logic;
	signal nRst			:	std_logic;
	signal freq_div_4	:	std_logic;
	constant tclk : time:= 100 ns;
begin
	
	dut: entity work.div_freq_4(rtl)
		port map(	--port => signal
					clk => clk,
					nRst => nRst,
					freq_div_4 => freq_div_4
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
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		nRst <= '1';
		wait;
	end process;
	
end test;