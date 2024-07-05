-- conf_monoestable


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity conf_monoestable is
  port ( clk, an_rst : in     std_logic;
         pulsador    : in     std_logic;
         pulse       : buffer std_logic
         );
end entity conf_monoestable;

architecture rtl of conf_monoestable is
	signal TRG: std_logic; -- salida conformador (S)
        signal CUENTA: std_logic_vector(25 downto 0);
        signal ENA: std_logic; 
        signal pulso_reg1: std_logic;
        signal pulso_reg2: std_logic;
-- Conformador
begin
-- Memoria de estado



proc_estado: process (clk, an_rst )
begin
  if an_rst = '0' then
	pulso_reg1<= '1';
        pulso_reg2<= '1';
  elsif clk'event and clk = '1' then
    	pulso_reg1<=pulsador;
        pulso_reg2<=pulso_reg1;
  end if;
end process proc_estado;
-- Calculo de la salida
proc_salida: process (pulso_reg1, pulso_reg2)
begin
   if pulso_reg1= '0' and pulso_reg2= '1' then
	TRG<= '1';
   else 
	TRG<='0';
   end if;
end process proc_salida;

-- Contador 

proc_cont: process(clk, an_rst,TRG,ENA)
  begin  
    if an_rst = '0' then
       CUENTA <= (others =>'0');
       
    elsif clk'event and clk = '1' then
       if TRG= '1' or ENA= '1' then 
          if CUENTA = "10110111000110110000000000" then
                CUENTA <= (others =>'0');
          else 
                CUENTA <= CUENTA + 1;
          end if;
        
       end if; 
    end if;              
end process proc_cont;

-- comparador

proc_comp: process(CUENTA)
  begin  
    if CUENTA /= 0 then
       ENA <= '1' ;
       
    else 
       ENA <= '0' ;
       
        
    end if;              
end process proc_comp;

pulse<= ENA;
end  rtl;