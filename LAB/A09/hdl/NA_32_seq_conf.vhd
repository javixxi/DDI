library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity NA_32_seq_conf is
	port(	clk		:	in std_logic;
			nRst	:	in std_logic;
			start	:	in std_logic;
			umbral	:	in std_logic_vector(4 downto 0);
			ent		:	in std_logic_vector(31 downto 0);
			fin		:	buffer std_logic;
			sal		:	buffer std_logic
		);
end entity;

architecture rtl of  NA_32_seq_conf is
	signal ent_reg	:	std_logic_vector(31 downto 0);
	signal no_unos	:	std_logic_vector(4 downto 0);
begin
	
	Proceso_Reg_desplazamiento:
	process(clk, nRst)
	begin
		if nRst = '0' then
			ent_reg <= (others => '0');
		elsif clk'event AND clk = '1' then
			if start = '1' then			--LOAD
				ent_reg <= ent;
			elsif fin = '0' then		--nENA		*¿Se puede evaluar la salida?
				ent_reg  <= ent_reg(30 downto 0) & '0';					
			end if;
		end if;
	end process;
	
	Proceso_contador_de_unos:
	process(clk, nRst)
	begin
		if nRst ='0'then
			no_unos <= (others => '0');
		elsif clk'event AND clk = '1' then
			if start = '1' then 						--RST
				no_unos <= (others => '0');
			elsif ent_reg(31) = '1' AND fin = '0' then	-- ENA & nENA
					no_unos <= no_unos + 1;
			end if;
		end if;
	end process;
	
	sal <=	'1' when no_unos > umbral AND no_unos /= "000000" else
			'0';
			
	fin <=	'1' when umbral = "00000" OR ent_reg = 0 OR no_unos > umbral else		-- = 0 solo se puede poner para ver una condición, si es asignación no puedo poner 0
			'0';
			
end rtl;