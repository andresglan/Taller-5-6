Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MUX4_1 is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
			  C : in  STD_LOGIC_VECTOR (15 downto 0);
			  DD : in  STD_LOGIC_VECTOR (15 downto 0);
           S : in  STD_LOGIC_VECTOR(1 downto 0);
           D : out  STD_LOGIC_VECTOR (15 downto 0));
end MUX4_1;

architecture Behavioral of MUX4_1 is

begin

process (A,B,C,DD,S)
  begin
    if S = "00" then
      D<= A;
    elsif S="01" then
		D<= B;
    elsif S="10" then
		D<= C;
    else
		D<= DD;
    end if;
end process;

end Behavioral;

