--Autor:Castellana Antonio
--Fecha: 09-01-2023
--------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_SumadorBCD is
end entity;


architecture test of tb_SumadorBCD is

signal  a: std_logic_vector(3 downto 0);
signal  b:  std_logic_vector(3 downto 0);
signal  c_in:  std_logic;
signal  c_out:  std_logic;
signal  s:  std_logic_vector(3 downto 0);

constant T: time := 100 ns; 
begin 

dut:entity work.SumadorBCD(rtl)
port map(

	a => a,
	b => b,
	c_in => c_in,
	c_out => c_out,
	s => s
);

process
begin
------------ c_in <= 0 -----------------------
c_in<='0';
b<=X"0";
for j in 0 to 9 loop
  if j = 0 then
    a<=x"0";
  else
    a<=a+1;
  end if;
    for i in 0 to 9 loop
      if b<9 then
        b<=b+1;
        wait for T;
      else 
        b<="0000";
        wait for T;
      end if;
    end loop;
end loop;
-------------------------------------------------

--------------- c_in<=1 -------------------------
c_in<='1';
b<=X"0";
for j in 0 to 9 loop
  if j = 0 then
    a<=x"0";
  else
    a<=a+1;
  end if;
    for i in 0 to 9 loop
      if b<9 then
        b<=b+1;
        wait for T;
      else 
        b<="0000";
        wait for T;
      end if;
    end loop;
end loop;
-----------------------------------------------
   
   wait;



--a<= X"0";
--b<= X"0";
--c_in<= '1';
--wait for 2*T;
--a<= X"5";
--b<= X"0";
--c_in<= '0';
--wait for 2*T;
--a<= X"0";
--b<= X"5";
--c_in<= '1';
--wait for 2*T;
--a<= X"1";
--b<= X"2";
--c_in<= '1';
--wait for 2*T;
--a<= X"4";
--b<= X"5";
--c_in<= '0';
--wait for 2*T;
--a<= X"5";
--b<= X"5";
--c_in<= '1';
--wait for 2*T;
--a<= X"9";
--b<= X"5";
--c_in<= '1';
--wait for 2*T;
--a<= X"9";
--b<= X"9";
--wait;


end process;

end test;