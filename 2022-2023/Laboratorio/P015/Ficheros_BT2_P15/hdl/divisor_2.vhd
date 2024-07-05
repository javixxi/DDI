library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divisor_2 is
port(clk:     in     std_logic;
     nRst:    in     std_logic;
     f_out_1: buffer std_logic;
     f_out_2: buffer std_logic);
end entity;

architecture rtl of divisor_2 is
		signal cnt_md_4:			std_logic_vector(1 downto 0);
		signal FCD:						std_logic;
		signal F_OUT_2_CNT:		std_logic_vector(1 downto 0);
		signal F_OUT_2_ENA:		std_logic;
  
begin
  -- Contador modulo 4 con salida de fin de cuenta
	process(clk, nRst)
	begin
		if nRst = '0' then
			FCD <= '0';
		elsif clk'event and clk = '1' then
			if cnt_mod_4 /= "11" then
				cnt_mod_4 = cnt_mod_4 + 1;
				FDC <= '0';
			else
				cnt_mod_4 <= "00";
				FDC <= '1';
			end if;
		end if;
	end process;
  
  f_out_1 <= FCD;

  
  
  -- Contador módulo 3 con entrada de habilitación y salida
	process(clk, nRst)
	begin
		if nRst = '0' then
			F_OUT_2_CNT <= '0';
		elsif clk'event and clk = '1' then
			if f_out_1 = '1' then

				if F_OUT_2_CNT /= "10" then
					F_OUT_2_CNT <= F_OUT_2_CNT +1;
				else
					F_OUT_2_CNT <= "00";
				end if;
				
			end if;
		end if;
	end process;

  -- de fin de cuenta (independiente de la entrada de habilitación)
   
  F_OUT_2_ENA <= 	'1' when F_OUT_2_CNT = "10" else
									'0';
	f_out_2 <= 			'1' when F_OUT_2_ENA is '1' AND f_out_1 is '1' else
									'0';
            
end rtl;