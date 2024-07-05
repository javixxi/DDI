library ieee;
use ieee.std_logic_1164.all;

--entity
entity int_thunderbird is
	port(	clk, n_rst	:	in std_logic;
			L, R		:	in std_logic;
			LC, LB, LA	:	buffer std_logic;
			RA, RB, RC	:	buffer std_logic
		);
end entity;

--architecture
architecture rtl of int_thunderbird is
	--signal s_aux	:	std_logic_vector(5 downto 0);
	type t_state is (inicial, emergencia, izda_1, izda_2, izda_3, dcha_1, dcha_2, dcha_3);
	signal state	:	t_state;
begin
	
	Proceso_Estado:
	process (clk, n_rst)
	begin
		if n_rst = '0' then
			state <= inicial;
			
		elsif clk'event AND clk = '1' then
			case state is
				when inicial =>
					if L = '1' AND R = '1' then
						state <= emergencia;
						
					elsif L = '1' AND R = '0' then
						state <= izda_1;
						
					elsif L = '0' AND R = '1' then
						state <= dcha_1;
					end if;
				
				--izquierda
				when izda_1 => 
					if L = '1' AND R = '0' then
						state <= izda_2;
					else
						state <= inicial;
					end if;
					
				when izda_2 => 
					if L = '1' AND R = '0' then
						state <= izda_3;
					else
						state <= inicial;
					end if;
				
				when izda_3 => 
					state <= inicial;
					
				--derecha
				when dcha_1 =>
					if L = '0' AND R = '1' then
						state <= dcha_2;
					else
						state <= inicial;
					end if;
				
				when dcha_2 =>
					if L = '0' AND R = '1' then
						state <= dcha_3;
					else
						state <= inicial;
					end if;
				
				when dcha_3 =>
					state <= inicial;
				
				--emergencia
				when emergencia =>
					state <= inicial;
			end case;				
		end if;
	end process;
	
	LC <=	'1' when state = izda_3 OR state = emergencia else
			'0';
	LB <=	'1' when state = izda_2 OR state = emergencia else
			'0';
	LA <=	'1' when state = izda_1 OR state = emergencia else
			'0';
			
	RA <=	'1' when state = dcha_1 OR state = emergencia else
			'0';
	RB <=	'1' when state = dcha_2 OR state = emergencia else
			'0';
	RC <=	'1' when state = dcha_3 OR state = emergencia else
			'0';
	
end rtl;