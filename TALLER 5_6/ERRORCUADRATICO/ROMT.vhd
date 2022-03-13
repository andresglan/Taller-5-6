library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROMT is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           SalNums : out  STD_LOGIC_VECTOR (7 downto 0));
end ROMT;

architecture Behavioral of ROMT is

begin
 
 
process (I)
 
begin

case I is

when"00000000"=>SalNums<="00000111";
when"00000001"=>SalNums<="00000001";
when"00000010"=>SalNums<="00000010";
when"00000011"=>SalNums<="00000011";
when"00000100"=>SalNums<="00000100";
when"00000101"=>SalNums<="00000101";
when"00000110"=>SalNums<="00000110";
when"00000111"=>SalNums<="00000111";
when"00001000"=>SalNums<="00001000";
when"00001001"=>SalNums<="00001001";
when"00001010"=>SalNums<="00010000";
when"00001011"=>SalNums<="00010001";
when"00001100"=>SalNums<="00010010";
when"00001101"=>SalNums<="00010011";
when"00001110"=>SalNums<="00010100";
when"00001111"=>SalNums<="00010101";

when others => SalNums <= (OTHERS => '0');

end case;

end process; 

end Behavioral;