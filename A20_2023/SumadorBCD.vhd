--Autor: Castellana Antonio
--Fecha: 09-01-2023
------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SumadorBCD is
port(

	a: in std_logic_vector(3 downto 0);
	b: in std_logic_vector(3 downto 0);
	c_in: in std_logic;
	c_out: buffer std_logic;
	s: buffer std_logic_vector(3 downto 0)

);
end entity;

architecture rtl of SumadorBCD is

signal c: std_logic_vector(4 downto 0); 
signal c_10: std_logic_vector(4 downto 0);

begin

------- sumador ------------
c <= ('0' & a) + ('0' & b) + ("000" & c_in);
-----------------------------

-------- comparador ---------
c_out <= '1' when c > 9 else
         '0';
-----------------------------

-------- restador -----------

c_10 <= c - 10;

-----------------------------

-------- multiplexor --------
s <= c(3 downto 0) when c_out = '0' else
     c_10(3 downto 0);
-----------------------------
end rtl;