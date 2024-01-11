library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ctrl_pulsaciones_2_ej_7 is
port(clk:          in     std_logic;
     nRst:         in     std_logic;
     pulso:        in     std_logic;
     pulso_simple: buffer std_logic;
     pulso_doble:  buffer std_logic;
     pulso_triple: buffer std_logic;
     pulso_largo:  buffer std_logic);

end entity;

architecture rtl of ctrl_pulsaciones_2_ej_7 is
  signal   tic_1ms:     std_logic;
  signal   cuenta_tic:  std_logic_vector(9 downto 0);   
  --constant fdc_timer:   natural := 1000;  -- Escalar para simulaciones
  constant fdc_timer:   natural := 5;

  signal pulso_reg:   std_logic;
  signal pulso_1Tclk: std_logic;

  type t_estado is (reposo, largo, simple_doble_triple, doble_triple);  -- Cambio de estados del autómata
  signal estado: t_estado;

  signal ena_cuenta: std_logic;
  signal rst_cuenta: std_logic;
  signal fdc_cuenta: std_logic;

  signal cuenta: std_logic_vector(9 downto 0);  -- Cambio en tamaño del contador (de 9 a 10 bits)

begin 
  -- Timer
  process(nRst, clk)
  begin
    if nRST = '0' then
      cuenta_tic <= (0 => '1', others => '0');
        
    elsif clk'event and clk = '1' then
      if pulso_1Tclk = '1' or tic_1ms = '1' then
        cuenta_tic <= (0 => '1', others => '0');

      else
        cuenta_tic <= cuenta_tic + 1;

      end if;
    end if;
  end process;
  tic_1ms <= '1' when cuenta_tic = fdc_timer else
             '0';   

  -- Generación de pulsos de 1 Tclk
  process(nRst, clk)
  begin
    if nRST = '0' then
      pulso_reg <= '0';
        
    elsif clk'event and clk = '1' then  
      pulso_reg <= pulso;

    end if;
  end process;   
  pulso_1Tclk <= '1' when pulso = '1' and pulso_reg = '0' else
                 '0';

  -- Control de pulsaciones
  process(nRst, clk)
  begin
    if nRST = '0' then
      estado <= reposo;
  
    elsif clk'event and clk = '1' then
      case estado is
        when reposo =>
          if pulso_1Tclk = '1' then
            estado <= largo;

          end if;

        when largo => 
          if pulso = '0' and fdc_cuenta = '0' then
            estado <= simple_doble_triple;

          elsif fdc_cuenta = '1' then
            estado <= reposo;

          end if;

        when simple_doble_triple =>
          if pulso_1Tclk = '1' and fdc_cuenta = '0' then
            estado <= doble_triple;

          elsif fdc_cuenta = '1' then
            estado <= reposo;

          end if;

        when doble_triple => 
          if pulso_1Tclk = '1' or fdc_cuenta = '1' then
            estado <= reposo;
 
          end if;

      end case;
    end if;
  end process;
  ena_cuenta <= '1' when estado /= reposo and tic_1ms = '1' else                                        -- Cambio
                '0';

  rst_cuenta <= '1' when estado = reposo else
                '0';

  pulso_simple <= '1' when estado = simple_doble_triple and fdc_cuenta = '1' and pulso_1Tclk = '0' else  -- Cambio
                  '1' when estado = largo               and fdc_cuenta = '1' and pulso = '0'       else
                  '0';

  pulso_doble <= '1' when estado = simple_doble_triple and fdc_cuenta = '1' and pulso_1Tclk = '1' else   -- Cambio
                 '1' when estado = doble_triple        and fdc_cuenta = '1' and pulso_1Tclk = '0' else
                 '0';

  pulso_triple <= '1' when estado = doble_triple and pulso_1Tclk = '1' else                              -- Nuevo
                  '0';

  pulso_largo <= '1' when estado = largo and fdc_cuenta = '1' and pulso = '1' else                       -- Nuevo
                 '0';

  -- Cuenta de intervalo de pulsación doble
  process(nRst, clk)
  begin
    if nRST = '0' then
      cuenta <= (others => '0');
  
    elsif clk'event and clk = '1' then
      if rst_cuenta = '1' then
        cuenta <= (others => '0');

      elsif ena_cuenta = '1' then
        cuenta <= cuenta + 1;
          
      end if;
    end if;
  end process;
  fdc_cuenta <= '1' when ena_cuenta = '1' and cuenta = 999 else  -- Cambio para lapso de 1 segundo
                '0';

end rtl;
