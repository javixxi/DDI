-- Autor: TBC
-- Fecha: TBC
-- TBC

library ieee;
use ieee.std_logic_1164.all;

entity conformador is
  port ( clk, an_rst : in     std_logic;
         e           : in     std_logic;
         s           : buffer std_logic
         );
end entity conformador;

architecture rtl of conformador is
begin
-- Memoria de estado
proc_estado: process (TBC)
begin
  if an_rst = '0' then
  elsif clk'event and clk = '1' then
    TBC
  end if;
end process proc_estado;
-- Calculo de la salida
proc_salida: process (TBC)
begin
   TBC
end process proc_salida;

end architecture rtl;
