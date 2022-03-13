library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity BANCO_REGISTROS is
    Port ( SR : in  STD_LOGIC_VECTOR (15 downto 0);--VALOR DE ENTRADA
           Clock : in  STD_LOGIC;
           wr_add : in  STD_LOGIC_VECTOR (3 downto 0);--
           enA : in  STD_LOGIC;--ENABLE A
           enB : in  STD_LOGIC;--ENABLE B
           DirA : in  STD_LOGIC_VECTOR (3 downto 0);--DIRECCION A
           DirB : in  STD_LOGIC_VECTOR (3 downto 0);--DIRECCION B
           We : in  STD_LOGIC;--WRITE ENABLE
           A : out  STD_LOGIC_VECTOR (15 downto 0);--SALIDA A
           B : out  STD_LOGIC_VECTOR (15 downto 0));--SALIDA B
end BANCO_REGISTROS;

architecture Behavioral of BANCO_REGISTROS is
	type banco is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
	signal BanK:banco;
begin
process(Clock, We,Bank,Wr_add, SR, enA, enB, DirA, DirB)
begin
	if Clock'event and Clock='1' then
		if We='1' then
		Bank(conv_integer(wr_add))<=SR;
		end if;
	end if;
end process;
	A<=Bank(conv_integer(DirA)) when EnA='1' else "0000000000000000";
	B<=Bank(conv_integer(DirB)) when EnB='1' else "0000000000000000";
end Behavioral;
