library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity monoestable is
	port(	clk, an_rst	:	in std_logic;
			e 			:	in std_logic;
			s			:	buffer std_logic
		);
end entity;

--architecture
architecture rtl of monoestable is
	--conformador
	signal trigger		:	std_logic;
	type t_conf_state is (inactivo, activo, espera);
	signal conf_state	:	t_conf_state;
	--contador
	signal cuenta		:	std_logic_vector(2 downto 0);
	signal fdc			:	std_logic;
begin
	
	Proceso_monoestable:
	process(clk, an_rst)
	begin
	
		if an_rst = '1' then
			conf_state <= inactivo;
			
		elsif clk'event AND clk = '1' then
			case conf_state is
				when inactivo => 
					if e = '1' then
						conf_state <= activo;
					end if;
				when activo =>
					conf_state <= espera;
				when espera =>
					if e = '0' then 
						conf_state <= inactivo;
					end if;
			end case;
		end if;
	end process;
	
	trigger <=	'1' when conf_state = activo else
				'0';
	
	Proceso_contador:
	process(clk, an_rst)
	begin
		
		if an_rst = '1' then
			cuenta <= "000";
		elsif clk'event AND clk = '1' then
		
			if trigger = '0' AND cuenta= "000" then
			elsif fdc = '1' then
				cuenta <= "000";
			else
				cuenta <= cuenta + 1;
			end if;
			
		end if;
	end process;
	
	fdc <=	'1' when cuenta = "100" else
			'0';
	
	s <= 	'1' when cuenta /= "000" else
			'0';
	
end rtl;