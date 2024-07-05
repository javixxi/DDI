-- Test-Bench del modelo de registro de 16 bits





library ieee;
use ieee.std_logic_1164.all;

entity reg16b_ena_rst_TB is
end entity;

architecture Test of reg16b_ena_rst_TB is
  signal CLK:	std_logic;
  signal nRST:	std_logic;
  signal sRST:	std_logic;
  signal ena:	std_logic;
  signal Din:	std_logic_vector(15 downto 0);
  signal Dout:	std_logic_vector(15 downto 0);

  constant T_CLK: time:= 100 ns;

begin

dut: entity Work.reg16b_ena_rst(rtl)
     port map(CLK => CLK,
	      nRST => nRST,
	      sRST => sRST,
	      ena => ena,
	      Din => Din,
	      Dout =>Dout);

process
begin
  CLK <= '0';
  wait for T_CLK/2;
  CLK <= '1';
  wait for T_CLK/2;
end process;

process
begin
   nRST <= '0';
   sRST <= '0';
   ena <= '0';
   Din <= X"0000";

  wait until CLK'event and CLK = '1';
  wait until CLK'event and CLK = '1';
   nRST <= '1';
   ena <= '1';
   Din <= X"AAAA";

  wait until CLK'event and clk = '1';
   sRST <= '1';

  wait until CLK'event and CLK = '1';
   sRst <= '0';
   Din <= X"5555";

  wait until CLK'event and CLK = '1';
   ena <= '0';
   Din <= X"1234";

  wait until CLK'event and CLK = '1';
   sRST <= '1';

  wait until CLK'event and CLK = '1';
   wait;
end process;
end Test;