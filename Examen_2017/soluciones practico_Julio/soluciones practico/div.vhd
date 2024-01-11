-- Circuito divisor (Ej 6 del examen de DD1)
-- Autor: 
-- Fecha:


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity div is port(
  clk       : in std_logic;
  Rstn      : in std_logic;
  start     : in std_logic;
  dividendo : in std_logic_vector(7 downto 0); 
  divisor   : in std_logic_vector(7 downto 0);
  cociente  : buffer std_logic_vector(7 downto 0);
  resto     : buffer std_logic_vector(7 downto 0);
  busy      : buffer std_logic
);
end entity;

architecture rtl of div is
type t_estado is(inicial, resta);
signal estado : t_estado;
signal load_cnt: std_logic;
signal reg_dividendo, reg_divisor: std_logic_vector(7 downto 0);
signal rest: std_logic_vector(7 downto 0);
begin

process(clk,Rstn)
  begin
    if Rstn = '0' then
      reg_dividendo <= (others => '0');
    elsif clk'event and clk = '1' then
      if start = '1' then
        reg_dividendo <= dividendo;
      elsif load_cnt = '1' then
        reg_dividendo <= rest;
      end if;
   end if;  
end process;

process(clk,Rstn)
  begin
    if Rstn = '0' then
      reg_divisor <= (others => '0');
    elsif clk'event and clk = '1' then
      if start = '1' then
        reg_divisor <= divisor;
      end if;
   end if;  
end process;

process(clk,Rstn)
  begin
    if Rstn = '0' then
      cociente <= (others => '0');
    elsif clk'event and clk = '1' then
      if start = '1' then
        cociente <= (others => '0');
      elsif load_cnt = '1' then
         cociente <= cociente + 1;
      end if;
   end if;  
end process;

process(clk,Rstn)
  begin
    if Rstn = '0' then
      estado <= inicial;
    elsif clk'event and clk = '1' then
      case(estado) is
        when inicial =>
          if start = '1' then
            estado <= resta;
          end if;
        when resta =>
          if load_cnt = '0' then
            estado <= inicial;
          end if;
      end case;
    end if;
  end process;

  busy <= '1' when estado = resta else '0';
  resto <= reg_dividendo;
  rest <= reg_dividendo - reg_divisor;
  load_cnt <= '1' when estado = resta and reg_dividendo >= reg_divisor else '0';
end rtl;