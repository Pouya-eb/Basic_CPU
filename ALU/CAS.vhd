library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CAS is
    Port ( D,X,Cin,PI : in  STD_LOGIC;
           r,Cout,PO : out  STD_LOGIC);

end CAS;

architecture Behavioral of CAS is

component FA is
    Port ( in1, in2, cin : in  STD_LOGIC;
           S, cout : out  STD_LOGIC);
end component;

signal s : std_logic;

begin

s <= PI xor D;
full_adder : FA port map (in1 => X, in2 => s, cin => Cin, S => r, cout => Cout);
PO <= PI;


end Behavioral;

