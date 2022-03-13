library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TH is
    Port ( en : in  STD_LOGIC;
           sig : in  STD_LOGIC_VECTOR (15 downto 0);
           salida : out  STD_LOGIC_VECTOR (15 downto 0));
end TH;

architecture Behavioral of TH is

begin

salida <= sig when (en= '1') else (others=> 'Z');

end Behavioral;


