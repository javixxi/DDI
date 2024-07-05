library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity	NA_32_seq_conf_tb is
end entity;

--architecture
architecture test of NA_32_seq_conf_tb is
	signal clk		: 	std_logic;
    signal nRst		: 	std_logic;
	signal start	:	std_logic;
	signal umbral	:	std_logic_vector(4 downto 0);
	signal ent		:	std_logic_vector(31 downto 0);
	signal fin		:	std_logic;
	signal sal		:	std_logic;
    constant tclk	: time	:=	1 ns;
begin

	dut: entity work.NA_32_seq_conf(rtl)
		port map(	clk		=>	clk,
					nRst	=>	nRst,
					start	=>	start,
					umbral	=>	umbral,
					ent		=>	ent,
					fin		=>	fin,
					sal		=>	sal
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
		start <= '0';
		umbral <= (4 => '0', others => '1');
		ent <= (others => '0');
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		nRst <= '1';
		
		ent <= "00110101101101010110110110010010";		--17 unos
		wait until clk'event AND clk = '1';
		start <= '1';
		wait until clk'event AND clk = '1';
		start <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait;
	end process;

end test;