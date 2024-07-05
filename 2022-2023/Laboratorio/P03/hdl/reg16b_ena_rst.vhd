-- Modelo de un registro de 16 bits, con entrada
-- de reset y enable.

library ieee;
use ieee.std_logic_1164.all;

entity reg16b_ena_rst is
port(
  CLK:	in std_logic;
  nRST:	in std_logic;
  sRst:	in std_logic;
  ena:	in std_logic;
  Din:	in std_logic_vector (15 downto 0);
  Dout:	buffer std_logic_vector (15 downto 0)
  );
end entity;

-- Proceso de modela el funcionamiento del registro
architecture rtl of reg16b_ena_rst is
begin

  process(CLK, nRST)
  begin
    if nRST = '0' then
      Dout <= (Others => '0');

    elsif CLK'event and CLK = '1' then
      if sRst = '1' then
	Dout <= (Others => '0');

      elsif ena = '1' then
	Dout <= Din;

      end if;
    end if;
  end process;
end rtl;
