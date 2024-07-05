library ieee;
use ieee.std_logic_1164.all;

entity mux_4 is
	port( dout_b0   :  in std_logic_vector(31 downto 0);
	      dout_b1   :  in std_logic_vector(31 downto 0);
	      dout_b2   :  in std_logic_vector(31 downto 0);
	      dout_b3   :  in std_logic_vector(31 downto 0);
	      dir_rd    :  in std_logic_vector(1 downto 0);
	      dout      :  buffer std_logic_vector(31 downto 0)
		  );
end entity;

architecture rtl of mux_4 is
begin

	dout <= dout_b0 when dir_rd = "00" else
	        dout_b1 when dir_rd = "01" else
			dout_b2 when dir_rd = "10" else
			dout_b3;
end rtl;
			 