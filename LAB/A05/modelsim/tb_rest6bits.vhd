-- Autor: DTE
-- Fecha: 9-9-2016
-- Test-Bench de restador de 6 bits con acarreo 
-- de entrada y salida y salida OV
-- Versión 1.1

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rest6bits_tb is
end entity;

architecture test of rest6bits_tb is
  --Declaración de señales
  signal B_in:  std_logic;
  signal A:     std_logic_vector(5 downto 0);
  signal B:     std_logic_vector(5 downto 0);
  signal R:     std_logic_vector(5 downto 0);
  signal B_out: std_logic;
  signal OV:    std_logic;
begin

--Emplazamiento del modelo
dut: entity Work.rest6bits(rtl)
     port map(
              B_in => B_in,
              A => A,
              B => B,
              R => R,
              B_out => B_out,
              OV => OV
             );

-- Definición de estímulos
process
begin
  B_in <= '1';
  A <= (others => '0');
  B <= (others => '0');
  
  loop
    for i in 0 to 63 loop
      for j in 0 to 63 loop
        wait for 100 ns;
        B <= B + 1;
    
      end loop;
      A <= A + 1;
  
    end loop;
    if B_in = '0' then
      exit;     
    end if;
    B_in <= '0';
  end loop;
  wait;
end process;
end test;