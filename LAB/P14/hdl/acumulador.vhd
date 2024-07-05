library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity acumulador is
  port( clk, nRst :  in std_logic;
        E         :  in std_logic_vector(7 downto 0);
        INI       :  in std_logic;
		ENA       :  in std_logic;
		S         :  buffer std_logic_vector(7 downto 0));
end entity;

architecture rtl of acumulador is
  signal dout   :  std_logic_vector(7 downto 0);
begin

  Dout <= E when ENA = '1' AND INI = '1' else
	      S + E;
		  
  Proceso_Registro:
  process(clk, nRst)
  begin
    
	if nRst = '0' then
		S <= (others => '0');
	elsif clk'event AND clk = '1' then
		if ENA = '1' then 
			S <= dout;
		end if;
	end if;
	
  end process;
			
end rtl;