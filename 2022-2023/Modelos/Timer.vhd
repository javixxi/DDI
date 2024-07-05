--PROCESO MEMORIA TIMER:

process(nRst, clk)
begin

  if nRst = '0' then
    contador <= (others => '0');
  elsif clk'event and clk = '1' then
  
--  if SHIFT = '1' then
--     contador <= (others => '0');

   if contador /= fin_cuenta then
       contador <= contador + 1;
      elsif (contador = fin_cuenta) then
        contador <= (others => '0');
      end if;
  end if;
end process;

--PROCESO SALIDA CONTADOR

--  Tic <= '1' when contador = 22 else  --DESCOMENTAR PARA SINTESIS
--         '0';

  Tic <= '1' when contador = fin_cuenta else  --DESCOMENTAR PARA SIMULACION
         '0';
