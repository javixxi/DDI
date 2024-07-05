library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity valor_absoluto_c2 is
	port(	e 	: in std_logic_vector(3 downto 0);
			s	: buffer std_logic_vector(3 downto 0)
		);
end entity;

--architecture
architecture rtl of valor_absoluto_c2 is
begin
	
	s <= 	not(e) + 1 when e(3) = '1' else
			e;
	
end rtl;