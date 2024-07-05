library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity modelo is
port(clk:           in     std_logic;
     nRst:          in     std_logic;
     rd:            in     std_logic;
     we:            in     std_logic;
     Din:           in     std_logic_vector(7 downto 0);
     Dout:          buffer std_logic_vector(7 downto 0);
     cnt_dato:      buffer std_logic_vector(2 downto 0));
end entity;

architecture rtl of modelo is
  signal reg0, reg1, reg2, reg3: std_logic_vector(7 downto 0);
begin
  process(clk, nRst)
  begin
    if nRst = '0' then
      reg0 <= (others => '0');
      reg1 <= (others => '0');
      reg2 <= (others => '0');
      reg3 <= (others => '0');
      cnt_dato  <= (others => '0');
 
    elsif clk'event and clk = '1' then
      if we = '1' and cnt_dato < 4 then
        reg0 <= Din;
        reg1 <= reg0;
        reg2 <= reg1;
        reg3 <= reg2;
        if rd = '0' then
          cnt_dato <= cnt_dato + 1;

        end if;

      elsif rd = '1' and cnt_dato != 0 then
        cnt_dato <= cnt_dato - 1;

      end if;
    end if;
  end process;

  Dout <= reg3 when cnt_dato = 4 else 
          reg2 when cnt_dato = 3 else
          reg1 when cnt_dato = 2 else
          reg0 when cnt_dato = 1 else
          (others => 'X');
end rtl;