library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gen_segnal_mono is
port(clk:     in     std_logic;
     nRst:    in     std_logic;
     we:      in     std_logic;
     dir:     in     std_logic_vector(1 downto 0);
     d_in:    in     std_logic_vector(7 downto 0);
     start:   in     std_logic;
     stop:    in     std_logic;
     s_gen:   buffer std_logic;
     start_mono: in std_logic);

end entity;


architecture rtl of gen_segnal_mono is
  type t_estado is (reposo, generacion, generacion_mono);
  signal estado: t_estado;

  signal ciclo_L:     std_logic_vector(7 downto 0);
  signal ciclo_H:     std_logic_vector(7 downto 0);
  signal factor_div:  std_logic_vector(3 downto 0);
  signal modulo:      std_logic_vector(8 downto 0);

  signal cnt_div:     std_logic_vector(3 downto 0);
  signal fdc_div:     std_logic;
  signal ini_div:     std_logic;

  signal cuenta:      std_logic_vector(8 downto 0);
  signal fdc_signal:  std_logic;
  signal ena_gen:     std_logic;

begin
  -- Interfaz de registros de programacion
  process(clk, nRst)
  begin
    if nRst = '0' then
      ciclo_L <= x"64";
      ciclo_H <= x"64";
      factor_div <= "0001";

    elsif clk'event and clk = '1' then
      if we = '1' then
        case dir is
          when "00" => ciclo_L <= d_in;
          when "01" => ciclo_H <= d_in;
          when "10" => factor_div <= d_in(3 downto 0);
          when others =>null;

        end case;
      end if;
    end if;
  end process;

  modulo <= ('0'&ciclo_L) + ciclo_H;

  -- Divisor de frecuencia programable
  process(clk, nRst)
  begin
    if nRst = '0' then
      cnt_div <= (0 => '1', others => '0');

    elsif clk'event and clk = '1' then
      if ini_div = '1' or fdc_div = '1' then
        cnt_div <= (0 => '1', others => '0');

      else
        cnt_div <= cnt_div + 1;

      end if;
    end if;
  end process;

  fdc_div <= '1' when cnt_div = factor_div else
             '0';

  -- Generador de segnal de salida
  process(clk, nRst)
  begin
    if nRst = '0' then
      cuenta <= (0 => '1', others => '0');

    elsif clk'event and clk = '1' then
      if ena_gen = '1' then
        if fdc_signal = '1' then
          cuenta <= (0 => '1', others => '0');

        elsif fdc_div = '1' then
          cuenta <= cuenta + 1;

        end if;

      else
        cuenta <= (0 => '1', others => '0');

      end if;
    end if;
  end process;

  fdc_signal  <= fdc_div when cuenta >= modulo else
                 '0';

  s_gen <= '0' when cuenta <= ciclo_L and estado /= generacion_mono else
           ena_gen;

  -- Control
  process(clk, nRst)
  begin
    if nRst = '0' then
      estado <= reposo;

    elsif clk'event and clk = '1' then   
      if estado = reposo then 
        if start = '1' then
          estado <= generacion;

        elsif start_mono = '1' then
          estado <= generacion_mono;

        end if;

      elsif estado = generacion then
        if stop = '1' then
          estado <= reposo;

        end if;

      elsif estado = generacion_mono then
        if fdc_signal = '1' then
          estado <= reposo;

        end if;
      end if;
    end if;
  end process;

  ena_gen <= '1' when estado = generacion or estado = generacion_mono else
             '0';

  ini_div <= start or start_mono when estado = reposo else
             '0'; 
end rtl;
