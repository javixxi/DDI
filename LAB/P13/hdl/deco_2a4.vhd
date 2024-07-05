library ieee;
use ieee.std_logic_1164.all;

entity deco_2a4 is
	port( din     :  in std_logic_vector(1 downto 0);
	      ena     :  in std_logic;
	      dout    :  buffer std_logic_vector(3 downto 0)
		);
end entity;

architecture rtl of deco_2a4 is
begin

	dout <= "0001" when din = "00" AND ena = '1' else
	        "0010" when din = "01" AND ena = '1' else
			"0100" when din = "10" AND ena = '1' else
			"1000" when din = "11" AND ena = '1' else
			"XXXX";
end rtl;
			 