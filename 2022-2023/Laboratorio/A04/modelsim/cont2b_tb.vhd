-- Autor: DTE
-- Fecha: 09-09-2016
-- Test-Bench del modelo de un contador de 2 bits, realizado para el tutorial 
-- de la actividad AIP7 del  bloque I de Diseño digital I 
-- versión 1.1 

library ieee;
use ieee.std_logic_1164.all;

entity cont2b_tb is
end entity;

architecture test of cont2b_tb is
  signal clk:  std_logic;
  signal nRST: std_logic;
  signal Q:    std_logic_vector(1 downto 0);
  
  constant T_CLK: time:= 100 ns; 

begin

dut: entity Work.cont2b(rtl)
     port map(clk  => clk,
              nRST => nRST,
              Q    => Q);
                       
process
begin
  clk <= '0';
  wait for T_CLK/2;
  clk <= '1';
  wait for T_CLK/2;
end process;          

process
begin
-- Inicialización asíncrona
   nRST <= '0';
  
  wait until clk'event and clk = '1';   
  wait until clk'event and clk = '1';
   nRST <= '1';     
-- Deja pasar 8 ciclos de reloj para visualizar la secuencia de cuenta completa  
  wait for 8*T_CLK;
  wait until clk'event and clk = '1';
  wait;
end process;
      
end Test;


