-- Modelo de un automota multiplicador por 3
-- realizado para la actividad del tema 6 bloque 1
-- de diseño digita.
-- (06/10/2022) versión 1

-- Cabecera clausulas de visibilidad
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned;

entity mult3serie is
  port( an_rst, clk 	:  in std_logic;
	x		:  in std_logic;
	y		:  buffer std_logic
       );
end entity mult3serie;

architecture rtl of mult3serie is 
  type t_estado is (cero, uno, dos);
  signal estado : t_estado;
begin

  proc_estado: process(an_rst, clk)
  begin
    if an_rst = '0' then
      estado <= cero;
    elsif clk'event and clk = '1' then
      case estado is 

	when cero =>
	  if x = '1' then
	    estado <= uno;
	  end if;

	when uno =>
	  if x = '1' then
	    estado <= dos;
	  else
	    estado <= cero;
	  end if;

	when dos =>
	  if x = '0' then
	    estado <= uno;
    	  end if;
      end case;
    end if;
  end process proc_estado;


    y <= '1' when estado = cero and x = '1' else
	 '0' when estado = uno  and x = '1' else
	 '1' when estado = uno  and x = '0' else
	 '0' when estado = dos  and x = '0';


end architecture rtl;
