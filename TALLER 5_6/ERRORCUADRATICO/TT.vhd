--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:09:32 03/04/2022
-- Design Name:   
-- Module Name:   D:/MICROS 2/TALLER 5_6/ERRORCUADRATICO/TT.vhd
-- Project Name:  ERRORCUADRATICO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GENERAL
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
 
ENTITY TT IS
END TT;
 
ARCHITECTURE behavior OF TT IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GENERAL
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         INICIO : IN  std_logic;
         UNIDADES : OUT  std_logic_vector(15 downto 0);
         DECIMALL : OUT  std_logic_vector(15 downto 0);
         FINAL : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal INICIO : std_logic := '0';

 	--Outputs
   signal UNIDADES : std_logic_vector(15 downto 0);
   signal DECIMALL : std_logic_vector(15 downto 0);
   signal FINAL : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GENERAL PORT MAP (
          CLK => CLK,
          RST => RST,
          INICIO => INICIO,
          UNIDADES => UNIDADES,
          DECIMALL => DECIMALL,
          FINAL => FINAL
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
