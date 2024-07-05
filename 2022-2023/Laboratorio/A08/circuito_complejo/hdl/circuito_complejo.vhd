-- Circuito Complejo
-- Actividad A08
-- Javier Garcia Moreno

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity circuito_complejo is
port(	clk:	  in std_logic;
	nRst:	  in std_logic;
	p_1:	  in std_logic;
	p_2:	  in std_logic;
	L1:	  buffer std_logic;
	L2:	  buffer std_logic;
	L3:	  buffer std_logic;
	L4:	  buffer std_logic;
	L6:	  buffer std_logic;
	L7:	  buffer std_logic;
	L8:	  buffer std_logic;
	seg7dip:  buffer std_logic_vector(7 downto 0);

);
end entity;

architecture rtl of circuito_copmplejo is
  type t_estado is 	(reposo, period_dcha, period_izda, sec_dcha, sec_izq);
  signal estado: 	t_estado;
-- Senales Timer
  signal tic: 		std_logic;
  signal cont: 		integer;
-- senales conformador
  signal p_1_reg1:	std_logic;
  signal p_1_reg2:	std_logic;
  signal p_1_pulso:	std_logic;
  signal p_2_reg1:	std_logic;
  signal p_2_reg2:	std_logic;
  signal p_2_pulso:	std_logic;
begin

proc_estado: process (tic, nRst)
begin

end process;










--Proceso del timer
proc_timer : process(nRst, clk)
begin
  if nRst = '0' then 
    cont <= 0;
  elsif(clk'event and clk ='1') then
    cont <= cont + 1;
    if cont = 3600000 then 
      tic <= '1';
      cont <= 0;
    else tic <='0';
    end if;
  end if;
end process proc_timer;

-- Proceso del conformador p_1
proc_pulso_p_1: process (p_1_reg1, p_1_reg2)
begin
   if p_1_reg1= '0' and p_1_reg2 = '1' then
	p_1_pulso<= '1';
   else 
	p_1_pulso<='0';
   end if;
end process proc_pulso_p_1;

-- Proceso del conformador p_2
proc_pulso_p_2: process (p_2_reg1, p_2_reg2)
begin
   if p_2_reg1= '0' and p_2_reg2 = '1' then
	p_2_pulso<= '1';
   else 
	p_2_pulso<='0';
   end if;
end process proc_pulso_p_2;
