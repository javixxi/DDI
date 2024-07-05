library ieee;
use ieee.std_logic_1164.all;

entity tb_acumulador is
end entity;

architecture test of tb_acumulador is
  signal clk   :  std_logic;
  signal nRst  :  std_logic;
  signal E     :  std_logic_vector(7 downto 0);
  signal INI   :  std_logic;
  signal ENA   :  std_logic;
  signal S     :  std_logic_vector(7 downto 0);
  constant t_clk : time := 100 ms;
  
begin 

  dut: entity Work.acumulador(rtl)
	port map( clk => clk,
	          nRst => nRst,
			  ENA => ENA,
			  INI => INI,
			  S => S,
			  E => E);
	
  Proceso_Reloj:
  process
  begin
	clk <= '1';
	wait for t_clk/2;
	clk <= '0';
	wait for t_clk/2;
  end process;
  
  process
  begin
	nRst <= '0';
	E <= X"00";
	INI <= '0';
	ENA <= '0';
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	nRst <= '1';
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	INI <= '1';
	ENA <= '1';
	wait until clk'event AND clk = '1';
	E <= X"11";
	wait until clk'event AND clk = '1';
	E <= X"22";
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	INI <= '0';
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	E <= X"FF";
	wait;
	
  end process;
  
end test;