library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divisor_3 is
port(clk:       in     std_logic;
     nRst:      in     std_logic;
     f_div_250: buffer std_logic;
     f_div_125: buffer std_logic;
     f_div_50:  buffer std_logic);
end entity;

architecture rtl of divisor_3 is
  signal cnt_div_250: std_logic_vector(5 downto 0);
  signal ff_div_125 : std_logic;
  signal cnt_div_50 : std_logic_vector(2 downto 0);
begin
  -- Complete la descripción del circuito
  process(clk, nRst)
  begin
    if nRst = '0'then 
	  cnt_div_250 <= (others => '0');
	elsif clk'event AND clk = '1' then
	  if f_div_250 = '1' then
	    cnt_div_250 <= (others => '0');
		
	  else
	    cnt_div_250 <= cnt_div_250 + 1;
      end if;
	end if;
  end process;
  
  f_div_250 <= '1' when cnt_div_250 = 47 else
               '0';
			   
  process(clk, nRst)
  begin
    if nRst = '0'then 
	  ff_div_125 <= '0';
	elsif clk'event AND clk = '1' then
	  if f_div_250 = '1' then
	    ff_div_125 <= NOT(ff_div_125);
	  end if;
	end if;
  end process;
  
  f_div_125 <= '1' when f_div_250 = '1' AND  ff_div_125 = '1' else
               '0';

  process(clk, nRst)
  begin
    if nRst = '0' then 
	  cnt_div_50 <= (others => '0');
	elsif clk'event AND clk = '1' then
	  if f_div_250 = '1' then
	    if cnt_div_50 = 4 then 
		  cnt_div_50 <= (others => '0');
		else
		  cnt_div_50 <= cnt_div_50 + 1;
	    end if;
	  end if;
	end if;
  end process;
  
  f_div_50 <= '1' when cnt_div_50 = 4 AND f_div_250 = '1' else
              '0';  

end rtl;