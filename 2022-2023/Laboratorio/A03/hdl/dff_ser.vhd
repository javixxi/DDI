-- Modelo de un circuito secuencial flip-flop tipo D
-- para la actividad 3 del tema 3
-- Por: Javier Garcia Moreno
-- (24-09-2022) Version 1.0

library ieee;
use ieee.std_logic_1164.all;

entity dff_ser is
port(
      nRst:	in std_logic;
      clk:	in std_logic;
      nSet_syn:	in std_logic;
      ena:	in std_logic;
      rst_syn:	in std_logic;
      D:	in std_logic;
      Q:	buffer std_logic
); 
end entity;

architecture rtl of dff_ser is
begin

-- Proceso que modela el funcionamiento
  process(clk, nRst)
  begin
	if nRst = '0' then
	  Q <= '0';

	elsif clk'event and clk = '1' then
 	  if nSet_syn = '0' then
	    Q <= '1';
	  elsif ena = '1' then
	    if rst_syn = '1' then
	      Q <= '0';
	    else
	      Q <= D;
	    end if;
	  end if;
	end if;
  end process;
end rtl;