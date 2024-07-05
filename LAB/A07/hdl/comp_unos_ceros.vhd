library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity comp_unos_ceros is
	port(	e	: in std_logic_vector(3 downto 0);
			s	: buffer std_logic
		);
end entity;

--architecture
architecture rtl of comp_unos_ceros is
	signal s_aux : std_logic_vector(2 downto 0);
begin
	
	s_aux <= ("00" & e(3)) + e(2) + e(1) + e(0);
	
	s <= 	'1' when s_aux >= "011" else
			'0';
end rtl;