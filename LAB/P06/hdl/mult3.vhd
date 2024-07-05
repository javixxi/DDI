library ieee;
use ieee.std_logic_1164.all;

--entity
entity mult3 is
	port(	clk, an_rst		:	in std_logic;
			e				:	in std_logic;
			s				:	buffer std_logic
		);
end entity;

--architecture
architecture rtl of mult3 is
	type t_estado is (CERO, UNO, DOS);
	signal estado : t_estado;
begin
	
	process_state: process  (an_rst, clk)
	begin
		if an_rst = '0' then
			estado <= CERO;
		elsif clk'event and clk = '1' then
			case estado is
			
				when CERO =>
					if e = '1' then
						estado <= UNO;
					end if;
					
				when UNO =>
					if e = '1' then
						estado <= DOS;
					else
						estado <= CERO;
					end if;
					
				when DOS =>
					if e = '0' then
						estado <= UNO;
					end if;
			end case;
		end if;
	end process;
	
	s <= 	'1' when ((estado = CERO) AND e = '1') OR ((estado = UNO) AND e = '0') OR ((estado = DOS) AND e = '1') else
			'0';
end rtl;