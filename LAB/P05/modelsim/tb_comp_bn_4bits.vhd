-- Autor: DTE
-- fecha: 9-9-2016
-- Test-Bench del comparador de 4 bits
-- Versión 1.1

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comp_bn_4bits_tb is
end entity;

architecture test of comp_bn_4bits_tb is
  --Declaración de señales
  signal A: std_logic_vector(3 downto 0);
  signal B: std_logic_vector(3 downto 0);
  signal A_eq_B: std_logic;
  signal A_neq_B: std_logic;
  signal A_my_B: std_logic;
  signal A_mn_eq_B: std_logic;
  signal A_mn_B: std_logic;
  signal A_my_eq_B: std_logic;
  
begin

dut: entity Work.comp_bn_4bits(rtl)
     port map(
              A => A,
              B => B,
              A_eq_B => A_eq_B,
              A_neq_B => A_neq_B,
              A_my_B => A_my_B,
              A_mn_eq_B => A_mn_eq_B,
              A_mn_B => A_mn_B,
              A_my_eq_B => A_my_eq_B                                                                      
             );

process
begin
-- Prueba todas las combinaciones posibles
  A <= "0000";
  B <= "0000";
  
  for i in 0 to 15 loop
    for j in 0 to 15 loop
      wait for 100 ns;
      B <= B + 1;
    
    end loop;
    A <= A + 1;
  
  end loop;
  wait;
end process;
end test;