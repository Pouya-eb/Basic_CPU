library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ALU is
    Port (
				Opcode       : in  STD_LOGIC_VECTOR (5 downto 0);
				DataRegister : in  STD_LOGIC_VECTOR (15 downto 0);
				AC 			 : in  STD_LOGIC_VECTOR (15 downto 0);
				E 			  	 : in  STD_LOGIC;
				AC_Out       : out STD_LOGIC_VECTOR (15 downto 0);
				E_Out        : out STD_LOGIC
			);
end ALU;

architecture Behavioral of ALU is

	Signal SUM   : STD_LOGIC_VECTOR(16 downto 0);
	Signal MULTI : STD_LOGIC_VECTOR(11 downto 0);
	Signal SQRT  : STD_LOGIC_VECTOR(8 downto 1);
	
	COMPONENT carry_save
	PORT(
		a : IN std_logic_vector(5 downto 0);
		b : IN std_logic_vector(5 downto 0);          
		p : OUT std_logic_vector(11 downto 0)
		);
	END COMPONENT;
	
	COMPONENT main
	PORT(
		A : IN std_logic_vector(16 downto 1);          
		q : OUT std_logic_vector(8 downto 1)
		);
	END COMPONENT;

	
begin

	Inst_carry_save: carry_save PORT MAP(
		a => AC(5 downto 0),
		b => DataRegister(5 downto 0),
		p => Multi
	);
	
	Inst_main: main PORT MAP(
		A => AC,
		q => SQRT
	);

	process(Opcode, AC, E, DataRegister, SUM, MULTI, SQRT)
		begin
			
			case Opcode is 
				
				when "000001" => AC_Out <= AC and DataRegister; 														--AND
									  E_Out  <= E;
				
			--	when "000010" -> STORE
			
			--	when "000011" -> LOAD
			
				when "000100" => SUM <= STD_LOGIC_VECTOR('0' & unsigned(AC) + unsigned(DataRegister));		--ADD
								     AC_Out <= SUM(15 downto 0);
									  E_Out  <= SUM(16);
									  
				when "000101" => AC_Out <=  STD_LOGIC_VECTOR(unsigned(unsigned(AC) + 1));						--Increment AC --> Could be in main file
								     E_Out  <= E;
				
				when "000110" => AC_Out <= "0000000000000000";															--Clear AC     --> Could be in main file
									  E_Out  <= E;
				
				when "000111" => AC_Out <= AC;																				--Clear E
									  E_Out  <= '0';
									  
				when "001000" => AC_Out <= AC(14 downto 0) & E;															--Circular Left Shift
									  E_Out <= AC(15);
				
				when "001001" => AC_Out <= E & AC(15 downto 1);															--Circular Left Shift
									  E_Out  <= AC(0);
									  
			--	when "001010" -> SPA
				
			-- when "001011" -> SNA

		   -- when "001100" -> SZE
			
			-- when "001101" -> SZA
			
				when "001110" => AC_Out <= AC(14 downto 0) & '0';														--Linear Left Shift
									  E_Out <= AC(15);
				
				when "001111" => AC_Out <= E & AC(15 downto 1);															--Linear Right Shift
									  E_Out  <= '0';
				
				when "010000" => AC_Out <= "0000" & Multi;																--Multiply
									  E_Out  <= E;
									  
				when "100000" => AC_Out <= "00000000" & SQRT;															--SQRT
									  E_Out  <= E;
				
				when others => null;
			
			end case;
	
		end process;
	
	

end Behavioral;

