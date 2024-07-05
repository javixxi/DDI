library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity cont_desc is
	port(	clk, an_rst	:	in std_logic;		--Reset asincrono activo a nivel bajo
			rst			:	in std_logic;	
			s			:	buffer std_logic_vector(15 downto 0)
		);
end entity;

--architecture
architecture rtl of cont_desc is
begin

	process(clk, an_rst)
	begin
		if an_rst = '0' then
			s <= X"FFFF";
			
		elsif clk'event AND clk = '1' then
			if rst = '1' then
				s <= X"0003";
			else
				case s is
					when X"0000" =>
						s <= X"FFFF";
					when others =>
						s <= s - 1;
				end case;
			end if;
		end if;
	end process;
end rtl;
			