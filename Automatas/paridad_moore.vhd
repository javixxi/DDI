library ieee;
use ieee.std_logic_1164.all;

--entity
entity e_parity is
	port(	clk, an_rst	:	in std_logic;
			rst			:	in std_logic;
			data_in		:	in std_logic;
			ep_out		:	buffer std_logic
		);
end entity;

--architecture
architecture rtl of e_parity is
begin

	process (clk, an_rst)
	begin
		if an_rst = '0' then
			ep_out <= '0';
		elsif clk'event and clk = '1';
			if rst = '1'then
				ep_out <= '0';
			else
				case ep_out is
					when '0' =>
						if data_in = '1' then
							ep_out = '1';
						end if;
					when '1' =>
						if data_in = '1' then
							ep_out = '0';
						end if;
					when others=>
					ep_out <= 'X';
				end case;
			end if;
		end if;‐‐ an_rst = '0'
	end process;
end architecture rtl;