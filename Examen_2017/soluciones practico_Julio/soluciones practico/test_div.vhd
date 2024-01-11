-- Test del circuito divisor (Ej 6 del examen de DD1)
-- Autor: 
-- Fecha:

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_div is
end entity;

architecture test of test_div is
  signal clk       : std_logic;
  signal Rstn      : std_logic;
  signal start     : std_logic;
  signal dividendo : std_logic_vector(7 downto 0);
  signal divisor   : std_logic_vector(7 downto 0);
  signal cociente  : std_logic_vector(7 downto 0);
  signal resto     : std_logic_vector(7 downto 0);
  signal busy      : std_logic;


  constant TCLK: time := 100 ns;

begin

  process
  begin
    clk <= '0';
    wait for TCLK/2;
    clk <= '1';
    wait for TCLK/2;
  end process;

dut: entity work.div(rtl) port map(
  clk       => clk,
  Rstn      => Rstn,
  start     => start,
  dividendo => dividendo,
  divisor   => divisor,
  cociente  => cociente,
  resto     => resto,
  busy      => busy
);
  process
  begin
    Rstn <= '0';
    start <= '0';
    dividendo <=(others => '0');
    divisor <=(others => '0');
    wait until clk'event and clk='1';
    wait until clk'event and clk='1';
    Rstn <= '1';
    wait until clk'event and clk='1';
    -- 10:3=3, resto 1
    dividendo <= X"0A";
    divisor <= X"03";
    wait until clk'event and clk='1';
    start <= '1';
    wait until clk'event and clk='1';
    start <= '0';
    wait for 20*TCLK;
    wait until clk'event and clk='1';
    -- 0:8=0, resto 0
    dividendo <= X"00";
    divisor <= X"08";
    wait until clk'event and clk='1';
    start <= '1';
    wait until clk'event and clk='1';
    start <= '0';
    wait for 20*TCLK;
    wait until clk'event and clk='1';
	-- 255:28=9, resto 3
    dividendo <= X"FF";
    divisor <= X"1C";
    wait until clk'event and clk='1';
    start <= '1';
    wait until clk'event and clk='1';
    start <= '0';
    wait for 20*TCLK;
    wait until clk'event and clk='1';
    assert(false) report"fin de la simulacion" severity failure;
  end process;

end test;