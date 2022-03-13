
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MUX2_1 is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           S : in  STD_LOGIC;
           D : out  STD_LOGIC_VECTOR (7 downto 0));
end MUX2_1;

architecture Behavioral of MUX2_1 is

begin

process (A,B,S)
  begin
    if S = '1' then
      D<= A;
    else
		D<= B;
    end if;
end process;
end Behavioral;


