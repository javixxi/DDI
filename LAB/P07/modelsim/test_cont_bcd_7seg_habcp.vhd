-- Autor: M. Garrido
-- Fecha: TBC
-- Test del contador BCD con conformador para habilitacion y salida con descodificador de BCD a 7 segmentos

library ieee;
use ieee.std_logic_1164.all;

entity test_cont_bcd_7seg_habcp is
end entity;

architecture test of test_cont_bcd_7seg_habcp is
  signal an_rst 	: std_logic;
  signal clk 		: std_logic;
  signal pulso_hab 	: std_logic;
  signal disp7seg 	: std_logic_vector(6 downto 0);
  constant tclk 	: time := 83 ns;
begin

	dut: entity work.cont_bcd_7seg_habcp(rtl) 
		port map( 	an_rst      => an_rst,
					clk        	=> clk,
					pulso_hab   => pulso_hab,
					disp7seg    => disp7seg
	);

	clock: process
	begin
		clk <= '0';
		wait for tclk/2;
		clk <= '1';
		wait for tclk/2;
	end process;

	process
	begin
		pulso_hab <= '1';
		an_rst <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		an_rst <= '1';
		wait until clk'event AND clk = '1';
		pulso_hab <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		pulso_hab <= '1';
		wait until clk'event AND clk = '1';
		pulso_hab <= '0';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait until clk'event AND clk = '1';
		wait;
	end process;


end test;