--Autor: Castellana Antonio
--Fecha: 10-01-2024
-----------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BancoReg is
port(

  clk: in std_logic;
  nRst: in std_logic;
  digito: in std_logic_vector (3 downto 0);
  peso_digito: in std_logic_vector (1 downto 0);
  we_digito: in std_logic;  
  dir_digito: in std_logic_vector (1 downto 0);
  digito_out: buffer std_logic_vector (3 downto 0)

);
end entity;

architecture rtl of BancoReg is

signal Reg0 : std_logic_vector (3 downto 0);
signal Reg1 : std_logic_vector (3 downto 0);
signal Reg2 : std_logic_vector (3 downto 0);
signal Reg3 : std_logic_vector (3 downto 0);

begin


--------------- Escritura ----------------------------
process(nRst,clk)
begin

if nRst='0' then

  Reg0<= (others => '0');
  Reg1<= (others => '0');
  Reg2<= (others => '0');
  Reg3<= (others => '0');

elsif clk'event and clk = '1' then

  if we_digito = '1' then

    if peso_digito = 0 then
      Reg0<=digito;
    elsif peso_digito = 1 then
      Reg1<=digito;
    elsif peso_digito = 2 then
      Reg2<=digito;
    else
      Reg3<=digito; 
    end if;

  end if;

end if;

end process;
-------------------------------------------------------

--------------- lectura -------------------------------
digito_out <= Reg0 when dir_digito = 0 else
              Reg1 when dir_digito = 1 else
              Reg2 when dir_digito = 2 else
              Reg3;
--------------------------------------------------------

end rtl;
