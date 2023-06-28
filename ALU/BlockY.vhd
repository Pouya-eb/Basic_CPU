
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BlockY is
    Port ( a11,a12,a22,DI1,DI2,PI1,PI2,CI1,CI2 : in  STD_LOGIC;
           S11,S21,S22,DO1,DO2,Pout1,Pout2,CO1,CO2 : out  STD_LOGIC);
end BlockY;

architecture Behavioral of BlockY is

component CAS is
    Port ( D,X,Cin,PI : in  STD_LOGIC;
           r,Cout,PO : out  STD_LOGIC);
           
end component;

signal d : STD_LOGIC_VECTOR (3 downto 1);

begin

 DO1 <= DI1;
 DO2 <= DI2;
 Pout1 <= PI1;
 Pout2 <= PI2;
 
CAS1 : CAS port map (PI => PI1, D => DI1, X => a11, Cin => d(2), r => S11, Cout => CO1);
CAS2 : CAS port map (PI => PI1, D => DI2, X => a12, Cin => CI1, r => d(1), Cout => d(2));
CAS3 : CAS port map (PI => PI2, D => DI1, X => d(1), Cin => d(3), r => S21, Cout => CO2);
CAS4 : CAS port map (PI => PI2, D => DI2, X => a22, Cin => CI2, r => S22, Cout => d(3));

end Behavioral;

