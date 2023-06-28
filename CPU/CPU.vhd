library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity CPU is
    Port ( 
				CLK : in  STD_LOGIC
			);
end CPU;

architecture Behavioral of CPU is
	
	--------------------------------------------
	type state_type is (Fetch, Decode, Addressing, Execute, NOP);
	Signal STATE : state_type := Fetch;
	--------------------------------------------
	COMPONENT ROM
	PORT(
		Address : IN std_logic_vector(5 downto 0);          
		Data : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	Signal IR     : STD_LOGIC_VECTOR(15 downto 0);
	Signal PC     : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
	--------------------------------------------
	COMPONENT RAM
	PORT(
		We 		: IN std_logic;
		En 		: IN std_logic;
		Address  : IN std_logic_vector(5 downto 0);
		DataIn 	: IN std_logic_vector(15 downto 0);          
		DataOut  : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	Signal RamAdd  : STD_LOGIC_VECTOR(5 downto 0);
	Signal RamData : STD_LOGIC_VECTOR(15 downto 0);
	Signal RamEN   : STD_LOGIC;
	Signal RamWe   : STD_LOGIC;
	Signal RamIn   : STD_LOGIC_VECTOR(15 downto 0);
	--------------------------------------------
	Signal Opcode : STD_LOGIC_VECTOR(5 downto 0);
	Signal AC     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	Signal E		  : STD_LOGIC := '0';
	Signal DR	  : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	--------------------------------------------
	COMPONENT ALU
	PORT(
		Opcode 		 : IN std_logic_vector(5 downto 0);
		DataRegister : IN std_logic_vector(15 downto 0);
		AC 			 : IN std_logic_vector(15 downto 0);
		E 				 : IN std_logic;          
		AC_Out 		 : OUT std_logic_vector(15 downto 0);
		E_Out 		 : OUT std_logic
		);
	END COMPONENT;
	Signal ALU_OPCODE : STD_LOGIC_VECTOR(5 downto 0);
	Signal ALU_DR     : STD_LOGIC_VECTOR(15 downto 0);
	Signal ALU_AC		: STD_LOGIC_VECTOR(15 downto 0);
	Signal ALU_E      : STD_LOGIC;
	Signal ALU_Out 	: STD_LOGIC_VECTOR(15 downto 0);
	Signal ALUOut 	 	: STD_LOGIC;



begin

	Inst_ROM: ROM PORT MAP(
		Address => PC,
		Data => IR
	);
	
	Inst_RAM: RAM PORT MAP(
		We => RamWe,
		En => RamEn,
		Address => RamAdd,
		DataIn => RamIn,
		DataOut => RamData
	);
	
	Inst_ALU: ALU PORT MAP(
		Opcode => ALU_OPCODE,
		DataRegister => ALU_DR,
		AC => ALU_AC,
		E => ALU_E,
		AC_Out => ALU_Out,
		E_Out => ALUOut
	);

	process(CLK, PC, IR, RamWe, RamEn, RamAdd, RamIn, RamData, ALU_OPCODE, ALU_DR, ALU_AC, ALU_E, ALU_Out, ALUOut, Opcode, AC, E, DR)
		begin
			
			if rising_edge(CLK) then
				case STATE is
					
					when Fetch =>
						Opcode <= IR(15 downto 10);
						STATE  <= Decode;
					
					when Decode =>
						case Opcode is 
						
							when "000001" => 					--AND
								RamEn  <= '1';
								RamWe  <= '0';
								RamAdd <= IR(5 downto 0);
								STATE  <= Addressing;
							
							when "000010" =>					--STORE
								RamEn  <= '1';
								RamWe  <= '1';
								RamAdd <= IR(5 downto 0);
								STATE  <= Execute;
								
							when "000011" => 					--LOAD
								RamEn  <= '1';
								RamWe  <= '0';
								RamAdd <= IR(5 downto 0);
								STATE  <= Addressing;
								
							when "000100" =>					--ADD
								RamEn  <= '1';
								RamWe  <= '0';
								RamAdd <= IR(5 downto 0);
								STATE  <= Addressing;
								
							when "010000" => 				   --MULTIPLY
								RamEn  <= '1';
								RamWe  <= '0';
								RamAdd <=IR(5 downto 0);
								STATE  <= Addressing;
							
							when "100000" =>					--SQRT
								RamEn  <= '1';
								RamWe  <= '0';
								RamAdd <=IR(5 downto 0);
								STATE  <= Addressing;
								
							when others =>						--NO ADDRESS
								STATE <= Execute;

						end case;
						
						
					when Addressing => 
								DR 	     <= RamData;
								ALU_DR     <= RamData;
								STATE      <= Execute;
						
					when Execute =>
						case Opcode is 
							
							-- AND
							when "000001" => 
								ALU_OPCODE <= Opcode;
								PC     <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));
								STATE      <= Fetch;
							
							-- STORE
							when "000010" => 
								RamIn <= AC;
								PC     <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));
								STATE <= Fetch;
							
							-- LOAD
							when "000011" => 
								ALU_AC <= DR;
								AC     <= DR;
								PC     <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));
								STATE  <= Fetch;
							
							-- ADD
							when "000100" =>
								ALU_OPCODE <= Opcode;
								PC     <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));
								STATE      <= NOP;
								
							-- Increment AC
							when "000101" =>
								ALU_AC     <= AC;
								ALU_OPCODE <= Opcode;
								PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));
								STATE      <= NOP;
								
							-- CLA
							when "000110" =>
								ALU_OPCODE <= Opcode;
								PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));
								STATE      <= NOP;
												   
							-- CLE
							when "000111" =>
								ALU_OPCODE <= Opcode;
								PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));
								STATE      <= NOP;
								
							-- CIL
							when "001000" =>
								ALU_OPCODE <= Opcode;
								ALU_AC     <= AC;
								ALU_E      <= E;
								PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));								
								STATE      <= NOP;
							
							-- CIR
							when "001001" =>
								ALU_OPCODE <= Opcode;
								ALU_AC     <= AC;
								ALU_E      <= E;
								PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));								
								STATE      <= NOP;
								
							-- SPA
							when "001010" =>
								if(AC(15) = '0') then
									PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 2));		
								end if;
								STATE   <= Fetch;
								
							-- SNA
							when "001011" =>
								if(AC(15) = '1') then
									PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 2));		
								end if;
								STATE   <= Fetch;	
								
							-- SZE
							when "001100" =>
								if(E = '0') then
									PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 2));		
								end if;
								STATE   <= Fetch;	
								
							-- SZA 
							when "001101" =>
								if(AC = "0000000000000000") then
									PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 2));		
								end if;
								STATE   <= Fetch;							
							
							-- Linear Left Shift
							when "001110" =>
								ALU_OPCODE <= Opcode;
								ALU_AC     <= AC;
								ALU_E      <= E;
								PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));								
								STATE      <= NOP;	

							-- Linear Right Shift
							when "001111" =>
								ALU_OPCODE <= Opcode;
								ALU_AC     <= AC;
								ALU_E      <= E;
								PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));								
								STATE      <= NOP;						
							
							-- Multiply 
							when "010000" =>
								ALU_OPCODE <= Opcode;
								ALU_AC     <= AC;
								PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));								
								STATE      <= NOP;	

							-- SQRT 
							when "100000" =>
								ALU_OPCODE <= Opcode;
								ALU_AC     <= DR;
								PC         <= STD_LOGIC_VECTOR(unsigned(unsigned(PC) + 1));								
								STATE      <= NOP;									
	
							when others => null;
						end case;
					
					when NOP =>
								AC 	 <= ALU_Out;
								ALU_AC <= ALU_Out;
								E      <= ALUOut;
								ALU_E  <= ALUOut;
								STATE  <= Fetch;
					
				end case;
			end if;	
		
		end process;
	
end Behavioral;

