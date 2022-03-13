library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CONTADOR_I is
    Port ( S0: in STD_LOGIC_VECTOR(1 downto 0);
			  CLK: in  STD_LOGIC;
			  RST: in  STD_LOGIC;
			  NUMDATA: in STD_LOGIC_VECTOR(7 downto 0);
           alpha : out  STD_LOGIC;
			  I: inout STD_LOGIC_VECTOR(7 downto 0));
end CONTADOR_I;

architecture behaviour of CONTADOR_I is
 
begin

process(I,CLK,RST)
begin
	if RST= '1' then
	elsif clk= '1' and clk'event then
		if S0="00" then
		I<="00000000";
		elsif S0="01" then
		I<=I+1;
		else
		end if;
	end if;
end process;

process(I,NUMDATA)
begin
	if NUMDATA>I then
	alpha<='0';
	else
	alpha<='1';
	end if;
end process;
end behaviour;