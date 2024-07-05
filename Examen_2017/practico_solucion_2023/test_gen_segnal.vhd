library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_gen_segnal is
end entity;

architecture test of test_gen_segnal is
  signal clk:     std_logic;
  signal nRst:    std_logic;
  signal we:      std_logic;
  signal dir:     std_logic_vector(1 downto 0);
  signal d_in:    std_logic_vector(7 downto 0);
  signal start:   std_logic;
  signal stop:    std_logic;
  signal s_gen:   std_logic;

  constant Tclk: time := 100 ns;

begin
  process
  begin
    clk <= '0';
    wait for Tclk/2;

    clk <= '1';
    wait for Tclk/2;

  end process;

  dut: entity work.gen_segnal(rtl)
       port map(clk   => clk,
                nRst  => nRst,
                we    => we,
                dir   => dir,
                d_in  => d_in,
                start => start,
                stop  => stop,
                s_gen => s_gen);

  process
  begin
    nRst <= '0';
    we <= '0';
    dir <= "00";
    d_in <= x"00";
    start <= '0';
    stop <= '0';
    wait for 3*Tclk;
    wait until clk'event and clk = '1';
    nRst <= '1';
    wait for 3*Tclk;
    wait until clk'event and clk = '1';
    -- pruebas con factor_div = 1
    -- inicial
    start <= '1';
    wait until clk'event and clk = '1'; 
    start <= '0';
    wait for 500*Tclk;     
    wait until clk'event and clk = '1'; 
    stop <= '1';
    wait until clk'event and clk = '1'; 
    stop <= '0';
    wait for 500*Tclk;     
    wait until clk'event and clk = '1';    
    -- L=H=1
    we <= '1';
    dir <= "00";
    d_in <= X"01";
    wait until clk'event and clk = '1';
    dir <= "01";
    d_in <= x"01";
    wait until clk'event and clk = '1'; 
    dir <= "10";
    d_in <= x"01";
    wait until clk'event and clk = '1';  
    we <= '0';
    start <= '1';
    wait until clk'event and clk = '1'; 
    start <= '0';
    wait for 10*Tclk;     
    wait until clk'event and clk = '1'; 
    stop <= '1';
    wait until clk'event and clk = '1'; 
    stop <= '0';
    wait for 10*Tclk;     
    wait until clk'event and clk = '1';  
    -- L=1, H=255
    we <= '1';
    dir <= "00";
    d_in <= x"01";
    wait until clk'event and clk = '1';
    dir <= "01";
    d_in <= x"FF";
    wait until clk'event and clk = '1'; 
    dir <= "10";
    d_in <= x"01";
    wait until clk'event and clk = '1';  
    we <= '0';
    start <= '1';
    wait until clk'event and clk = '1'; 
    start <= '0';
    wait for 1000*Tclk;     
    wait until clk'event and clk = '1'; 
    stop <= '1';
    wait until clk'event and clk = '1'; 
    stop <= '0';
    wait for 1000*Tclk;     
    wait until clk'event and clk = '1';  
    -- L=255, H=1
    we <= '1';
    dir <= "00";
    d_in <= x"FF";
    wait until clk'event and clk = '1';
    dir <= "01";
    d_in <= x"01";
    wait until clk'event and clk = '1'; 
    dir <= "10";
    d_in <= x"01";
    wait until clk'event and clk = '1';  
    we <= '0';
    start <= '1';
    wait until clk'event and clk = '1'; 
    start <= '0';
    wait for 1000*Tclk;     
    wait until clk'event and clk = '1'; 
    stop <= '1';
    wait until clk'event and clk = '1'; 
    stop <= '0';
    wait for 1000*Tclk;     
    wait until clk'event and clk = '1';     
   -- L=H=255
    we <= '1';
    dir <= "00";
    d_in <= x"FF";
    wait until clk'event and clk = '1';
    dir <= "01";
    d_in <= x"FF";
    wait until clk'event and clk = '1'; 
    dir <= "10";
    d_in <= x"01";
    wait until clk'event and clk = '1';  
    we <= '0';
    start <= '1';
    wait until clk'event and clk = '1'; 
    start <= '0';
    wait for 2000*Tclk;     
    wait until clk'event and clk = '1'; 
    stop <= '1';
    wait until clk'event and clk = '1'; 
    stop <= '0';
    wait for 2000*Tclk;     
    wait until clk'event and clk = '1';   
    -- pruebas con factor_div = 15
    -- L=H=1
    we <= '1';
    dir <= "00";
    d_in <= x"01";
    wait until clk'event and clk = '1';
    dir <= "01";
    d_in <= x"01";
    wait until clk'event and clk = '1'; 
    dir <= "10";
    d_in <= x"0F";
    wait until clk'event and clk = '1';  
    we <= '0';
    start <= '1';
    wait until clk'event and clk = '1'; 
    start <= '0';
    wait for 15*15*10*Tclk;     
    wait until clk'event and clk = '1'; 
    stop <= '1';
    wait until clk'event and clk = '1'; 
    stop <= '0';
    wait for 10*Tclk;     
    wait until clk'event and clk = '1';  
    -- L=1, H=255
    we <= '1';
    dir <= "00";
    d_in <= x"01";
    wait until clk'event and clk = '1';
    dir <= "01";
    d_in <= x"FF";
    wait until clk'event and clk = '1'; 
    dir <= "10";
    d_in <= x"0F";
    wait until clk'event and clk = '1';  
    we <= '0';
    start <= '1';
    wait until clk'event and clk = '1'; 
    start <= '0';
    wait for 15*1000*Tclk;     
    wait until clk'event and clk = '1'; 
    stop <= '1';
    wait until clk'event and clk = '1'; 
    stop <= '0';
    wait for 15*1000*Tclk;     
    wait until clk'event and clk = '1';  
    -- L=255, H=1
    we <= '1';
    dir <= "00";
    d_in <= x"FF";
    wait until clk'event and clk = '1';
    dir <= "01";
    d_in <= x"01";
    wait until clk'event and clk = '1'; 
    dir <= "10";
    d_in <= x"0F";
    wait until clk'event and clk = '1';  
    we <= '0';
    start <= '1';
    wait until clk'event and clk = '1'; 
    start <= '0';
    wait for 15*1000*Tclk;     
    wait until clk'event and clk = '1'; 
    stop <= '1';
    wait until clk'event and clk = '1'; 
    stop <= '0';
    wait for 15*1000*Tclk;     
    wait until clk'event and clk = '1';     
   -- L=H=255
    we <= '1';
    dir <= "00";
    d_in <= x"FF";
    wait until clk'event and clk = '1';
    dir <= "01";
    d_in <= x"FF";
    wait until clk'event and clk = '1'; 
    dir <= "10";
    d_in <= x"0F";
    wait until clk'event and clk = '1';  
    we <= '0';
    start <= '1';
    wait until clk'event and clk = '1'; 
    start <= '0';
    wait for 15*2000*Tclk;     
    wait until clk'event and clk = '1'; 
    stop <= '1';
    wait until clk'event and clk = '1'; 
    stop <= '0';
    wait for 15*2000*Tclk;     
    wait until clk'event and clk = '1'; 
    assert false report "Fin del test" severity failure;    
  end process;
end test;
