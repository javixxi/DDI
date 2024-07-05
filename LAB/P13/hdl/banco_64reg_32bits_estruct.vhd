library ieee;
use ieee.std_logic_1164.all;

entity banco_64reg_32bits_estruct is
  port( clk    :  in std_logic;
        nRst   :  in std_logic;
		WE     :  in std_logic;
		Din    :  in std_logic_vector(31 downto 0);
		Dir_WR :  in std_logic_vector(5 downto 0);
		Dir_RD :  in std_logic_vector(5 downto 0);
		Dout   :  buffer std_logic_vector(31 downto 0)
	  );
end entity;

architecture estructural of banco_64reg_32bits_estruct is
  signal ENA      :  std_logic_vector(3 downto 0);
  signal Dout_B0  :  std_logic_vector(31 downto 0);
  signal Dout_B1  :  std_logic_vector(31 downto 0);
  signal Dout_B2  :  std_logic_vector(31 downto 0);
  signal Dout_B3  :  std_logic_vector(31 downto 0);
begin
 
  U_decod: entity Work.deco_2a4(rtl)
           port map( din => Dir_RD(5 downto 4),
		             ena => WE,
					 dout => ENA);
					
  U_banco0: entity Work.banco_16reg_32bits(rtl)
            port map( clk => clk,
			          nRst => nRst,
					  din => Din,
					  dir_wr => Dir_RD(3 downto 0),
					  dir_rd => Dir_RD(3 downto 0),
					  we => ENA(0),
					  dout => Dout_B0);
					
  U_banco1: entity Work.banco_16reg_32bits(rtl)
            port map( clk => clk,
			          nRst => nRst,
					  din => Din,
					  dir_wr => Dir_RD(3 downto 0),
					  dir_rd => Dir_RD(3 downto 0),
					  we => ENA(1),
					  dout => Dout_B1);
					
  U_banco2: entity Work.banco_16reg_32bits(rtl)
            port map( clk => clk,
			          nRst => nRst,
					  din => Din,
					  dir_wr => Dir_RD(3 downto 0),
					  dir_rd => Dir_RD(3 downto 0),
					  we => ENA(2),
					  dout => Dout_B2);
					
  U_banco3: entity Work.banco_16reg_32bits(rtl)
            port map( clk => clk,
			          nRst => nRst,
					  din => Din,
					  dir_wr => Dir_RD(3 downto 0),
					  dir_rd => Dir_RD(3 downto 0),
					  we => ENA(3),
					  dout => Dout_B3);
					  
  U_mux: entity Work.mux_4(rtl)
         port map( dout_b0 => Dout_B0,
		           dout_b1 => Dout_B1,
				   dout_b2 => Dout_B2,
				   dout_b3 => Dout_B3,
				   dir_rd => Dir_RD(5 downto 4),
				   dout => Dout);
				   
end estructural;