library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity ERRORCUADRATICO is
    Port ( Y : in  STD_LOGIC_VECTOR (7 downto 0);
           T : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           INICIO : in  STD_LOGIC;
			  I : inout  STD_LOGIC_VECTOR (7 downto 0);
           SOL : out  STD_LOGIC_VECTOR (15 downto 0);
			  DECIMALL: out STD_LOGIC_VECTOR(15 downto 0);
           FINAL : out  STD_LOGIC);
end ERRORCUADRATICO;

architecture Behavioral of ERRORCUADRATICO is

type estados_asm is (ST0,ST1,ST2,ST3,ST4,ST5,ST6,ST7,ST8,ST9,ST10,ST11,ST12,ST13,ST14,ST15,ST16,ST17,ST18);
signal ST : estados_asm;

signal numerador: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal denominador: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal unidades: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal vten: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal multi: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal decimal: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal RESTA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal DATOY: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal DATOT: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal NUMDATA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal CUADRADO: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal SUM: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal J: STD_LOGIC_VECTOR(3 downto 0);

begin

vten<="0000000000001010";

process (clk,RST,inicio)

	begin

	if RST= '1'then
		ST<=ST0;
	elsif clk'event and clk='1' then

		case ST is
		
			when ST0 =>
				I<=(others =>'0');
				if inicio='0' then
					ST<=ST0;
				else
					ST<=ST1;
				end if;
				
			when ST1 =>
				RESTA<=(others => '0');
				CUADRADO<=(others =>'0');
				SUM<=(others =>'0');
				NUMDATA<=Y;
				ST<=ST2;
				
			when ST2=>
				I<=I+1;
				ST<=ST3;
				
			when ST3=>
				DATOY<=Y;
				DATOT<=T;
				ST<=ST4;
				
			when ST4=>
				RESTA<=DATOY-DATOT;
				ST<=ST5;
				
			when ST5=>
				CUADRADO<=RESTA*RESTA;
				ST<=ST6;
				
			when ST6=>
				SUM<=SUM+CUADRADO;
				if NUMDATA>I then
					ST<=ST2;
				else
					ST<=ST7;
				end if;
				
			when ST7=>
				numerador<=SUM;
				denominador<=NUMDATA;
				ST<=ST8;
				
			when ST8=>
				unidades<=(others =>'0');
				decimal<=(others =>'0');
				J<="0001";
				if numerador<denominador then
					ST<=ST9;
				else
					ST<=ST13;
				end if;
				
			when ST9=>
				multi<=numerador*vten;
				ST<=ST17;
			
			when ST17=>
				numerador<=multi(15 downto 0);
				ST<=ST10;
				
			when ST10=>
				if numerador >= denominador then
					ST<=ST11;
				else
					ST<=ST12;
				end if;
				
			when ST11=>
				decimaL<=decimal+1;
				numerador<=numerador-denominador;
				ST<=ST10;
				
			when ST12=>
				multi<=decimal*vten;
				J<=J+1;
				if numerador>0 and J<2 then
					ST<=ST18;
				else
					ST<=ST16;
				end if;
			
			when ST18=>
				decimal<=multi(15 downto 0);
				ST<=ST9;
				
				
			when ST13=>
				if numerador>=denominador then
					st<=ST14;
				else
					st<=ST15;
				end if;

			when ST14=>
				unidades<=unidades+1;
				numerador<=numerador-denominador;
				ST<=ST13;
				
			when ST15=>
				if numerador>0 then
					st<=ST9;
				else
					st<=ST16;
				end if;

			when ST16=>
				SOL<=unidades;
				
				DECIMALL<=DECIMAL;
				ST<=ST0;
			when others=>
				ST<=ST0;
		end case;
	end if;
end process;
final<='1' when ST=ST16 else '0' ;

end Behavioral;

