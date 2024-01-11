-- Autor: Castellana Antonio
-- Fecha: 15-12-2023
-- Test bench para el contador BCD de modulo 93
-- Primero probamos el reset y luego esperamos 100 ciclos de reloj con ENA=1
-- Segundo 10 ciclos de reloj con ENA=0
-- Tercero 100 ciclos de reloj con ENA=1
-----------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_contadorBCDmod94 is
end entity;

architecture test of tb_contadorBCDmod94 is
  signal clk:  std_logic;
  signal nRst: std_logic;
  signal ENA:  std_logic;
  signal U:  std_logic_vector(3 downto 0);
  signal D: std_logic_vector(3 downto 0);

  constant T_CLK: time := 1 us;
  signal fin: boolean := false;

begin

dut: entity work.contadorBCDmod94(rtl)
     port map(clk => clk,
              nRst => nRst,
              ENA => ENA,
              U => U,
              D => D);
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


process
  begin
----------primero------------------------
  nRst<='0';
  ENA<= '1';
  wait until clk'event and clk = '1';
  nRst<='1';
  wait until clk'event and clk = '1';
  wait for 100*T_CLK;
  wait until clk'event and clk = '1';
------------------------------------------

----------Segundo-------------------------
ENA <='0';
wait for 10*T_CLK;
wait until clk'event and clk = '1';
------------------------------------------
----------Tercero-------------------------
ENA <='1';
wait for 100*T_CLK;
wait until clk'event and clk = '1';
------------------------------------------
wait until clk'event and clk = '1';
 fin <= true;
wait;

end process;


end test;