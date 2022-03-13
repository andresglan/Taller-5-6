library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           M : in  STD_LOGIC;
           M1 : in  STD_LOGIC;
           M2 : in  STD_LOGIC;
           sal : out  STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is

signal ALU: STD_LOGIC_VECTOR(2 downto 0);
signal R: STD_LOGIC_VECTOR(7 downto 0);
signal MULT,MULT1: STD_LOGIC_VECTOR(31 downto 0);

begin

ALU<= M&M1&M2;
MULT<= A*B;
MULT1<=A*"0000000000001010";

process(A,B,ALU,MULT,MULT1)

	begin

		case ALU is
		 when "000" =>
			sal<= MULT(15 downto 0);
		 when "001" =>
			sal<= MULT1(15 downto 0);
		 when "010" =>
			sal<= A OR B;
		 when "011" =>
			sal<= A XNOR B;
		 when "100" =>
			sal<= A + 1;
		 when "101" =>
			sal<= A+B;
		 when "110" =>
			sal<= A - B;
		 when "111" =>
			sal<= B;
		 when others =>
		 NULL;
		end case;
  
end process;

end Behavioral;

