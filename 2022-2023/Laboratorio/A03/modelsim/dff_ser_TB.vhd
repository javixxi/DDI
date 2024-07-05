library ieee;
use ieee.std_logic_1164.all;

entity dff_ser_tb is
end entity;

architecture test of dff_ser_TB is
	constant T_CLK: time := 100 ns;
	signal nRst:	std_logic;
	signal clk:	std_logic;
	signal nSet_syn:std_logic;
	signal ena:	std_logic;
	signal rst_syn: std_logic;
	signal D:	std_logic;
	signal Q:	std_logic;

begin
  DUT:  entity work.dff_ser(rtl)
  	port map (nRst => nRst,
		  clk => clk,
		  nSet_syn => nSet_syn,
		  ena => ena,
		  rst_syn => rst_syn,
		  D => D,
		  Q => Q);
process
begin
  clk <= '1';
  wait for T_CLK / 2;
  clk <= '0';
  wait for T_CLK / 2;
end process;

process
  begin
    nRst <= '0';
    nSet_syn <= '1';
    ena <= '1';
    rst_syn <= '0';
    D <= '1';

    wait until clk'event and clk = '1';
    -- nRst <= '1';
    -- reset asíncrono terminado
    wait until clk'event and clk = '1';
    nRst <= '1';
    wait until clk'event and clk = '1';
    D <= '0';
    wait until clk'event and clk = '1';
    D <= '1';
    wait until clk'event and clk = '1';
    D <= '0';
    ena <= '0';
    wait until clk'event and clk = '1';
    D <= '1';
    rst_syn <= '1';
    wait until clk'event and clk = '1';
    ena <= '1';
    wait until clk'event and clk = '1';
    D <= '0';
    nSet_syn <= '0';
    wait until clk'event and clk = '1';
    nSet_syn <= '1';
    wait until clk'event and clk = '1';
    wait;
end process;
end test;
