library ieee;
use ieee.std_logic_1164.all;

entity automata is
port(
  nRst : in std_logic;
  clk  : in std_logic;
  A    : in std_logic;
  B    : in std_logic;
  S    : buffer std_logic
);
end entity;

architecture rtl of automata is
  type s_estado is (ini, uno, dos, tres, mas);
  signal estado : s_estado;
begin
  process(clk, nRst)
  begin
    if nRst = '0' then
      estado <= ini;
    elsif clk'event and clk = '1' then
      case(estado) is
        when ini => 
          if A='1' and B='1' then
            estado <= uno;
          end if;
        when uno => 
          if A='1' and B='1' then
            estado <= dos;
          else
            estado <= ini;
          end if;
        when dos => 
          if A='1' and B='1' then
            estado <= tres;
          else
            estado <= ini;
          end if;
        when tres => 
          if A='1' and B='1' then
            estado <= mas;
          else
            estado <= ini;
          end if;
        when mas => 
          if  A ='0' or B ='0'  then
            estado <= ini;
          end if;
      end case;
    end if;
  end process;

  S <= '1' when estado = tres and (A ='0' or B ='0') else
       '1' when estado = dos  and (A ='0' or B ='0') else
       '0';
end rtl;