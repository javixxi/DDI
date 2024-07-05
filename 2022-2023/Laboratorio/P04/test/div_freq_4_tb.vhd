-- Test-Bench de un divisor de frecuencia entre 4
-- Realizado para el tutorial de la practica 4
-- (29-09-2022) por Javier Gacria

-- Clausula de visibilidad
library ieee;
use ieee.std_logic_1164.all;

entity tb_div_freq_4 is
end entity;

architecture Test of tb_div_freq_4 is
  signal clk:		std_logic;
  signal nRST:		std_logic;
  signal freq_div_4: 	std_logic;
  

  constant t_clk: time:= 100 ns;

begin

dut: entity Work.div_freq_4(rtl)
     port map(	clk 	   => 	clk,
		nRST 	   => 	nRST,
		freq_div_4 => 	freq_div_4);


  process
  begin
    clk <= '1';
    wait for t_clk/2;
    clk <= '0';
    wait for t_clk/2;
  end process;

  process
  begin
    nRST <= '0';
    wait for t_clk/2;
    wait for t_clk/4;
    nRST <= '1';
    wait for t_clk/4;
    wait;
  end process;
end test;