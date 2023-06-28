
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ma is
    Port ( x,y,si,ci : in  STD_LOGIC;
           so,co : out  STD_LOGIC);
end ma;

architecture Behavioral of ma is

begin
	
	
	so <= (si xor (x and y) xor ci);
	co <= ((si and (x and y)) or ( ci and ( si xor (x and y))));



end Behavioral;

