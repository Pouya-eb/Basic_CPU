--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:49:03 06/13/2023
-- Design Name:   
-- Module Name:   C:/Modified/RAM/RAM_tb.vhd
-- Project Name:  RAM
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RAM
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
 
ENTITY RAM_tb IS
END RAM_tb;
 
ARCHITECTURE behavior OF RAM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM
    PORT(
         CLK : IN  std_logic;
         We : IN  std_logic;
         En : IN  std_logic;
         Address : IN  std_logic_vector(5 downto 0);
         DataIn : IN  std_logic_vector(15 downto 0);
         DataOut : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal We : std_logic := '0';
   signal En : std_logic := '0';
   signal Address : std_logic_vector(5 downto 0) := (others => '0');
   signal DataIn : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal DataOut : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM PORT MAP (
          CLK => CLK,
          We => We,
          En => En,
          Address => Address,
          DataIn => DataIn,
          DataOut => DataOut
        );

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
		-- Write Add(0)
		We <= '1';
		En <= '1';
		Address <= "000000";
		DataIn  <= "0000000000000001";
		-- Write Add(3)
		wait for 100 ns;	
      wait for CLK_period*10;
		We <= '1';
		En <= '1';
		Address <= "000011";
		DataIn  <= "1111111111111111";
		--Read Add(0)
		wait for 100 ns;	
      wait for CLK_period*10;
		We <= '0';
		En <= '1';
		Address <= "000000";
		--Read Add(3)
		wait for 100 ns;	
      wait for CLK_period*10;
		We <= '0';
		En <= '1';
		Address <= "000011";
		
		
		

      wait;
   end process;

END;
