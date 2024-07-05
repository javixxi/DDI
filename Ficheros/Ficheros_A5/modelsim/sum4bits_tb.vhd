-- Autor: DTE
-- Fecha: 9-9-2016
-- Test-Bench del sumador de 4 bits
-- Versión 1.1

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sum4bits_tb is
end entity;

architecture test of sum4bits_tb is
  --Declaración de señales
  signal A: std_logic_vector(3 downto 0);
  signal B: std_logic_vector(3 downto 0);
  signal S: std_logic_vector(3 downto 0);
  
begin

--Emplazamiento del modelo
dut: entity Work.sum4bits(rtl)
     port map(
              A => A,
              B => B,
              S => S
             );

-- Definición de estímulos
process
begin
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