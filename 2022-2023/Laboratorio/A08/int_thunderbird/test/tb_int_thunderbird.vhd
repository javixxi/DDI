-- Autor: Javier Garcia Moreno
-- Fecha: 22-10-2022

library ieee;
use ieee.std_logic_1164.all;

entity tb_int_thunderbird is
end entity;

architecture test of tb_int_thunderbird is
  signal clk : std_logic;
  signal nRst : std_logic;
  signal L : std_logic;
  signal R : std_logic;
  signal LA : std_logic;
  signal LB : std_logic;
  signal LC : std_logic;
  signal RA : std_logic;
  signal RB : std_logic;
  signal RC : std_logic;
  constant T_CLK : time := 100 ns;
begin

  DUT: entity work.int_thunderbird(rtl) port map(
    clk	=>	clk,
    nRst	=>	nRst,
    L	=>	L,
    R	=>	R,
    LA	=>	LA,
    LB	=>	LB,
    LC	=>	LC,
    RA	=>	RA,
    RB	=>	RB,
    RC	=>	RC
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
    nRst <= '0';
    L <= '0';
    R <= '0';
    wait for T_CLK;
    nRst <= '1';
    wait for T_CLK;
    L <= '1';
    R <= '0';
    wait for T_CLK;
    wait for T_CLK;
    wait for T_CLK;
    wait for T_CLK;
    wait for T_CLK;
    wait for T_CLK;
    wait for T_CLK;
    wait for T_CLK;
    L <= '1';
    R <= '1';
    wait for T_CLK;
    wait for T_CLK;
    wait for T_CLK;
    wait for T_CLK;
    L <= '0';
    R <= '1';
    wait for T_CLK;
    wait for T_CLK;
    wait for T_CLK;
    wait for T_CLK;
    L <= '0';
    R <= '0';
    wait for T_CLK;
    wait for T_CLK;
    wait;
  end process;
end test;