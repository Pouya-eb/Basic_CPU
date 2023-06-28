
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
    Port ( in1, in2, cin : in  STD_LOGIC;
           S, cout : out  STD_LOGIC);
end FA;

architecture Behavioral of FA is

component HA is
port(			a : in STD_LOGIC;
				b : in STD_LOGIC;
				s : out STD_LOGIC;
				c : out STD_LOGIC);
end component;
				
signal s0, s1, s2 : std_logic;

begin
	
	half_adder1 : HA port map (a => in1, b => in2, s => s0, c => s1);
	half_adder2 : HA port map (a => s0, b => cin, s => S, c => s2);

	cout <= s1 or s2;
end Behavioral;

