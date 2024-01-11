-- Autor: Castellana Antonio
-- Fecha: 15-12-23
-- Contador BCD de dos digitos de modulo 94

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contadorBCDmod94 is
port (clk: in std_logic;
      nRst: in std_logic;
      ENA: in std_logic;
      U: buffer std_logic_vector (3 downto 0);
      D: buffer std_logic_vector (3 downto 0)
);
end entity;


architecture rtl of contadorBCDmod94 is

signal RST : std_logic;
signal cout: std_logic;
signal cdout: std_logic;

begin

-------- CNT_BCD_UNI --------------
process(nRst, clk)
begin

if nRst='0' then
  U<=(others => '0');
elsif clk'event and clk = '1' then

  if RST = '1' then
    U<=(others => '0');
  elsif ENA = '1' then
    if cout = '1' then
      U<=(others => '0');
    else
      U<=U +1;
    end if;
 
  end if;

end if;

end process;

cout <= '1' when U=9 else
        '0';
-----------------------------------

--------- CNT_BCD_DEC -------------
process(nRst, clk)
begin

if nRst='0' then
  D<=(others => '0');
elsif clk'event and clk = '1' then

  if RST = '1' then
      D<=(others => '0');
  elsif cout = '1' then
    if cdout = '1' then
      D<=(others => '0');
    else
      D<= D + 1;
    end if;

  end if;

end if;

end process;

cdout <= '1' when D= 9 else
         '0';
-----------------------------------

---------- Comparador -------------
RST <= '1' when U=3 and D=9 and ENA='1' else
       '0';
-----------------------------------
end rtl;

