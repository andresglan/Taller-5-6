--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:46:07 03/08/2022
-- Design Name:   
-- Module Name:   D:/MICROS 2/TALLER 5_6/ERRORCUADRATICO_CD/FINALFINALNOVAMAS.vhd
-- Project Name:  ERRORCUADRATICO_CD
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ERRORC
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY FINALFINALNOVAMAS IS
END FINALFINALNOVAMAS;
 
ARCHITECTURE behavior OF FINALFINALNOVAMAS IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ERRORC
    PORT(
         INICIO : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         FINAL : OUT  std_logic;
         UNIDADES : OUT  std_logic_vector(15 downto 0);
         DECIMALES : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal INICIO : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal FINAL : std_logic;
   signal UNIDADES : std_logic_vector(15 downto 0);
   signal DECIMALES : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ERRORC PORT MAP (
          INICIO => INICIO,
          CLK => CLK,
          RST => RST,
          FINAL => FINAL,
          UNIDADES => UNIDADES,
          DECIMALES => DECIMALES
        );
	INICIO<= '1' after 0ns;
	
   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
