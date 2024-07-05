-- Test-Bench del contador de 16 bits
-- realizado para el ejercicio 3 de la actividad 7
-- Para la asignatura DD1
-- (10-10-2022)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contador_16_bits_tb is
end entity;

architecture test of contador_16_bits_tb is
  constant T_CLK: time:= 100 ns; 
  signal clk:  	std_logic;
  signal n_rst: std_logic;
  signal Q:    	std_logic_vector(15 downto 0); 

begin
DUT: entity Work.contador_16_bits(rtl)
     port map (clk => clk,
	       n_rst => n_rst,
	       Q => Q);
                       
process
  begin
    clk <= '0';
    wait for T_CLK/2;
    clk <= '1';
    wait for T_CLK/2;
end process;          

process
  begin
    n_rst <= '1';
    wait for T_CLK/2;
    n_rst <= '0';  
    wait for T_CLK/2;
    wait;
end process;
      
end test;