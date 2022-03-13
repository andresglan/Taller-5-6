library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;



entity CD is
    Port ( Y : in  STD_LOGIC_VECTOR (7 downto 0);
           T : in  STD_LOGIC_VECTOR (7 downto 0);
           PC : in  STD_LOGIC_VECTOR (27 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           ISAL : inout  STD_LOGIC_VECTOR (7 downto 0);
           ALPHA,BETA,SIGMA,OMEGA,RHO,PHI : out  STD_LOGIC;
           DECIMALES,UNID : out  STD_LOGIC_VECTOR (15 downto 0));
end CD;

architecture Behavioral of CD is

component MUX4_1 is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
			  C : in  STD_LOGIC_VECTOR (15 downto 0);
			  DD : in  STD_LOGIC_VECTOR (15 downto 0);
           S : in  STD_LOGIC_VECTOR(1 downto 0);
           D : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component REG_NUMDATA is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           WREG : in  STD_LOGIC;
           B : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component BANCO_REGISTROS is
    Port ( SR : in  STD_LOGIC_VECTOR (15 downto 0);--VALOR DE ENTRADA
           Clock : in  STD_LOGIC;
           wr_add : in  STD_LOGIC_VECTOR (3 downto 0);--donde se escribe
           enA : in  STD_LOGIC;--ENABLE A
           enB : in  STD_LOGIC;--ENABLE B
           DirA : in  STD_LOGIC_VECTOR (3 downto 0);--DIRECCION A
           DirB : in  STD_LOGIC_VECTOR (3 downto 0);--DIRECCION B
           We : in  STD_LOGIC;--WRITE ENABLE
           A : out  STD_LOGIC_VECTOR (15 downto 0);--SALIDA A
           B : out  STD_LOGIC_VECTOR (15 downto 0));--SALIDA B
end component;

component ALU is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           M : in  STD_LOGIC;
           M1 : in  STD_LOGIC;
           M2 : in  STD_LOGIC;
           sal : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component TH is
    Port ( en : in  STD_LOGIC;
           sig : in  STD_LOGIC_VECTOR (15 downto 0);
           salida : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component CONTADOR_I is
    Port ( S0: in STD_LOGIC_VECTOR(1 downto 0);
			  CLK: in  STD_LOGIC;
			  RST: in  STD_LOGIC;
			  NUMDATA: in STD_LOGIC_VECTOR(7 downto 0);
           alpha : out  STD_LOGIC;
			  I: inout STD_LOGIC_VECTOR(7 downto 0));
end component;

component CONTADOR_UNIDADES is
    Port ( S0: in STD_LOGIC_VECTOR(1 downto 0);
			  CLK: in  STD_LOGIC;
			  RST: in  STD_LOGIC;
			  I: inout STD_LOGIC_VECTOR(15 downto 0));
end component;


component cambiodename is
    Port ( S0: in STD_LOGIC_VECTOR(1 downto 0);
			  CLK: in  STD_LOGIC;
			  RST: in  STD_LOGIC;
			  I: inout STD_LOGIC_VECTOR(7 downto 0));
end component;


signal YY,TT,RETRO,ENREG,ENAALU,ENBALU,UNIDADES,QQ: STD_LOGIC_VECTOR(15 downto 0);
signal sali,eni,NUMDATA,J: STD_LOGIC_VECTOR(7 downto 0);
signal WREG1: STD_LOGIC;
signal S0,S1,WREG3,WREG2: STD_LOGIC_VECTOR(1 downto 0);
----------------------------BANCO------------------
signal DIR4B,DIRA,DIRB: STD_LOGIC_VECTOR(3 downto 0);
signal ENA,ENB,WE: STD_LOGIC;
---------------------------------------------------
--------------------ALU y TH----------------------------
signal M,S00,S11,H: STD_LOGIC;
---------------------------------------------------
begin

YY<="00000000"&Y;
TT<="00000000"&T;

QQ<="00000000"&NUMDATA;
WREG3<=PC(27 downto 26);
WREG2<=PC(25 downto 24);
S0<=PC(23 downto 22);
ENA<=PC(21);
DIRA<=PC(20 downto 17);
ENB<=PC(16);
DIRB<=PC(15 downto 12);
WE<=PC(11);
DIR4B<=PC(10 downto 7);
WREG1<=PC(6);
S1<=PC(5 downto 4);
M<=PC(3);
S00<=PC(2);
S11<=PC(1);
H<=PC(0);
m1: CONTADOR_I port map(S1,CLK,RST,NUMDATA,alpha,ISAL);
m2: REG_NUMDATA port map(Y,WREG1,NUMDATA);
m3: MUX4_1 port map(YY,TT,RETRO,QQ,S0,ENREG);
m4: BANCO_REGISTROS port map(ENREG,CLK,DIR4B,ENA,ENB,DIRA,DIRB,WE,ENAALU,ENBALU);
m5: ALU port map(ENAALU,ENBALU,M,S00,S11,RETRO);
m6: TH port map(H,RETRO,DECIMALES);
m7: cambiodename port map(WREG3,CLK,RST,J);
m8: CONTADOR_UNIDADES port map(WREG2,CLK,RST,UNIDADES);
UNID<=UNIDADES;
-------------BETA--------------------------
process(ENAALU,NUMDATA)
begin
	if ENAALU<"00000000"&NUMDATA then
	BETA<='1';
	else
	BETA<='0';
	end if;
end process;
--------------------------------------------
-----------SIGMA----------------------------
process(ENAALU,NUMDATA)
begin
	if ENAALU>="00000000"&NUMDATA then
	SIGMA<='1';
	else
	SIGMA<='0';
	end if;
end process;
--------------------------------------------
-----------OMEGA----------------------------
process(ENBALU,NUMDATA,J)
begin
	if ENBALU>0 and J<2 then
	OMEGA<='1';
	else
	OMEGA<='0';
	end if;
end process;
--------------------------------------------
-----------RHO----------------------------
process(ENAALU,NUMDATA)
begin
	if ENAALU>="00000000"&NUMDATA then
	RHO<='1';
	else
	RHO<='0';
	end if;
end process;
--------------------------------------------
-----------PHI----------------------------
process(ENAALU)
begin
	if ENAALU>=0 then
	PHI<='1';
	else
	PHI<='0';
	end if;
end process;
--------------------------------------------
end Behavioral;

