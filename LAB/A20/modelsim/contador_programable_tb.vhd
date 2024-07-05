library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contador_programable_tb is
end entity;

architecture test of contador_programable_tb is
  signal clk:     std_logic;
  signal nRst:    std_logic;
  signal modulo:  std_logic_vector(9 downto 0);
  signal q:       std_logic_vector(9 downto 0);
  constant T_CLK: time := 100 ns;
  signal fin: boolean := false;
begin

  dut: entity work.contador_programable(rtl)
    port map(  clk => clk,
	           nRst => nRst,
	           modulo => modulo,
			   q   => q);
  
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
    modulo <= (others => '0');
	nRst <= '0';
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	modulo<= "0000000100";
	for i in 0 to 5 loop
	  wait until clk'event AND clk = '1';
	end loop;
	modulo<= "0000100000";
	for i in 0 to 33 loop
	  wait until clk'event AND clk = '1';
	end loop;
	
	fin <= true;
	wait;
  end process;

end test;
	