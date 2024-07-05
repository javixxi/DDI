--PROCESO MEMORIA CONF_PULS_P1:

process(clk, nRst)
begin

  if nRst = '0' then
    reg1_P1 <= '0';
    reg2_P1 <= '0';
  elsif clk'event and clk = '1' then

    if P_1 = '1' then

      reg1_P1 <= P_1;
      reg2_P1 <= reg1_P1;
    else
      reg1_P1 <= '0';
      reg2_P1 <= '0';
     
    end if; 
  end if;
end process;

--PROCESO SALIDA CONF_PULS_P1:

  MODO <= '1' when reg1_P1 = '1' and reg2_P1 = '0' else
          '0';

--PROCESO MEMORIA CONF_PULS_P2:

process(clk, nRst)
begin

  if nRst = '0' then
    reg1_P2 <= '0';
    reg2_P2 <= '0';
  elsif clk'event and clk = '1' then

    if P_2 = '1' then

      reg1_P2 <= P_2;
      reg2_P2 <= reg1_P2;
    else
      reg1_P2 <= '0';
      reg2_P2 <= '0';
     
    end if; 
  end if;
end process;

--PROCESO SALIDA CONF_PULS_P2:

  SHIFT <= '1' when reg1_P2 = '1' and reg2_P2 = '0' else
          '0';
