--Fecha: 31-12-2023
--Autor: Castellana Antonio
--Test bench en de contador modulo programable en el que probaremos:
--Primero: probamos activando el reset asincrono y desactivandolo
--Segundo: probamos con modulo = 0 por cindo ciclos de reloj y luego modulo = 1 por otros cinco ciclos de reloj
-- Tercero: probamos con modulo = 200 por 640 ciclos de reloj
-- Cuarto: probamos con modulo = 1023 por 3100 ciclos de reloj
-- Quinto: probamos con modulo = 2 por 10 ciclos

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_ContaProg is
end entity;

architecture test of tb_ContaProg is

signal  clk:  std_logic;
signal  nRst:  std_logic;
signal  modulo:  std_logic_vector (9 downto 0);
signal  fdc:  std_logic;
signal  Q: std_logic_vector (9 downto 0);

  constant T_CLK: time := 1 us;
  signal fin: boolean := false;

begin

dut: entity work.ContaProg(rtl)
     port map(
  clk => clk,
  nRst => nRst,
  modulo => modulo,
  fdc => fdc,
  Q => Q);

---------- reloj ----------
process
begin
clk <= '0';
wait for T_CLK/2;
clk <= '1';
if fin = true then
wait;
end if;
wait for T_CLK/2;

end process;
----------------------------

process
begin
-------- primero y segundo -----------
nRst<='0';
modulo<="0000000000";
wait until clk'event and clk = '1';
nRst <= '1';
wait until clk'event and clk = '1';
wait for 5*T_CLK;
modulo<="0000000001";
wait for 5*T_CLK;
wait until clk'event and clk = '1';
----------------------------------------

--------- tercero ----------------------
modulo<="0011001000";
wait for 640*T_CLK;
wait until clk'event and clk = '1';
----------------------------------------

--------- cuarto -----------------------
modulo<="1111111111";
wait for 3100*T_CLK;
wait until clk'event and clk = '1';
----------------------------------------

---------- quinto ----------------------
modulo<="0000000010";
wait for 10*T_CLK;
wait until clk'event and clk = '1';
----------------------------------------
fin <= true;
wait;
end process;

end test;