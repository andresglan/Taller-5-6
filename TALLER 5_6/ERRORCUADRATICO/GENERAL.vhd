
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity GENERAL is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           INICIO : in  STD_LOGIC;
           UNIDADES,DECIMALL : out  STD_LOGIC_VECTOR (15 downto 0);
			  db : out  STD_LOGIC_VECTOR (7 downto 0);
           rs : out  STD_LOGIC;
           rw : out  STD_LOGIC;
           ena : out  STD_LOGIC;			  
           FINAL : out  STD_LOGIC);
end GENERAL;

architecture Behavioral of GENERAL is

component ERRORCUADRATICO is
    Port ( Y : in  STD_LOGIC_VECTOR (7 downto 0);
           T : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           INICIO : in  STD_LOGIC;
			  I : inout  STD_LOGIC_VECTOR (7 downto 0);
           SOL : out  STD_LOGIC_VECTOR (15 downto 0);
			  DECIMALL: out STD_LOGIC_VECTOR(15 downto 0);
           FINAL : out  STD_LOGIC);
end component;

component ROMY is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           SalNums : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component ROMT is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           SalNums : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component CONVERTIDOR is
    generic(N: positive := 16);
    port(
        clk, reset: in std_logic;
        binary_in: in std_logic_vector(N-1 downto 0);
        bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0)
    );
end component;

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

signal YY,TT,II: STD_LOGIC_VECTOR(7 downto 0);
signal UNID,DECE,CENT,UNIDMIL,DECMIL,UNIDADUN,DECUN,CENTUN,UNIDMILUN,DECMILUN: STD_LOGIC_VECTOR(3 downto 0);
signal DECCIMALL,UNIDADD1: STD_LOGIC_VECTOR(15 downto 0);
begin

m1: ERRORCUADRATICO port map(YY,TT,CLK,RST,INICIO,II,UNIDADD1,DECCIMALL,FINAL);
DECIMALL<=DECCIMALL;
UNIDADES<=UNIDADD1;
m2: ROMY port map(II,YY);
m3: ROMT port map(II,TT);
m4: CONVERTIDOR port map(CLK,RST,DECCIMALL,UNID,DECE,CENT,UNIDMIL,DECMIL);
m5: lcd_moduleC port map(CLK,RST,DECMILUN,UNIDMILUN,CENTUN,DECUN,UNIDADUN,DECE,UNID,db,rs,rw,ena);
m6: CONVERTIDOR port map(CLK,RST,UNIDADD1,UNIDADUN,DECUN,CENTUN,UNIDMILUN,DECMILUN);
end Behavioral;

