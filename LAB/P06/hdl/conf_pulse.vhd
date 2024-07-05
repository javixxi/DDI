library ieee;
use ieee.std_logic_1164.all;

--entity
entity conf_pulse is
	port(	clk, an_rst	:	in std_logic;
			e			:	in std_logic;
			s			:	buffer std_logic
		);
end entity;

--architecture
architecture rtl of conf_pulse is
	type t_state is (INACT, ACT, ESPERA);
	signal state	:	t_state;
begin
	
	process_state: process(clk, an_rst)
	begin
		if an_rst = '0' then
			state <= INACT;
		elsif clk'event AND clk = '1' then
			case state is
				when INACT =>
					if e = '1' then
						state <= ACT;
					end if;
				when ACT =>
					if e = '1' OR e = '0' then
						state <= ESPERA;
					end if;
				when ESPERA =>
					if e = '0' then
						state <= INACT;
					end if;
			end case;
		end if;
	end process;
	
	s <= 	'1' when state = ACT else
			'0';
			
end rtl;