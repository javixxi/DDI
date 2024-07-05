library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity segundero is
port(clk:    in     std_logic;
     nRst:   in     std_logic;
     nreset:  in     std_logic;
     ena:    in     std_logic;
     Q:      buffer std_logic_vector(7 downto 0));

end entity;

architecture rtl of segundero is
  signal   cnt_timer: std_logic_vector(23 downto 0);
  constant fdc_timer: natural := 4;          -- descomentar para simulacion
--  constant fdc_timer: natural := 12000000; -- descomentar para sintesis  

  signal   tic_1s:      std_logic;
  signal   ena_decenas: std_logic;

begin
  -- Timer: Genera un tic de 1 segundo (sintesis) o cada cuatro ciclos de reloj (simulacion)
  -- para habilitar la cuenta del contador de segundos

  process(clk, nRst)
  begin
    if nRst = '0' then
      cnt_timer <= (0 => '1', others => '0');

    elsif clk'event and clk = '1' then
		if tic_1s = '1' then								--Añadir este if para que se resetee el contador y¡una vez ha generado un tick
			cnt_timer <= (0 => '1', others => '0');
		else
			cnt_timer <= cnt_timer + 1;
		end if;

    end if;
  end process;

  tic_1s <= '1' when cnt_timer = fdc_timer else
            '0';

  process(clk, nRst)
  begin
    if nRst = '0' then
      Q(3 downto 0) <= X"0";

    elsif clk'event and clk = '1' then
      if nreset = '0' then
        Q(3 downto 0) <= X"0";

      elsif ena = '1' and tic_1s = '1' then
        if Q(3 downto 0) = 9 then
          Q(3 downto 0) <= X"0";

        else
          Q(3 downto 0) <= Q(3 downto 0) + 1;

        end if;
      end if;
    end if;
  end process;

  ena_decenas <= '1' when Q(3 downto 0) = 9 and ena = '1' else
                 '0';

  process(clk, nRst)
  begin
    if nRst = '0' then
      Q(7 downto 4) <= X"0";

    elsif clk'event and clk = '1' then
      if nreset = '0' then
        Q(7 downto 4) <= X"0";

      elsif ena_decenas = '1' and tic_1s = '1' then			--añadimos el and ticks para que solo cambie las decenas cuando haya un tick
        if Q(7 downto 4) = 5 then							--Cambiamos el final de 6 a 5 para que cuente hasta 59 no 69
          Q(7 downto 4) <= X"0";

        else
          Q(7 downto 4) <= Q(7 downto 4) + 1;

        end if;
      end if;
    end if;
  end process;  
end rtl;