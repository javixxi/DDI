library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity regcomb is
port(
  nRst   : in std_logic;
  clk    : in std_logic;
  Din    : in std_logic_vector(7 downto 0);
  S_L    : in std_logic;
  Enable : in std_logic;
  Es_BCD : buffer std_logic;
  Bin    : buffer std_logic_vector(6 downto 0)
);
end entity;

architecture rtl of regcomb is

  signal Dout : std_logic_vector(7 downto 0);
begin
  -- Registro de desplazamiento
  process(clk, nRst)
  begin
    if nRst = '0' then
      Dout <= (others => '0');
    elsif clk'event and clk = '1' then
      if Enable = '1' then
        if S_L = '0' then
          Dout <= Din;
        else
          Dout <= Dout(6 downto 0) & '0';
        end if;
      end if;
    end if;
  end process;

  -- Conversor de BCD a binario

  Es_BCD <= '1' when Dout(7 downto 4) <= 9 and Dout(3 downto 0) <= 9 else
            '0';

  Bin <= (Dout(7 downto 4)&"000")+("00"&Dout(7 downto 4)&'0')+("000"&Dout(3 downto 0)) when ES_BCD = '1' else
		 (others => '0');
 
end rtl;
