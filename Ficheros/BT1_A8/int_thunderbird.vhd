-- Autor: TBC
-- Fecha: TBC
-- TBC

library ieee;
use ieee.std_logic_1164.all;

entity int_thunderbird is
port(
   clk   : in std_logic;
   Rst_n : in std_logic;
   -- Intermitente izquierdo (L) o derecho (R)
   L     : in std_logic;
   R     : in std_logic;
   --- Luces izquierda
   LA: buffer std_logic;
   LB: buffer std_logic;
   LC: buffer std_logic;
   -- Luces derecha
   RA: buffer std_logic;
   RB: buffer std_logic;
   RC: buffer std_logic
);
end entity;

architecture rtl of int_thunderbird is
signal interLR: std_logic_vector(1 downto 0);
-- TBC
begin
interLR <= L & R; -- para utilizarla en la sentencia case
-- TBC

end rtl;
