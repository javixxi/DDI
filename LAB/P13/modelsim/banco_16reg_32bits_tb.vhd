library ieee;
use ieee.std_logic_1164.all;

entity banco_16reg_32bits_tb is
end entity;

architecture test of banco_16reg_32bits_tb is
  signal  clk      :  std_logic;
  signal  nRst     :  std_logic;
  signal  din      :  std_logic_vector(31 downto 0);
  signal  dir_wr   :  std_logic_vector(3 downto 0);
  signal  we       :  std_logic;
  signal  dir_rd   :  std_logic_vector(3 downto 0);
  signal  dout     :  std_logic_vector (31 downto 0);
  constant t_clk : time := 100 ns;
begin

  dut: entity work.banco_16reg_32bits(rtl)
    port map(  clk => clk,
	           nRst => nRst,
			   din => din,
			   dir_wr => dir_wr,
			   we => we,
			   dir_rd => dir_rd,
			   dout => dout
			);

  Proceso_reloj:
  process
  begin
	clk <= '1';
	wait for t_clk/2;
	clk <= '0';
	wait for t_clk/2;
  end process;
  
  Procesp_test:
  process
  begin
	nRst <= '0';
	din <= (others => '0');
	dir_wr <= (others => '0');
	we <= '0';
	dir_rd <= (others => '0');
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	nRst <= '1';
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	dir_wr <= "0001";
	we <= '1';
	din <= X"AAAF35CE";
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	dir_rd <= "0001";
	wait until clk'event AND clk = '1';
	wait until clk'event AND clk = '1';
	wait;
	
  end process;
  
end test;
	
	