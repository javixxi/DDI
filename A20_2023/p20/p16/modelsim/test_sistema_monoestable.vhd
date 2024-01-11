--------------------------------------------------------------------------------
-- Autor: Castellana Antonio
-- Fecha:
-- Descripcion del test:
-- Reset asincrono inicial
-- Completar
-- Primero probamos el reset asincrono y asignamos una duracion de 16
-- Segundo probamos a dejar pasar el tiempo hasta completar la duracion de 16 ciclos de reloj y ademas probamos a resdisparar para ver si no redispara
-- Tercero probamos a cambiar a disparo periodico y vemos tres ciclos de reloj
-- cuarto cambiamos nuevamente a cambiar a disparo simple y dejamos para el tiempo cambiando la duracion
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity test_sistema_monoestable is
end entity;

architecture test of test_sistema_monoestable is
  signal clk:      std_logic;
  signal nRst:     std_logic;
  signal control:  std_logic;
  signal disparo:  std_logic;
  signal duracion: std_logic_vector(11 downto 0);
  signal ventana:  std_logic;

  constant T_CLK: time := 1 us;
  signal fin: boolean := false;
begin

dut: entity work.sistema_monoestable(rtl)
     port map(clk      => clk,
              nRst     => nRst,
              control  => control,
              disparo  => disparo,
              duracion => duracion,
              ventana  => ventana);

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
    nRst <= '0';
    duracion <= X"010";
    control <= '0';
    disparo <= '0';
    wait until clk'event and clk = '1';
    wait until clk'event and clk = '1';
    nRst <= '1';
    -- Para completar por el estudiante

------------ segundo ------------------------
    wait until clk'event and clk = '1';
    disparo <= '1';
    wait until clk'event and clk = '1'; 
    disparo <= '0';
    wait until clk'event and clk = '1';
    wait for 5*T_CLK;
    wait until clk'event and clk = '1';
    disparo <= '1';
    wait until clk'event and clk = '1'; 
    disparo <= '0';
    wait until clk'event and clk = '1';
    wait for 16*T_CLK;
    wait until clk'event and clk = '1';
    disparo <= '1';
    wait until clk'event and clk = '1'; 
    disparo <= '0';
    wait until clk'event and clk = '1';
    wait for 100*T_CLK;
----------------------------------------------

------------ Tercero -------------------------
    wait until clk'event and clk = '1';
    control <= '1';
    wait until clk'event and clk = '1';
    control <= '0';
    wait until clk'event and clk = '1';
    wait for 450*T_CLK;

----------------------------------------------

------------- Cuarto -------------------------
    wait until clk'event and clk = '1';
    control <= '1';
    wait until clk'event and clk = '1';
    control <= '0';
    wait until clk'event and clk = '1';
    duracion <= X"110";
    wait until clk'event and clk = '1';
    disparo <= '1';
    wait until clk'event and clk = '1'; 
    disparo <= '0';
    wait until clk'event and clk = '1';
    wait for 120*T_CLK;
----------------------------------------------

    wait until clk'event and clk = '1';
    fin <= true;
    wait;
  end process;

end test;

