library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contadorBCD_2_digitos_tb is
end entity;

architecture test of contadorBCD_2_digitos_tb is
  signal clk:  std_logic;
  signal nRst: std_logic;
  signal ena:  std_logic;
  signal u:    std_logic_vector(3 downto 0);
  signal d:    std_logic_vector(3 downto 0);
  constant T_CLK: time := 100 ns;
  signal fin: boolean := false;
begin

  dut: entity work.contadorBCD_2_digitos(rtl)
    port map(  clk => clk,
	           nRst => nRst,
	           ena => ena,
			   u   => u,
			   d   => d);
  
  process
  begin
    clk <= '0';
    wait for T_CLK/2;
    clk <= '1';
    if fin = true then
      wait;
    end if;
    wait for T_CLK/2;
  end process;
  
  process
  begin
    ena <= '0';
	nRst <= '0';
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	nRst<= '1';
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	ena <= '1';
	for i in 0 to 94 loop
	  wait until clk'event AND clk = '1';
	end loop;
	
	fin <= true;
	wait;
  end process;

end test;
	