library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity circuito_complejo is
	port(	clk, a_rst						:	in std_logic;
			p_1, p_2						:	in std_logic;
			l0, l1, l2, l3, l4, l5, l6, l7	:	buffer std_logic;
			segDisp							:	buffer std_logic_vector (6 downto 0)
		);
end entity;

--architecture
architecture rtl of circuito_complejo is
	--ticks
	signal tick				:	std_logic;
	--signal cuenta			:	std_logic_vector(21 downto 0);
	--constant periodo		:	natural	:=	12000000;
	signal cuenta			:	std_logic_vector(1 downto 0);
	constant periodo		:	natural	:=	1;
	--Conformadores
	signal pulse_aux_p1		:	std_logic;
	signal modo				:	std_logic;
	signal pulse_aux_p2		:	std_logic;
	signal shift			:	std_logic;
	--Automata
	type t_state is (periodica, derechas, izquierdas);
	signal state			:	t_state;
	type t_secuencia is (izda, dcha);
	signal secuencia		:	t_secuencia;
	signal ena_shift		:	std_logic;
	signal nL_R				:	std_logic;
	--Multiplexor
	signal d_in				:	std_logic;
	--registro de desplamiento
	signal Q				:	std_logic_vector(7 downto 0);
	--Codificador
	signal S				:	std_logic_vector(2 downto 0);
	
begin

	----------------------
	-- Generador ticks	--
	----------------------
	Proceso_generador_ticks:
	process(clk, a_rst)
	begin
		if a_rst = '1' then
			cuenta <= (others => '0');
		elsif clk'event AND clk = '1' then
			if tick = '1' then
				cuenta <= (others => '0');
			else
				cuenta <= cuenta + 1;
			end if;
		end if;
	end process;
	
	tick <=	'1' when cuenta = periodo else
			'0';
	
	----------------------
	--	Conformadores	--
	----------------------
	Proceso_conformador_P1:
	process(clk, a_rst)
	begin
		if a_rst = '1' then
			pulse_aux_p1 <= '0';
		elsif clk'event AND clk = '1' then
			pulse_aux_p1 <= p_1;
		end if;
	end process;
	
	modo <=	'1' when p_1 = '1' AND pulse_aux_p1 = '0' else
			'0';
				
	Proceso_conformador_P2:
	process(clk, a_rst)
	begin
		if a_rst = '1' then
			pulse_aux_p2 <= '0';
		elsif clk'event AND clk = '1' then
			pulse_aux_p2 <= p_2;
		end if;
	end process;
	
	shift <=	'1' when p_2 = '1' AND pulse_aux_p2 = '0' else
				'0';
				
	----------------------
	--	Automata estado	--
	----------------------
	Proceso_estados:
	process (clk, a_rst)
	begin
		if a_rst = '1' then
			state <= periodica;
		elsif clk'event AND clk = '1' then
			case state is
				when periodica =>
					if modo = '1' then
						state <= derechas;
					end if;
				when derechas =>
					if modo = '1' then
						state <= izquierdas;
					end if;
				when izquierdas =>
					if modo = '1' then
						state <= periodica;
					end if;
			end case;
		end if;
	end process;
	
	Proceso_secuencia_periodica:
	process (clk, a_rst)
	begin
		if a_rst = '1' then
			secuencia <= izda;
		elsif clk'event AND clk = '1' then
			if state = periodica then
				case secuencia is
					when izda =>
						if shift = '1' then
							secuencia <= dcha;
						end if;
					when dcha =>
						if shift = '1' then
							secuencia <= izda;
						end if;
				end case;
			end if;
		end if;
	end process;
	
	ena_shift 	<=	'1' when (state = periodica AND tick = '1') OR (state = derechas AND shift = '1') OR (state = izquierdas AND shift = '1') else
					'0';
	
	nL_R 		<=	'1' when (state = periodica AND secuencia = izda) OR (state = izquierdas) else
					'0';
					
	----------------------
	--	Multiplexor		--
	----------------------
	d_in <=	Q(0) when nL_R = '1' else
			Q(7);
			
	------------------------------
	--	Registro desplamiento	--
	------------------------------
	Proceso_registro_desplazamiento:
	process(clk, a_rst)
	begin
		if a_rst = '1' then
			Q <= (0 => '1', others => '0');
		elsif clk'event AND clk = '1' then
			if ena_shift = '1' then
				if nL_R = '0' then						--moviemiento a derechas
					Q <= Q(6 downto 0) & d_in;	--d_in va a valer Q(7)
				else									--movimiento a izquierdas
					Q <= d_in & Q(7 downto 1);		--d_in va a valer Q(0)
				end if;
			end if;
		end if;
	end process;
	
	l0 <= Q(0);
	l1 <= Q(1);
	l2 <= Q(2);
	l3 <= Q(3);
	l4 <= Q(4);
	l5 <= Q(5);
	l6 <= Q(6);
	l7 <= Q(7);
	
	----------------------
	--	Codificador		--
	----------------------	
	S <=	"001" when Q = "00000001" else
			"010" when Q = "00000010" else
			"011" when Q = "00000100" else
			"100" when Q = "00001000" else
			"101" when Q = "00010000" else
			"110" when Q = "00100000" else
			"111" when Q = "01000000" else
			"000" when Q = "10000000";
			
	--------------------------
	--	Decodificador BCD	--
	--------------------------
	segDisp <=	"1001111" when S = "001" else
				"0010010" when S = "010" else
				"0000110" when S = "011" else
				"1001100" when S = "100" else
				"0100100" when S = "101" else
				"0100000" when S = "110" else
				"0001111" when S = "111" else
				"0000000" when S = "000" else
				"-------";
end rtl;