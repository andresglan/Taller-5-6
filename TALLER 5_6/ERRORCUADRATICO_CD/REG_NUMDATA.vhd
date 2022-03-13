
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity REG_NUMDATA is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           WREG : in  STD_LOGIC;
           B : out  STD_LOGIC_VECTOR (7 downto 0));
end REG_NUMDATA;

architecture Behavioral of REG_NUMDATA is

begin

process(WREG,A)

begin
	if WREG='1' then
		B<=A;
	else	
	end if;
	
end process;

end Behavioral;

