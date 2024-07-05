library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--entity
entity tb_rest4bits is
end entity;

--architecture
architecture test of tb_rest4bits is
	signal A:	std_logic_vector (3 downto 0);
	signal B:	std_logic_vector (3 downto 0);
	signal S:	std_logic_vector (3 downto 0);
begin
	
	dut: entity work.rest4bits(rtl)
		port map(	--port => signal
					A => A,
					B => B,
					S => S 
				);
	
	process
	begin
		A <= "0000";
		B <= "0000";
		for i in 0 to 15 loop
			for j in 0 to 15 loop
				wait for 100 ns;
				B <= B + 1;
				
			end loop;
			A <= A + 1;
		
		end loop;
		wait;
	end process;
end test;