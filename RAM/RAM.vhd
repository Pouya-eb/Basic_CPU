library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity RAM is
    Port ( 
				We 	  : in   STD_LOGIC;
				En 	  : in   STD_LOGIC;
				Address : in   STD_LOGIC_VECTOR (5 downto 0);
				DataIn  : in   STD_LOGIC_VECTOR (15 downto 0);
				DataOut : out  STD_LOGIC_VECTOR (15 downto 0)
				);
end RAM;

architecture Behavioral of RAM is

	type ram_type is array(0 to 63) of STD_LOGIC_VECTOR(15 downto 0);
	Signal RAM : ram_type := (
										"0000000000000010",
										"0000000000000100",
									  others => (others => '0')
									  );

begin

	process(We, En, Address, DataIn, RAM)
		begin 
			
			if En = '1' then
				if We = '1' then 
					RAM(to_integer(unsigned(Address))) <= DataIn;
				else
					DataOut <= RAM(to_integer(unsigned(Address)));
				end if;
			end if;
			
		end process;

end Behavioral;

