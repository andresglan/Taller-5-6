
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ERRORC is
    Port ( INICIO : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           FINAL : out  STD_LOGIC;
			  db : out  STD_LOGIC_VECTOR (7 downto 0);
           rs : out  STD_LOGIC;
           rw : out  STD_LOGIC;
           ena : out  STD_LOGIC;	
           UNIDADES,DECIMALES : out  STD_LOGIC_VECTOR (15 downto 0));
end ERRORC;

architecture Behavioral of ERRORC is

component ROMT is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           SalNums : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component ROMY is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           SalNums : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component CD is
    Port ( Y : in  STD_LOGIC_VECTOR (7 downto 0);
           T : in  STD_LOGIC_VECTOR (7 downto 0);
           PC : in  STD_LOGIC_VECTOR (27 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           ISAL : inout  STD_LOGIC_VECTOR (7 downto 0);
           ALPHA,BETA,SIGMA,OMEGA,RHO,PHI : out  STD_LOGIC;
           DECIMALES,UNID : out  STD_LOGIC_VECTOR (15 downto 0));
end component;



component UC is
    Port ( ALPHA,BETA,SIGMA,OMEGA,RHO,PHI : in  STD_LOGIC;
           INICIO : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (27 downto 0);
           FINAL : out  STD_LOGIC);
end component;
-------------------------------------
component lcd_moduleC is 
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  -- Señales para escribir
           DECENASMIL,UNIDADESMIL,CENTENASUN,DECENASUN,UNIDADESUN,DECENASDEC,UNIDADESDEC: in std_logic_vector ( 3 downto 0); 
			  db : out  STD_LOGIC_VECTOR (7 downto 0);
           rs : out  STD_LOGIC;
           rw : out  STD_LOGIC;
           ena : out  STD_LOGIC);
end component;

component CONVERTIDOR is
    generic(N: positive := 16);
    port(
        clk, reset: in std_logic;
        binary_in: in std_logic_vector(N-1 downto 0);
        bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0)
    );
end component ;
------------------------------------
signal Y,T,ENI: STD_LOGIC_VECTOR(7 downto 0);
signal ALPHA,BETA,SIGMA,OMEGA,RHO,PHI,F: STD_LOGIC;
signal PC: STD_LOGIC_VECTOR(27 downto 0);
--------------------------------------------------------
signal UNID,DECE,CENT,UNIDMIL,DECMIL,UNIDADUN,DECUN,CENTUN,UNIDMILUN,DECMILUN: STD_LOGIC_VECTOR(3 downto 0);
signal DECCIMALL,UNIDADD1: STD_LOGIC_VECTOR(15 downto 0);
begin



m1: ROMY port map(ENI,Y);
m2: ROMT port map(ENI,T);
m3: CD port map(Y,T,PC,CLK,RST,ENI,ALPHA,BETA,SIGMA,OMEGA,RHO,PHI,DECCIMALL,UNIDADD1);
m4: UC port map(ALPHA,BETA,SIGMA,OMEGA,RHO,PHI,INICIO,CLK,RST,PC,F);

DECIMALES<=DECCIMALL;
UNIDADES<=UNIDADD1;





m5: CONVERTIDOR port map(CLK,RST,DECCIMALL,UNID,DECE,CENT,UNIDMIL,DECMIL);

m6: lcd_moduleC port map(CLK,RST,DECMILUN,UNIDMILUN,CENTUN,DECUN,UNIDADUN,CENT,DECE,db,rs,rw,ena);
m7: CONVERTIDOR port map(CLK,RST,UNIDADD1,UNIDADUN,DECUN,CENTUN,UNIDMILUN,DECMILUN);


end Behavioral;

