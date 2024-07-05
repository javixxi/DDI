-- Autor: Javier Garcia Moreno
-- Fecha: 22-10-2022

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity int_thunderbird is
port(
   clk   : in std_logic;
   nRst : in std_logic;
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
  type t_estado is (inicial, izda_1, izda_2, izda_3, emer, dcha_1, dcha_2, dcha_3);
  signal estado : t_estado; 
  signal interLR: std_logic_vector(1 downto 0);
  signal tick: std_logic;
  signal ticks : integer;


begin

  interLR <= L & R; -- para utilizarla en la sentencia case

proc_estado: process (tick, nRST)
begin
  if nRst = '0' then
    estado <= inicial;

  elsif tick'event and tick ='1' then

      case estado is

        when inicial =>
	  if interLR = "10" then
  	    estado <= izda_1;
	  elsif interLR = "11" then
	    estado <= emer;
	  elsif interLR = "01" then
	    estado <= dcha_1;
	  end if;

        when izda_1 =>
	  if interLR = "10" then
	    estado <= izda_2;
	  else 
	    estado <= inicial;
	  end if;
	 
        when izda_2 =>
	  if interLR = "10" then
	    estado <= izda_3;
	  else 
	    estado <= inicial;
	  end if;

        when izda_3 =>
	  estado <= inicial;

        when emer =>
	  estado <= inicial;

        when dcha_1 =>
	  if interLR = "01" then
	    estado <= dcha_2;
	  else 
	    estado <= inicial;
	  end if;
	 
        when dcha_2 =>
	  if interLR = "01" then
	    estado <= dcha_3;
	  else 
	    estado <= inicial;
	  end if;

        when dcha_3 =>
	  estado <= inicial;

      end case;

  end if;
end process;

LA <= '1' when (estado = izda_1) OR (estado = izda_2) OR (estado = izda_3) OR (estado = emer) else 
      '0';
LB <= '1' when (estado = izda_2) OR (estado = izda_3) OR (estado = emer) else 
      '0';
LC <= '1' when (estado = izda_3) OR (estado = emer) else 
      '0';

RA <= '1' when (estado = dcha_1) OR (estado = dcha_2) OR (estado = dcha_3) OR (estado = emer) else
      '0';
RB <= '1' when (estado = dcha_2) OR (estado = dcha_3) OR (estado = emer) else
      '0';
RC <= '1' when (estado = dcha_3) OR (estado = emer) else
      '0';

proc_timer : process(nRst, clk)
begin
  if nRst='0' then 
    ticks<=0;
  elsif(clk'event and clk ='1') then
    ticks<=ticks+1;
    if ticks=3600000 then 
      tick <='1';
      ticks <= 0;
    else tick <='0';
    end if;
  end if;
end process proc_timer;



end rtl;
