--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:53:46 06/13/2023
-- Design Name:   
-- Module Name:   C:/Modified/ALU/ALU_tb.vhd
-- Project Name:  ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         Opcode : IN  std_logic_vector(5 downto 0);
         DataRegister : IN  std_logic_vector(15 downto 0);
         AC : IN  std_logic_vector(15 downto 0);
         E : IN  std_logic;
         AC_Out : OUT  std_logic_vector(15 downto 0);
         E_Out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Opcode : std_logic_vector(5 downto 0) := (others => '0');
   signal DataRegister : std_logic_vector(15 downto 0) := (others => '0');
   signal AC : std_logic_vector(15 downto 0) := (others => '0');
   signal E : std_logic := '0';

 	--Outputs
   signal AC_Out : std_logic_vector(15 downto 0);
   signal E_Out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          Opcode => Opcode,
          DataRegister => DataRegister,
          AC => AC,
          E => E,
          AC_Out => AC_Out,
          E_Out => E_Out
        );

   -- Clock process definitions


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		
		-- AND
		Opcode <= "000001";
		DataRegister <= "0000000000000001";
		AC <= "0000000000000001";
		E <= '0';
		wait for 10 ns;	
		-- AND
		Opcode <= "000001";
		DataRegister <= "0000000000000011";
		AC <= "0000000000000011";
		E <= '0';
      wait for 10 ns;	
		-- ADD
		Opcode <= "000100";
		DataRegister <= "0000000000000001";
		AC <= "0000000000000100";
		E <= '0';
      wait for 10 ns;	
		-- ADD
		Opcode <= "000100";
		DataRegister <= "1111111111111111";
		AC <= "0000000000000100";
		E <= '0';
      wait for 10 ns;		
		-- Increament
		Opcode <= "000101";
		DataRegister <= "0000000000000000";
		AC <= "0000000000000000";
		E <= '0';
      wait for 10 ns;
		-- CLEAR AC
		Opcode <= "000110";
		DataRegister <= "0000000000000000";
		AC <= "0000000001110000";
		E <= '0';
      wait for 10 ns;
		--CLEAR E
		Opcode <= "000111";
		DataRegister <= "0000000000000000";
		AC <= "0000000001110000";
		E <= '1';
      wait for 10 ns;	
		--CIRCULAR LEFT SHIFT
		Opcode <= "001000";
		DataRegister <= "0000000000000000";
		AC <= "1111111111111111";
		E <= '0';
      wait for 10 ns;	
		--CIRCULAR RIGHT SHIFT
		Opcode <= "001001";
		DataRegister <= "0000000000000000";
		AC <= "1111111111111111";
		E <= '0';
      wait for 10 ns;	
		--Linear Left Shift
		Opcode <= "001110";
		DataRegister <= "0000000000000000";
		AC <= "0111111111111111";
		E <= '1';
		wait for 10 ns;
	   --Linear Right Shift
		Opcode <= "001111";
		DataRegister <= "0000000000000000";
		AC <= "0111111111111110";
		E <= '1';
		wait for 10 ns;
	   --Multiply
		Opcode <= "010000";
		DataRegister <= "0000000000000010";
		AC <= "0000000000000001";
		E <= '1';
		wait for 10 ns;
	   --Multiply
		Opcode <= "010000";
		DataRegister <= "0000000000000010";
		AC <= "0000000000000100";
		E <= '1';
		wait for 10 ns;
	   --SQRT
		Opcode <= "100000";
		DataRegister <= "0000000000000000";
		AC <= "0000000000000100";
		E <= '1';
		wait for 10 ns;		
	   --SQRT
		Opcode <= "100000";
		DataRegister <= "0000000000000000";
		AC <= "0000000000010000";
		E <= '1';
		wait for 10 ns;				
		
      -- insert stimulus here 

      wait;
   end process;

END;
