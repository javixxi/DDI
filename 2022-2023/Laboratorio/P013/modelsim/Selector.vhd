library ieee;
use ieee.std_logic_1164.all;

entity selector16x32bits is
port(	Canal_0:  in std_logic_vector(31 downto 0);
			Canal_1: 	in std_logic_vector(31 downto 0);
			Canal_2: 	in std_logic_vector(31 downto 0);
			Canal_3:	in std_logic_vector(31 downto 0);
			Canal_4:	in std_logic_vector(31 downto 0);
			Canal_5: 	in std_logic_vector(31 downto 0);
			Canal_6: 	in std_logic_vector(31 downto 0);
			Canal_7: 	in std_logic_vector(31 downto 0);
			Canal_8: 	in std_logic_vector(31 downto 0);
			Canal_9: 	in std_logic_vector(31 downto 0);
			Canal_10: in std_logic_vector(31 downto 0);
			Canal_11: in std_logic_vector(31 downto 0);
			Canal_12: in std_logic_vector(31 downto 0);
			Canal_13: in std_logic_vector(31 downto 0);
			Canal_14: in std_logic_vector(31 downto 0);
			Canal_15: in std_logic_vector(31 downto 0);
			Sel: in std_logic_vector(3 downto 0);
			Dout: buffer std_logic_vector(31 downto 0));
end entity;

architecture rtl of selector16x32bits is
begin
	Dout <= Canal_0	 when Sel = "0000" else
					Canal_1	 when Sel = "0001" else
					Canal_2	 when Sel = "0010" else
					Canal_3	 when Sel = "0011" else
					Canal_4	 when Sel = "0100" else
					Canal_5	 when Sel = "0101" else
					Canal_6	 when Sel = "0110" else
					Canal_7	 when Sel = "0111" else
					Canal_8	 when Sel = "1000" else
					Canal_9	 when Sel = "1001" else
					Canal_10 when Sel = "1010" else
					Canal_11 when Sel = "1011" else
					Canal_12 when Sel = "1100" else
					Canal_13 when Sel = "1101" else
					Canal_14 when Sel = "1110" else
					Canal_15;
end rtl;
