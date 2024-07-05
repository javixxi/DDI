library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sum8bits_tb is
end entity;

architecture test of sum8bits_tb is
  --Declaración de señales
  signal C_in:  std_logic;
  signal A:     std_logic_vector(7 downto 0);
  signal B:     std_logic_vector(7 downto 0);
  signal S:     std_logic_vector(7 downto 0);
  signal C_out: std_logic;
  signal OV:    std_logic;
begin

--Emplazamiento del modelo
dut: entity Work.sum8bits(rtl)
     port map(
              C_in => C_in,
              A => A,
              B => B,
              S => S,
              C_out => C_out,
              OV => OV
             );

-- Definición de estímulos
process
begin
  C_in <= '0';
  A <= (others => '0');
  B <= (others => '0');
  
  loop
    for i in 0 to 255 loop
      for j in 0 to 255 loop
        wait for 100 ns;
        B <= B + 1;
    
      end loop;
      A <= A + 1;
  
    end loop;
	
    if C_in = '1' then
      exit;     
    end if;
	
    C_in <= not C_in; --Cabmiamos el valor de C_in a 1 par que se ejecute ahora con un bit de acarreo
  end loop;
  wait;
end process;
end test;