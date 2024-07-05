library ieee;
use ieee.std_logic_1164.all;

--entidad:
entity reg16b_ena_rst is
port(
	sRST:	in std_logic;
	nRST:	in std_logic;
	ENA:	in std_logic;
	clk:	in std_logic;
	Din:	in std_logic_vector (15 downto 0);
	Dout:	buffer std_logic_vector (15 downto 0)
	);
end entity;

architecture rtl of reg16b_ena_rst is
begin

	process (clk, nRST)
	begin
		if nRST = '0' then
			Dout <= (Others => '0');
			
		elsif clk'EVENT and clk = '1' then
		
			if sRST = '1' then
				Dout <= (Others => '0');
				
			elsif ENA = '1' then
				Dout <= Din;
				
			end if;
			
		end if;
		
	end process;
end rtl;
	
	