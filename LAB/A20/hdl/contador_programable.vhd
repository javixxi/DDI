library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contador_programable is
  port(  clk:       in std_logic;
         nRst:      in std_logic;
		 modulo:    in std_logic_vector(9 downto 0);
		 q:         buffer std_logic_vector(9 downto 0)
	  );
end entity;

architecture rtl of contador_programable is
  signal fdc:  std_logic;
begin

  process(clk, nRst)
  begin
    if nRst = '0' then
	  q <= (others => '0');
	elsif clk'event AND clk = '1' then
	  if fdc = '1' then
	    q <= (0 => '1', others => '0');
	  else
	    q <= q + 1;
	  end if;
	end if;
  end process;
  
  --comparador
  fdc <= '1' when modulo <= q OR modulo < 2 else
         '0';
end rtl;