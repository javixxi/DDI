library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fibonacci is
port(clk:     in std_logic;
     nRst:    in std_logic;
     ini:     in std_logic;
     ena:     in std_logic;
     sal_fib: buffer std_logic_vector(7 downto 0));

end entity;

architecture rtl of fibonacci is
  signal acum_fib: std_logic_vector(7 downto 0);
  signal reg_fib:  std_logic_vector(7 downto 0);

begin
  process(clk, nRst)
  begin
    if nRst = '0' then
      acum_fib <= X"01";
      reg_fib  <= X"00";

    elsif clk'event and clk = '1' then
      if ena = '1' then
        if ini = '1' then
          acum_fib <= X"01";
          reg_fib  <= X"00";

        else
          acum_fib <= acum_fib + reg_fib;
          reg_fib  <= acum_fib;
        
        end if;
      end if;
    end if;
  end process;

--Código incompleto
  sal_fib <= reg_fib;

end rtl;