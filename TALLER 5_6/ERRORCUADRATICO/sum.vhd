----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:24:37 03/02/2022 
-- Design Name: 
-- Module Name:    sum - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if inSTantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sum is
	port (
		clk,rST : in STD_LOGIC;
		inicio: IN STD_LOGIC;
		YI: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		TI: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		N: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		SUMATORIA: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		final: OUT STD_LOGIC);
end sum;

architecture Behavioral of sum is

type eSTados_asm is (ST0,ST1,ST2,ST3,ST4,ST5);
signal ST : eSTados_asm;
signal RESTA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal DATOY: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal DATOT: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal NUMDATA: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal CUADRADO: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal SUM: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal I: STD_LOGIC_VECTOR(7 DOWNTO 0);

begin
process (clk,rST,inicio)

	begin

	if rST= '1'then
		ST<=ST0;
	elsif clk'event and clk='1' then

		case ST is
		
			when ST0 =>
				DATOY<=YI;
				DATOT<=TI;
					if inicio='0' then
						ST<=ST0;
					else
						ST<=ST1;
					end if;
			when ST1 =>
				RESTA<=(others => '0');
				CUADRADO<=(others =>'0');
				SUM<=(others =>'0');
				NUMDATA<=N;
				I<=(others =>'0');
				ST<=ST2;
			when ST2=>
				RESTA<=DATOY-DATOT;
				ST<=ST3;
			when ST3=>
				CUADRADO<=RESTA*RESTA;
				ST<=ST4;
			when ST4=>
				SUM<=SUM+CUADRADO;
				I<=I+1;
				if NUMDATA>I then
					ST<=ST2;
				else
					ST<=ST5;
				end if;
			when ST5=>
				SUMATORIA<=SUM;
			when others=>
					ST<=ST0;
		end case;
	end if;
end process;
final<='1' when ST=ST5 else '0' ;
end Behavioral;

