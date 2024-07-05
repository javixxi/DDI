library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity cont2b is
port(
     clk	:  	in std_logic;
     nRst	: 	in std_logic;
     Q		:   buffer std_logic_vector(1 downto 0)
     ); 
end entity;

--architecture UNSIGNED
architecture rtl of cont2b is
begin
	process(clk, nRst)
	begin
		if nRst = '0' then
			Q <= "00";
		elsif clk'event and clk = '1' then
			Q <= Q+1;
		end if;
	end process;
end rtl;

--architecture DESCENDENTE
architecture rtl_desc of cont2b is
begin
	process(clk, nRst)
	begin
		if nRst = '0' then
			Q <= "00";
		elsif clk'event and clk = '1' then
			case Q is
				when "11" =>
					Q <= "10";
				when "10" =>
					Q <= "01";
				when "01" =>
					Q <= "00";
				when "00" =>
					Q <= "11";
				when others =>
					null;
			end case;
		end if;
	end process;
end rtl_desc;

--architecture ASCENDENTE
architecture rtl_asc of cont2b is
begin
	process(clk, nRst)
	begin
		if nRst = '0' then
			Q <= "00";
		elsif clk'event and clk = '1' then
			case Q is
				when "00" =>
					Q <= "01";
				when "01" =>
					Q <= "10";
				when "10" =>
					Q <= "11";
				when "11" =>
					Q <= "00";
				when others =>
					null;
			end case;
		end if;
	end process;
end rtl_asc; 
