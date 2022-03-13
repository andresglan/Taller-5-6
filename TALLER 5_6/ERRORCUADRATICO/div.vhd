
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity div is
port (
	clk,rst : in STD_LOGIC;
	inicio: IN STD_LOGIC;
	sumatoria: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	numdat: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	div: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	final: OUT STD_LOGIC);
end div;

architecture Behavioral of div is

type estados_asm is (st0,st1,st2,st3,st4,st5,st6,st7,st8,st9,st10,st11,st12);
signal st : estados_asm;

signal numerador: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal denominador: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal unidades: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal vten: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal multi: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal decimal1: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal decimal2: STD_LOGIC_VECTOR(3 DOWNTO 0);

begin
vten<="00001010";
process (clk,rst,inicio)

	begin

	if rst= '1'then
		st<=st0;
	elsif clk'event and clk='1' then

		case st is
		
			when st0 =>
				numerador<=sumatoria;
				denominador<=numdat;
					if inicio='0' then
						st<=st0;
					else
						st<=st1;
					end if;
			when st1 =>
				unidades<=(others => '0');
				decimal1<=(others =>'0');
				decimal2<=(others =>'0');
				if numerador<denominador then
					st<=st2;
				else
					st<=st9;
				end if;
			when st2=>
				multi<=numerador*vten;
				numerador<=multi(7 downto 0);
				st<=st3;
			when st3=>
				if numerador>=denominador then
					st<=st4;
				else
					st<=st5;
				end if;
			when st4=>
				decimal1<=decimal1+1;
				numerador<=numerador-denominador;
				st<=st3;
			when st5=>
				if numerador>0 then
					st<=st6;
				else
					st<=st12;
				end if;
			when st6=>
				multi<=numerador*vten;
				numerador<=multi(7 downto 0);
				st<=st7;
			when st7=>
				if numerador >= denominador then
					st<=st8;
				else
					st<=st12;
				end if;
			when st8=>
				decimal2<=decimal2+1;
				numerador<=numerador-denominador;
				st<=st7;
			when st9=>
				if numerador>=denominador then
					st<=st10;
				else
					st<=st11;
				end if;
			when st10=>
				unidades<=unidades+1;
				numerador<=numerador-denominador;
				st<=st9;
			when st11=>
				if numerador>0 then
					st<=st2;
				else
					st<=st12;
				end if;
			when st12=>
				div<=unidades&decimal1&decimal2;
				st<=st0;
			when others=>
					st<=st0;
		end case;
	end if;
end process;
final<='1' when st=st12 else '0' ;
end Behavioral;