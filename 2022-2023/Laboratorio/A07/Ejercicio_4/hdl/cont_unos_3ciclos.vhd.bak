-- Contador de unos en 3 ciclos de reloj
-- Previo realizado con una diagrama de moore
-- Realizado para la actividad 7 de DD1
-- 15-10-2022

library ieee;
use ieee.std_logic_1164.all;

entity cont_unos_3ciclos is
  port(	clk:	in std_logic;
	nRST:	in std_logic;
	D_in:	in std_logic;
	D_out:	buffer std_logic_vector(1 downto 0)
  );
end entity cont_unos_3ciclos;

architecture rtl of cont_unos_3ciclos is
  type t_estado is (cero, uno, dos, tres);
  signal estado: t_estado;
begin

  proc_estado: process(clk, nRST)
  begin
    if nRST = '0' then
      estado <= cero;
    elsif clk'event and clk = '1' then
      case estado is
	when cero =>
	  if D_in = '1' then
	    estado <= uno;
	  end if;
	when uno =>
	  if D_in = '1' then
	    estado <= dos;
	  end if;
	when dos =>
	  if D_in = '1' then
	    estado <= tres;
	  end if;
	when others =>
	  estado <= cero;
      end case;
    end if;
  end process proc_estado;

  proc_salida: process(estado)
  begin
    if estado = cero then
      D_out <= "00";
    elsif estado = uno then
      D_out <= "01";
    elsif estado = dos then
      D_out <= "10";
    elsif estado = tres then
      D_out <= "11";
    end if;
  end process proc_salida;

end architecture rtl;