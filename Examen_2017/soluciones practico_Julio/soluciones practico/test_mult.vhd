-- Test del circuito multiplicador (Ej 5 del examen de DD1)
-- Autor: 
-- Fecha:

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_mult is
end entity;

architecture test of test_mult is
  signal clk : std_logic;
  signal Rstn: std_logic;
  signal ini : std_logic;
  signal din : std_logic_vector(3 downto 0);
  signal wr  : std_logic;
  signal addw: std_logic_vector(1 downto 0);
  signal addr: std_logic_vector(1 downto 0);
  signal busy: std_logic;
  signal dout: std_logic_vector(3 downto 0);
  signal ovf : std_logic;

  constant TCLK: time := 100 ns;

begin

  process
  begin
    clk <= '0';
    wait for TCLK/2;
    clk <= '1';
    wait for TCLK/2;
  end process;
  dut: entity work.mult(rtl) port map(
    clk  => clk,
    Rstn => Rstn,
    ini  => ini,
    din  => din,
    wr   => wr,
    addw => addw,
    addr => addr,
    busy => busy,
    dout => dout
  );

  process
  begin
    Rstn <= '0';
    ini <= '0';
    din <=(others => '0');
    wr <= '0';
    addw <= "00";
    addr <= "00";
    wait until clk'event and clk='1';
    wait until clk'event and clk='1';
    Rstn <= '1';
    wait until clk'event and clk='1';
    -- 10*3=30
    din <= X"A";
    wr <= '1';
    wait until clk'event and clk='1';
    addw <= addw+1;
    din <=X"3";
    wait until clk'event and clk='1';
    wr <= '0';
    ini <= '1';
    wait until clk'event and clk='1';
    ini <= '0';
    wait for 20*TCLK;
    wait until clk'event and clk='1';
    -- 15*15=225
    din <= X"F";
    wr <= '1';
    addw <= "00";
    wait until clk'event and clk='1';
    addw <= addw+1;
    din <=X"F";
    wait until clk'event and clk='1';
    wr <= '0';
    ini <= '1';
    wait until clk'event and clk='1';
    ini <= '0';
    wait for 20*TCLK;
    wait until clk'event and clk='1';
    -- 15*0=0
    din <= X"F";
    wr <= '1';
    addw <= "00";
    wait until clk'event and clk='1';
    addw <= addw+1;
    din <=X"0";
    wait until clk'event and clk='1';
    wr <= '0';
    ini <= '1';
    wait until clk'event and clk='1';
    ini <= '0';
    wait for 20*TCLK;
    wait until clk'event and clk='1';
    -- 0*15=0
    din <= X"0";
    wr <= '1';
    addw <= "00";
    wait until clk'event and clk='1';
    addw <= addw+1;
    din <=X"F";
    wait until clk'event and clk='1';
    wr <= '0';
    ini <= '1';
    wait until clk'event and clk='1';
    ini <= '0';
    wait for 20*TCLK;
    wait until clk'event and clk='1';
    
    assert(false) report"fin de la simulacion" severity failure;
  end process;

end test;
