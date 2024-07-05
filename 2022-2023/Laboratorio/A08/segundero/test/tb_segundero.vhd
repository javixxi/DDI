library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_segundero is
end entity;

architecture test of tb_segundero is
  signal clk:		std_logic;
  signal nRst:		std_logic;
  signal nreset:	std_logic;
  signal ena:		std_logic;
  signal Q:		std_logic_vector(7 downto 0);
  constant T_CLK : time := 100 ns;
begin

  DUT: entity work.segundero(rtl) port map(
    clk 	=> clk,
    nRst 	=> nRst,
    nreset 	=> nreset,
    ena 	=> ena,
    Q 		=> Q
  );

  reloj: process
  begin
    clk <= '0';
    wait for T_CLK/2;
    clk <= '1';
    wait for T_CLK/2;
  end process;

  estimulos: process
  begin
		nRst <= '0';
		ena <= '0';
		nreset <= '0';
		wait until clk'event and clk = '1';
		nRst <= '1';
		ena <= '1';
		nreset <= '1';
		wait until clk'event and clk = '1';
		wait;
		
	end process;
end test;