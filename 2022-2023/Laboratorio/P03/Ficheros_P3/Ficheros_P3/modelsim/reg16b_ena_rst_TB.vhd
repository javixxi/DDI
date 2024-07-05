-- Autor: TBC
-- Fecha: TBC
-- Testbench del registro de 16 bits con entrada de habilitacuon
-- y reset sincrono (independiente de habilitacion)
--
-------------------------------------------------------------------------
-- Descripcion de las pruebas
---- Reset asíncrono inicial
---- Con la habilitacion activa:
------ Carga de datos paralelo 
------ Reset sincrono
---- Con la habilitacion desactivada:
------ Carga de datos paralelo (no se produce)
------ Reset sincrono (debe producirse)
-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity reg16b_ena_rst_TB is
end entity;

architecture TBC of TBC is

  TBC

  constant T_CLK: TBC;

begin

   dut: entity work.reg16b_ena_rst(rtl)
        port map( clk => clk,
                  nRst => nRst,
                  sRst => sRst,
                  ena => ena,
                  Din => Din,
                  Dout => Dout);

   reloj: process
      begin
         TBC 
      end process;

   estimulos: process
      begin
         -- reset asincrono inicial
         nRST <= '0';
         sRst <= '0';
         ena <= '0';
         Din <= X"0000";
         wait until clk'event and clk='1';
         wait until clk'event and clk='1';
         -- carga de datos
         TBC
         wait until clk'event and clk='1';
         -- reset sincrono con habilitacion
         TBC
         wait until clk'event and clk='1';
         -- carga de dato
         TBC
         wait until clk'event and clk='1';
         -- desactivacion de la habilitacion
         ena <= '0';
         Din <= X"1234"; -- este dato no debe cargarse
         wait until clk'event and clk='1';
         -- reset sincrono sin habilitacion
         sRst <= '1';
         wait until clk'event and clk='1';
         wait;
      end process;
      
end test;
