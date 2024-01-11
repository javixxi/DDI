--Autor: Castellana Antonio
--Fecha: 31-12-2023
-- contador de modulo programable (2 a 1023)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ContaProg is
port(

  clk: in std_logic;
  nRst: in std_logic;
  modulo: in std_logic_vector (9 downto 0);
  fdc: buffer std_logic;
  Q: buffer std_logic_vector (9 downto 0)

);
end entity;

architecture rtl of ContaProg is

begin

--------- Contador ---------
process(clk,nRst)
begin
if nRst = '0' then

Q<=(others => '0');

elsif clk'event and clk='1' then

  if fdc = '1' then
    Q<=(0 => '1', others => '0');
  else 
    Q<=Q+1;
  end if;
end if;
end process;

fdc <= '1' when modulo <= Q else
       '0';
----------------------------

end rtl;