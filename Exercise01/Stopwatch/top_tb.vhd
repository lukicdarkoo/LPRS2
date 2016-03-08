--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:53:47 03/03/2016
-- Design Name:   
-- Module Name:   C:/materija/RA117-2013/Vjezba1/top_tb.vhd
-- Project Name:  Vjezba1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
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
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         FPGA_CLK : IN  std_logic;
         FPGA_RESET : IN  std_logic;
         UI_SW0 : IN  std_logic;
         UI_SW1 : IN  std_logic;
         UI_SW2 : IN  std_logic;
         UI_SW3 : IN  std_logic;
         UI_LED0 : OUT  std_logic;
         UI_LED1 : OUT  std_logic;
         UI_LED2 : OUT  std_logic;
         UI_LED3 : OUT  std_logic;
         UI_LED4 : OUT  std_logic;
         UI_LED5 : OUT  std_logic;
         UI_LED6 : OUT  std_logic;
         UI_LED7 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal FPGA_CLK : std_logic := '0';
   signal FPGA_RESET : std_logic := '0';
   signal UI_SW0 : std_logic := '0';
   signal UI_SW1 : std_logic := '0';
   signal UI_SW2 : std_logic := '0';
   signal UI_SW3 : std_logic := '0';

 	--Outputs
   signal UI_LED0 : std_logic;
   signal UI_LED1 : std_logic;
   signal UI_LED2 : std_logic;
   signal UI_LED3 : std_logic;
   signal UI_LED4 : std_logic;
   signal UI_LED5 : std_logic;
   signal UI_LED6 : std_logic;
   signal UI_LED7 : std_logic;

   -- Clock period definitions
   constant FPGA_CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          FPGA_CLK => FPGA_CLK,
          FPGA_RESET => FPGA_RESET,
          UI_SW0 => UI_SW0,
          UI_SW1 => UI_SW1,
          UI_SW2 => UI_SW2,
          UI_SW3 => UI_SW3,
          UI_LED0 => UI_LED0,
          UI_LED1 => UI_LED1,
          UI_LED2 => UI_LED2,
          UI_LED3 => UI_LED3,
          UI_LED4 => UI_LED4,
          UI_LED5 => UI_LED5,
          UI_LED6 => UI_LED6,
          UI_LED7 => UI_LED7
        );

   -- Clock process definitions
   FPGA_CLK_process :process
   begin
		FPGA_CLK <= '0';
		wait for FPGA_CLK_period/2;
		FPGA_CLK <= '1';
		wait for FPGA_CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
		FPGA_RESET <= '0';
		
      wait for 100 ns;	
		
		FPGA_RESET <= '1';
		
		wait for 100 ns;	
		
		UI_SW0 <= '1';
		UI_SW1 <= '1';
		UI_SW2 <= '0';
		UI_SW3 <= '1';
		

      wait for FPGA_CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
