library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contadorBCD_2_digitos is
  port(  clk:    in std_logic;
         nRst:   in std_logic;
		 ena:    in std_logic;
		 u:      buffer std_logic_vector(3 downto 0);
		 d:      buffer std_logic_vector(3 downto 0)
	  );
end entity;

architecture rtl of contadorBCD_2_digitos is
  signal cout:  std_logic;
  signal rst:   std_logic;
begin

  
  process(clk, rst)
  begin
    if nRst = '0' then
	  u <= "0000";
	elsif clk'event AND clk = '1' then
	  if rst = '1' then
	    u <= "0000";
	  else
	    if ena = '1' then					-- si ena está activo
	      if u = 9 then                   -- si llega a 9
		    u <= "0000";                  -- pone a 0 el contador
		    cout <= '1';                  -- activa la señal que aumentará las decenas
		  else
		    u <= u + 1;
		    cout <= '0';
	      end if;
	    end if;
	  end if;
	end if;
  end process;
  
  
  process(clk, rst)
  begin
    if nRst = '0' then
	  d <= "0000";
	elsif clk'event AND clk = '1' then
	  if rst = '1' then
	    d <= "0000";
	  else
	    if cout = '1' then
	      d <= d + 1;
	    end if;
	  end if;
	end if;
  end process;
  
  rst <= '1' when u = 3 AND d = 9 AND ena = '1' else
         '0';
  
 end rtl;