library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ROM is
    Port ( 
				Address : in   STD_LOGIC_VECTOR (5 downto 0);
				Data    : out  STD_LOGIC_VECTOR (15 downto 0)
				);
end ROM;

architecture Behavioral of ROM is

	type rom_type is array(0 to 63) of STD_LOGIC_VECTOR(15 downto 0);

	constant program : rom_type := (
											  -- Commadnd	   OPCODA   Add Finish
											  
											  -- AND    		000001	YES OK
											  -- STORE  		000010	YES OK
											  -- LOAD   		000011	YES OK
											  -- ADD    		000100	YES OK
											  -- Increment AC 000101		 OK
											  -- CLA          000110		 OK
											  -- CLE				000111		 OK
											  -- CIL				001000		 OK
											  -- CIR 			001001		 OK
											  -- SPA				001010		 OK
											  -- SNA				001011		 OK
											  -- SZE				001100		 OK
											  -- SZA				001101		 OK
											  -- Linear Left	001110		 OK
											  -- Linear Right 001111		 OK
											  -- Multiply     010000	YES OK
											  -- SQRT  			100000	YES OK
											  
											  "0000110000000000",
											  "0100000000000001",
											  "0010010000000000",
												
											  


											  others => (others => '0')
											  );
	
begin

	Data <= program(to_integer(unsigned(Address)));

end Behavioral;

