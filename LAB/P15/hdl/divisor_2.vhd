library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divisor_2 is
port(clk:     in     std_logic;
     nRst:    in     std_logic;
     f_out_1: buffer std_logic;
     f_out_2: buffer std_logic);
end entity;

architecture rtl of divisor_2 is
  signal cnt_1      :  std_logic_vector(1 downto 0);
  signal cnt_2      :  std_logic_vector(1 downto 0);
  signal cnt_tick   :  std_logic_vector(25 downto 0);
  signal tick       :  std_logic;
  constant modulo   :  natural  := 36000000;
  
begin
  -- Contador modulo 4 con salida de fin de cuenta
  process(clk, nRst)
  begin
    if nRst = '0' then
	  cnt_1 <= "00";
	elsif clk'event AND clk = '1' then
	  cnt_1 <= cnt_1 + 1;
	end if;
  end process;
  
  f_out_1 <= '1' when cnt_1 = "11" else
             '0';
  
  -- Contador módulo 3 con entrada de habilitación y salida
  -- de fin de cuenta (independiente de la entrada de habilitación)
  process(clk, nRst)
  begin
    if nRst = '0' then
	  cnt_2 <= "00";
	elsif clk'event AND clk = '1' then
	  --if tick = '1' then
	    if f_out_1 = '0' then
	    elsif cnt_2 = "10" then
	      cnt_2 <= "00";
	    else
	      cnt_2 <= cnt_2 + 1;
	    end if;
	  --end if;
	end if;
  end process;
  
  f_out_2 <= '1' when cnt_2 = "10" else
             '0';
  
  -- Proceso generador de ticks
  process(clk, nRst)
  begin
    if nRst = '0' then
	  cnt_tick <= (others => '0');
	elsif clk'event AND clk = '1'then
	  if cnt_tick = modulo then
	    tick <= '1';
	  else 
	    tick <= '0';
	  end if;
	end if;
  end process;
  
end rtl;