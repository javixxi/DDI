library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ctrl_pulsaciones is
port(clk:          in     std_logic;
     nRst:         in     std_logic;
     pulso:        in     std_logic;
     pulso_simple: buffer std_logic;
     pulso_doble:  buffer std_logic);                  -- Error sintáctico 1

end entity;

architecture rtl of ctrl_pulsaciones is
  signal   tic_1ms:     std_logic;                     -- Error sintáctico 2
  signal   cuenta_tic:  std_logic_vector(9 downto 0);   
  --constant fdc_timer:   natural := 1000;  -- Escalar para simulaciones
  constant fdc_timer:   natural := 5;

  signal pulso_reg:   std_logic;
  signal pulso_1Tclk: std_logic;

  signal cuenta: std_logic_vector(8 downto 0);  
  signal ventana:            std_logic;

begin 
  -- Subsistema 1: Timer
  process(nRst, clk)
  begin                                                -- Error sintáctico 3
    if nRST = '0' then
      cuenta_tic <= (0 => '1', others => '0');          
        
    elsif clk'event and clk = '1' then
      if pulso_1Tclk = '1' or tic_1ms = '1' then
        cuenta_tic <= (0 => '1', others => '0');       -- Error funcional 1

      else
        cuenta_tic <= cuenta_tic + 1;

      end if;
    end if;
  end process;
  tic_1ms <= '1' when cuenta_tic = fdc_timer else      -- Error sintáctico 4
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
  pulso_1Tclk <= '1' when pulso = '1' and pulso_reg = '0' else  -- Error funcional 2
                 '0';

  -- Monoestable (Subsistema 2)
  process(nRst, clk)
  begin
    if nRST = '0' then
      cuenta <= (others => '1');
        
    elsif clk'event and clk = '1' then
      if pulso_1Tclk = '1' and ventana = '0' then         -- Error funcional 3
        cuenta <= (others => '0');

      elsif ventana = '0' or pulso_doble = '1' then
        cuenta <= (others => '1');

      elsif ventana = '1' and tic_1ms = '1' then
        cuenta <= cuenta + 1;
          
      end if;
    end if;
  end process;

  ventana <= '1' when cuenta < 500 else                   -- Error funcional 4
             '0';

  -- Detección del tipo de pulsación
  pulso_simple <= '1' when (cuenta = 499) and (tic_1ms = '1') and (pulso_1Tclk = '0') else  
                  '0';

  pulso_doble <= pulso_1Tclk when ventana = '1' else
                 '0';               
end rtl;
