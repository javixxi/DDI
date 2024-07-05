--tb_BCD7_conf


library ieee;
use ieee.std_logic_1164.all;

entity tb_cont_bcd_7seg_habcp is
end entity;

architecture test of tb_cont_bcd_7seg_habcp is
signal clk : std_logic;
signal an_rst : std_logic;
signal pulso_hab : std_logic;
signal seg7disp : std_logic_vector(6 downto 0);
constant T_CLK : time := 100 ns;

begin

  dut: entity work.cont_bcd_7seg_habcp(rtl) port map(
    clk    => clk,
    an_rst => an_rst,
    pulso_hab      => pulso_hab,
    seg7disp      => seg7disp
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
    pulso_hab <= '1';
    wait for T_CLK;
    an_rst <= '1';
    wait for T_CLK;
    
    pulso_hab <= '0';
    wait for 4*T_CLK;
    
    pulso_hab <= '1'; 
    wait for 3*T_CLK;
   
    
    wait;
  end process;
end test;