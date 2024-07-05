-- Test-bench del contador de unos a 3 ciclos
-- realizado para el aejercicio4 de la actividad 7 
-- para DD1
-- (15-10-2022)

library ieee;
use ieee.std_logic_1164.all;

entity tb_cont_unos_3ciclos is
end entity;

architecture test of tb_cont_unos_3ciclos is
  constant T_CLK: time:= 100 ns;
  signal clk	:	std_logic;
  signal nRST	:	std_logic;
  signal D_in	:	std_logic;
  signal D_out	:	std_logic_vector(1 downto 0);

begin
DUT: entity Work.cont_unos_3ciclos(rtl)
	port map (clk => clk,
		 nRST => nRST,
		 D_in => D_in,
		 D_out => D_out);

process
  begin
    clk <= '0';
    wait for T_CLK/2;
    clk <= '1';
    wait for T_CLK/2;
end process;

process
  begin
    nRST <= '0';
    d_in <= '0'; 
    wait for T_CLK/2;
    nRST <= '1';
    d_in <= '1'; 
    wait for T_CLK/2;
    d_in <= '1'; 
    wait for T_CLK/2;
    d_in <= '1'; 
    wait for T_CLK/2;
    d_in <= '1'; 
    wait for T_CLK/2;
    d_in <= '0'; 
    wait for T_CLK/2;
    d_in <= '1'; 
    wait for T_CLK/2;
    wait;
end process;
      
end test;