library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HA is
    Port ( a, b : in  STD_LOGIC;
           s, c : out  STD_LOGIC);
end HA;

architecture Behavioral of HA is
	begin
	c <= (a and b);
	s <= (a xor b);


end Behavioral;


