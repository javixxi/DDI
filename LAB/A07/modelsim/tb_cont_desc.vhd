library ieee;
use ieee.std_logic_1164.all;

--entity
entity tb_cont_desc is
end entity;

--architecture
architecture test of tb_cont_desc is
	signal clk, an_rst	:	std_logic;
	signal rst			:	std_logic;
	signal s			:	std_logic_vector(15 downto 0);
	constant tclk		:	time := 100 ns;
begin
	dut: entity work.cont_desc(rtl)
		port map(	--port => signal;
					clk		=>	clk,
					an_rst	=>	an_rst,
					rst		=>	rst,
					s		=>	s
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
		an_rst 	<= '0';
		rst 	<= '0';
		s 		<= X"FFFF";
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		an_rst 	<= '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		rst 	<= '1';
		wait until clk'event and clk = '1';
		wait until clk'event and clk = '1';
		rst 	<= '0';
		wait;
	end process;

end test;
		