library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BlockX is
    Port ( a : in  STD_LOGIC_VECTOR (4 downto 0);
           R : out  STD_LOGIC_VECTOR (4 downto 0);
           DI1,PI1,PI2 : in  STD_LOGIC;
           DO1,DO2,CO1,CO2 : out  STD_LOGIC);
end BlockX;

architecture Behavioral of BlockX is

component CAS is
    Port ( D,X,Cin,PI : in  STD_LOGIC;
           r,Cout,PO : out  STD_LOGIC);
           
end component;

signal d : STD_LOGIC_VECTOR (9 downto 1);

begin

d(1) <= not PI1;
d(6) <= not PI2;

CAS1 : CAS port map (PI => PI1, D => PI1, X => a(0), Cin => d(4), r => R(0), Cout => CO1);
CAS2 : CAS port map (PI => PI1, D => d(1), X => a(1), Cin => d(2), r => d(5), Cout => d(4));
CAS3 : CAS port map (PI => PI1, D => '1', X => a(2), Cin => PI1, r => d(3), Cout => d(2));
CAS4 : CAS port map (PI => PI2, D => DI1, X => d(5), Cin => d(9), r => R(1), Cout => CO2);
CAS5 : CAS port map (PI => PI2, D => PI2, X => d(3), Cin => d(8), r => R(2), Cout => d(9));
CAS6 : CAS port map (PI => PI2, D => d(6), X => a(3), Cin => d(7), r => R(3), Cout => d(8));
CAS7 : CAS port map (PI => PI2, D => '1', X => a(4), Cin => PI2, r => R(4), Cout => d(7));

DO1 <= DI1;
DO2 <=PI2;
 
end Behavioral;

