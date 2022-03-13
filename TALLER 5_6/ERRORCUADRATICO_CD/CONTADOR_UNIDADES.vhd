library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CONTADOR_UNIDADES is
    Port ( S0: in STD_LOGIC_VECTOR(1 downto 0);
			  CLK: in  STD_LOGIC;
			  RST: in  STD_LOGIC;
			  I: inout STD_LOGIC_VECTOR(15 downto 0));
end CONTADOR_UNIDADES;

architecture behaviour of CONTADOR_UNIDADES is
 
begin

process(I,CLK,RST,S0)
begin
	if RST= '1' then
	elsif clk= '1' and clk'event then
		if S0="00" then
		I<="0000000000000000";
		elsif S0="01" then
		I<=I+1;
		else
		end if;
	end if;
end process;

end behaviour;
