-- Circuito multiplicador (Ej 5 del examen de DD1)
-- Autor: 
-- Fecha:

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mult is port(
  clk : in std_logic;
  Rstn: in std_logic;
  ini : in std_logic;
  din : in std_logic_vector(3 downto 0);
  wr  : in std_logic;
  addw: in std_logic_vector(1 downto 0);
  addr: in std_logic_vector(1 downto 0);
  busy: buffer std_logic;
  -- busy: buffer std_logic: -- ES1
  -- dout: buffer std_logic_vector(3 downto 0); --ES2
  dout: buffer std_logic_vector(3 downto 0)
);
end entity;

architecture rtl of mult is
type t_estado is(inicial, suma);
signal estado : t_estado;
signal srst, ena_w_2, wr_ext: std_logic;
signal sum_l, sum_h, mndo, mdor: std_logic_vector(3 downto 0);
signal sum: std_logic_vector(7 downto 0);
begin

  process(clk,Rstn)
  begin
    --if Rstn = "0" then -- ES3
    if Rstn = '0' then
      mndo  <= (others => '0');
      mdor  <= (others => '0');
      sum_l <= (others => '0');
      sum_h <= (others => '0');
    elsif clk'event and clk = '1' then
      if srst = '1' then
        sum_l <= (others => '0');
        sum_h <= (others => '0');
      elsif wr_ext = '1' then
        case(addw) is
          -- when 0    => mndo <= din; -- ES4
          when "00"    => mndo <= din;
          -- when 1    => mdor <= din; -- ES4
          when "01"    => mdor <= din;
          -- when 2    => sum_l <= din; -- ES4
          when "10"    => sum_l <= din;
          when others  => sum_h <= din;
        end case;
      else
        if busy = '1' then
          mdor <= mdor -1;
        end if;
        if ena_w_2 = '1' then
          -- if ena_w_2 <= '1' then -- EF2
          sum_l <= sum(3 downto 0);
          sum_h <= sum(7 downto 4);
        end if;
      end if;
    end if;
  end process;
  dout <= mndo  when addr = 0 else
          mdor  when addr = 1 else
          sum_l when addr = 2 else
          sum_h;
  wr_ext <= wr and not busy;
  srst <= ini and not busy;
  -- srst <= ini and busy; -- EF3

  process(clk,Rstn)
  begin
    if Rstn = '0' then
    -- if Rstn = '1' then -- EF1
      estado <= inicial;
    elsif clk'event and clk = '1' then
      case(estado) is
        when inicial =>
          if ini = '1' then
            estado <= suma;
          end if;
        when suma =>
          if mdor = 0 or mndo = 0 then
            estado <= inicial;
          end if;
      end case;
    end if;
  end process;

  busy <= '1' when estado = suma else '0';
  ena_w_2 <= '1' when estado = suma and mdor /= 0 else '0';
 
  sum <= (sum_h&sum_l) + mndo;
    
  
end rtl

architecture rtl2 of mult is
type t_estado is(inicial, suma, pot2);
signal estado : t_estado;
signal srst, ena_w_2, wr_ext: std_logic;
signal sum_l, sum_h, mndo, mdor: std_logic_vector(3 downto 0);
signal sum: std_logic_vector(7 downto 0);
begin

  process(clk,Rstn)
  begin
    if Rstn = '0' then
      mndo  <= (others => '0');
      mdor  <= (others => '0');
      sum_l <= (others => '0');
      sum_h <= (others => '0');
    elsif clk'event and clk = '1' then
      if srst = '1' then
        sum_l <= (others => '0');
        sum_h <= (others => '0');
      elsif wr_ext = '1' then
        case(addw) is
          when "00"    => mndo <= din;
          when "01"    => mdor <= din;
          when "10"    => sum_l <= din;
          when others  => sum_h <= din;
        end case;
      else
        if busy = '1' then
          mdor <= mdor -1;
        end if;
        if ena_w_2 = '1' then
          sum_l <= sum(3 downto 0);
          sum_h <= sum(7 downto 4);
        end if;
      end if;
    end if;
  end process;
  dout <= mndo when addr = 0 else
          mdor when addr = 1 else
          sum_l when addr = 2 else
          sum_h;
  wr_ext <= wr and not busy;
  srst <= ini and not busy;
  

  process(clk,Rstn)
  begin
    if Rstn = '0' then
      estado <= inicial;
    elsif clk'event and clk = '1' then
      case(estado) is
        when inicial =>
          if ini = '1' then
            if mdor = 2 or mdor = 4 or mdor = 8 then
              estado <= pot2;
            else
              estado <= suma;
            end if;
          end if;
        when pot2 =>
          estado <= inicial;
        when suma =>
          if mdor = 0 or mndo = 0 then
            estado <= inicial;
          end if;
      end case;
    end if;
  end process;

  busy <= '1' when estado /= inicial else '0';
  ena_w_2 <= '1' when (estado = suma and mdor /= 0) or estado = pot2 else '0';
 
  sum <= (sum_h&sum_l) + mndo when estado = suma else
          "000"&mndo&'0' when mdor = 2 else
          "00"&mndo&"00" when mdor = 4 else
          "0"&mndo&"000";
  
    
  
end rtl2;