--conf_monoestable_tb

library ieee;
use ieee.std_logic_1164.all;

entity conf_monoestable_tb is
end entity;

architecture test of conf_monoestable_tb is
constant T_CLK : time := 100 ns;
signal clk : std_logic;
signal an_rst : std_logic;
signal pulsador : std_logic;
signal pulse : std_logic;


begin

  dut: entity work.conf_monoestable(rtl) port map(
    clk    => clk,
    an_rst => an_rst,
    pulsador      => pulsador,
    pulse      => pulse
  );

  reloj: process
  begin
    clk <= '0';
    wait for T_CLK/2;
    clk <= '1';
    wait for T_CLK/2;
  end process;

  estimulos: process
  begin
    an_rst <= '0';
    pulsador <= '1';
    wait for T_CLK;
    an_rst <= '1';
    wait for T_CLK;
    
    pulsador <= '0';
    wait for T_CLK;
    
    pulsador <= '1'; 
    wait for 25*T_CLK;

    
    wait;
  end process;
end test;