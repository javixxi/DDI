-- P01


-- Cabecera: cláusulas de visibilidad 	
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity cont_bcd_7seg_habcp is
  port ( clk, an_rst : in     std_logic;
         pulso_hab          : in     std_logic;
         seg7disp          : buffer std_logic_vector(6 downto 0)
         );
end entity cont_bcd_7seg_habcp;

architecture rtl of cont_bcd_7seg_habcp is
	signal pulso_reg1: std_logic;
        signal pulso_reg2: std_logic;
        signal C_IN: std_logic;
        signal CUENTA: std_logic_vector(3 downto 0);
        

begin
-- Memoria de estado
proc_estado: process (clk, an_rst )
begin
  if an_rst = '0' then
	pulso_reg1<= '1';
        pulso_reg2<= '1';
  elsif clk'event and clk = '1' then
    	pulso_reg1<=pulso_hab;
        pulso_reg2<=pulso_reg1;
  end if;
end process proc_estado;
-- Calculo de la salida
proc_salida: process (pulso_reg1, pulso_reg2)
begin
   if pulso_reg1= '0' and pulso_reg2= '1' then
	C_IN<= '1';
   else 
	C_IN<='0';
   end if;
end process proc_salida;



proc_contBCD: process(clk, an_rst,C_IN)
  begin  
    if an_rst = '0' then
       CUENTA <= "0000";
    elsif clk'event and clk = '1' then
       if C_IN= '1' then
         CUENTA <= CUENTA + 1;
       end if; 
    end if;              
end process;

proc_deco: process(CUENTA)
begin
    case CUENTA is
	  when "0000" => 
		seg7disp <= "0000001";
	  when "0001" =>
		seg7disp <= "1001111";
	  when "0010" => 
		seg7disp <= "0010010";
	  when "0011" => 
		seg7disp <= "0000110";
	  when "0100" => 
		seg7disp <= "1001100";
	  when "0101" => 
		seg7disp <= "0100100";
	  when "0110" => 
		seg7disp <= "0100000";
	  when "0111" => 
		seg7disp <= "0001111";
	  when "1000" => 
		seg7disp <= "0000000";
	  when "1001" => 
		seg7disp <= "0001100";
	  when others => 
		seg7disp <= "1111110";
	end case;
    end process;
end rtl;
