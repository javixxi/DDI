--usar espacios no tabuladores 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mult_8x8_seq is
	port(	clk		:	in std_logic;
			nRst	:	in std_logic;
			start	:	in std_logic;
			a		:	in std_logic_vector(7 downto 0);
			b		:	in std_logic_vector(7 downto 0);
			fin		:	buffer std_logic;
			mult	:	buffer std_logic_vector(15 downto 0)
		);
end entity;

architecture rtl of mult_8x8_seq is
	signal mndo		:	std_logic_vector(3 downto 0);
	signal mdor		:	std_logic_vector(3 downto 0);
	signal sel_mndo	:	std_logic;
	signal sel_mdor	:	std_logic;
	signal factor_1	:	std_logic_vector(3 downto 0);
	signal factor_2	:	std_logic_vector(3 downto 0);
	signal factor_3	:	std_logic_vector(3 downto 0);
	signal factor_4	:	std_logic_vector(3 downto 0);
	signal res		:	std_logic_vector(7 downto 0);
	signal pll		:	std_logic_vector(7 downto 0);		-- REG1
	signal plh		:	std_logic_vector(7 downto 0);		-- REG2
	signal phl		:	std_logic_vector(7 downto 0);		-- REG3
	signal phh		:	std_logic_vector(7 downto 0);		-- REG4
	signal we		:	std_logic;
	signal mul		:	std_logic_vector(15 downto 0);
	type t_estado	is	(e_parado, e_pll, e_plh, e_phl, e_phh, e_fin);
	signal estado	: 	t_estado;
	
begin
	--selectores
	mndo <=	b(3 downto 0) when sel_mndo = '0' else
			b(7 downto 4);
			
	mdor <=	a(3 downto 0) when sel_mdor = '0' else
			a(7 downto 4);
	
	--multiplicador 4x4
	factor_1 <= mndo when mdor(0) = '1' else
				(others => '0');
	factor_2 <= mndo when mdor(1) = '1' else
				(others => '0');
	factor_3 <= mndo when mdor(2) = '1' else
				(others => '0');
	factor_4 <= mndo when mdor(3) = '1' else
				(others => '0');
	res <= factor_1 + (factor_2 & '0') + (factor_3 & "00") + ('0' & factor_2 & "000");
	
	--Registros
	Proceso_registros:
	process(clk, nRst)
	begin
		if nRst = '0' then
			pll <= (others => '0');
			plh <= (others => '0');
			phl <= (others => '0');
			phh <= (others => '0');
		elsif clk'event AND clk = '1' then
			if we = '1' then
				if sel_mndo = '0' AND sel_mdor = '0' then
					pll <= res;
				elsif sel_mndo = '0' AND sel_mdor = '1' then
					plh <= res;
				elsif sel_mndo = '1' AND sel_mdor = '0' then
					phl <= res;
				else
					phh <= res;
				end if;
			end if;
		end if;
	end process;
	
	--calculo de la multiplicación
	mul <=	pll + ((plh + phl) & X"0") + (phh & X"00");
	
	--Controlador
	Proceso_controlador:
	process(clk, nRst)
	begin
		if nRst = '0' then
			estado <= e_parado;
		elsif clk'event AND clk = '1' then
			case estado is
				when e_parado =>
					if start = '1' then
						estado <= e_pll;
					end if;
				when e_pll =>
					estado <= e_plh;
				when e_plh =>
					estado <= e_phl;
				when e_phl =>
					estado <= e_phh;
				when e_phh =>
					estado <= e_fin;
				when e_fin =>
				
			end case;
		end if;
	end process;
	
	we 			<=	'1' when (estado /= e_parado) OR (estado /= e_fin) else
					'0';
	sel_mndo 	<=	'0' when estado = e_pll OR estado = e_plh else
					'1';
	sel_mdor	<=	'0' when estado = e_pll OR estado = e_phl else
					'1';
	fin 		<=	'1' when estado = e_fin else
					'0';
		
	
end rtl;