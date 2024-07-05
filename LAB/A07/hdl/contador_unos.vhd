library ieee;
use ieee.std_logic_1164.all;

--entity
entity contador_unos is
	port(	clk, an_rst	:	in std_logic;
			e			:	in std_logic;
			s			:	buffer std_logic_vector(1 downto 0)
		);
end entity;

--architecture
architecture rtl of contador_unos is
	type t_state is (cero, one, two, three, four, five, six, seven);
	signal state	:	t_state;
begin

	proceso_estados: process(clk, an_rst)
	begin
		
		if an_rst = '0' then
			state <= cero;
		elsif clk'event and clk = '1' then
			case state is
				when cero =>
					if e = '1' then
						state <= one;
					end if;
				when one =>
					if e = '1' then
						state <= three;
					else
						state <= two;
					end if;
				when two =>
					if e = '1' then
						state <= five;
					else
						state <= four;
					end if;
				when three =>
					if e = '1' then
						state <= seven;
					else
						state <= six;
					end if;
				when four =>
					if e = '1' then
						state <= one;
					else
						state <= cero;
					end if;
				when five =>
					if e = '1' then
						state <= three;
					else
						state <= two;
					end if;
				when six =>
					if e = '1' then
						state <= five;
					else
						state <= four;
					end if;
				when seven =>
					if e = '0' then
						state <= six;
					end if;
			end case;
		end if;		
	end process;
	
	s <= 	"00" when state = cero else
			"01" when state = one OR state = two OR state = four else
			"10" when state = three OR state = five OR state = six else
			"11";
			
end rtl;