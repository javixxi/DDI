-- Autor: DTE
-- fecha: 9-9-2016
-- Modelo de un comparador de 4 bits
-- Versión 1.1

library ieee;                    
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity comp_bn_4bits is             
port(
     A:         in     std_logic_vector(3 downto 0);
	   B:         in     std_logic_vector(3 downto 0);
	   A_eq_B:    buffer std_logic; -- A igual a B
	   A_neq_B:   buffer std_logic; -- A distinto de B
	   A_my_B:    buffer std_logic; -- A mayor que B 
	   A_mn_eq_B: buffer std_logic; -- A menor o igual que B
	   A_mn_B:    buffer std_logic; -- A menor que B
	   A_my_eq_B: buffer std_logic  -- A mayor o igual que B
    );
end entity; 

architecture rtl of comp_bn_4bits is
begin
    -- A igual a B y A distinto de B
    A_eq_B <= '1' when A = B else
              '0';
    A_neq_B <= not A_eq_B;
    
    -- A mayor que B y A menor o igual que B
    A_my_B <= '1' when A > B else
              '0';
    A_mn_eq_B <= not A_my_B;
              
    -- A menor que B y A mayor o igual que B
    A_mn_B <= not A_my_eq_B;
    A_my_eq_B <= A_my_B or A_eq_B;
  
end rtl;