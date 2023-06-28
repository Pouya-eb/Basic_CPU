library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( A : in  STD_LOGIC_VECTOR (16 downto 1);
           q : out  STD_LOGIC_VECTOR (8 downto 1));
end main;

architecture Behavioral of main is

component BlockX is
    Port ( a : in  STD_LOGIC_VECTOR (4 downto 0);
           R : out  STD_LOGIC_VECTOR (4 downto 0);
           DI1,PI1,PI2 : in  STD_LOGIC;
           DO1,DO2,CO1,CO2 : out  STD_LOGIC);
end component;

component BlockY is
    Port ( a11,a12,a22,DI1,DI2,PI1,PI2,CI1,CI2 : in  STD_LOGIC;
           S11,S21,S22,DO1,DO2,Pout1,Pout2,CO1,CO2 : out  STD_LOGIC);
end component;

signal AA : STD_LOGIC_VECTOR (16 downto 1);
signal d : STD_LOGIC_VECTOR (70 downto 1);
signal qq : STD_LOGIC_VECTOR(8 downto 1);

begin

AA(1) <= A(16);
AA(2) <= A(15);
AA(3) <= A(14);
AA(4) <= A(13);
AA(5) <= A(12);
AA(6) <= A(11);
AA(7) <= A(10);
AA(8) <= A(9);
AA(9) <= A(8);
AA(10) <= A(7);
AA(11) <= A(6);
AA(12) <= A(5);
AA(13) <= A(4);
AA(14) <= A(3);
AA(15) <= A(2);
AA(16) <= A(1);

q(8)<= qq(1);
q(7)<= qq(2);
q(6)<= qq(3);
q(5)<= qq(4);
q(4)<= qq(5);
q(3)<= qq(6);
q(2)<= qq(7);
q(1)<= qq(8);

-------------- part 1 --------------

X1 : BlockX port map (DI1 => '0', a(0) => '1', a(1) => AA(1), a(2) => AA(2), a(3) => AA(3), a(4) => AA(4),
							 PI1 => '1', CO1 => qq(1), PI2 => qq(1), CO2 => qq(2),
							 DO1 => d(2), DO2 => d(4), R(0) => d(1), R(1) => d(3), R(2) => d(5), R(3) => d(6), R(4) => d(7));
							 							 
-------------- part 2 --------------
							 
Y1 : BlockY port map (DI1 => d(2), a11 => d(5), DI2 => d(4), a12 => d(6),
							 PI1 => qq(2), CO1 => qq(3), S11 => d(8), PI2 => qq(3), CO2 => qq(4),
							 DO1 => d(9), S21 => d(10), DO2 => d(11), S22 => d(12),
							 Pout1 => d(13), CI1 => d(14), a22 => d(15), Pout2 => d(16), CI2 => d(17));
							 
X2 : BlockX port map (DI1 => d(13), a(0) => d(7), a(1) => AA(5), a(2) => AA(6), a(3) => AA(7), a(4) => AA(8),
							 PI1 => d(13), CO1 => d(14), PI2 => d(16), CO2 => d(17),
							 DO1 => d(18), DO2 => d(20), R(0) => d(15), R(1) => d(19), R(2) => d(21), R(3) => d(22), R(4) => d(23));							 
							 		
-------------- part 3 --------------
							 
Y2 : BlockY port map (DI1 => d(9), a11 => d(12), DI2 => d(11), a12 => d(19),
							 PI1 => qq(4), CO1 => qq(5), S11 => d(24), PI2 => qq(5), CO2 => qq(6),
							 DO1 => d(25), S21 => d(26), DO2 => d(27), S22 => d(28),
							 Pout1 => d(29), CI1 => d(30), a22 => d(31), Pout2 => d(32), CI2 => d(33));
							 
Y3 : BlockY port map (DI1 => d(18), a11 => d(21), DI2 => d(20), a12 => d(22),
							 PI1 => d(29), CO1 => d(30),S11 => d(31), PI2 => d(32), CO2 => d(33),
							 DO1 => d(34), S21 => d(35), DO2 => d(36), S22 => d(37),
							 Pout1 => d(38), CI1 => d(39), a22 => d(40), Pout2 => d(41), CI2 => d(42));
							 
X3 : BlockX port map (DI1 => d(38), a(0) => d(23), a(1) => AA(9), a(2) => AA(10), a(3) => AA(11), a(4) => AA(12),
							 PI1 => d(38), CO1 => d(39), PI2 => d(41), CO2 => d(42),
							 DO1 => d(43), DO2 => d(45), R(0) => d(40), R(1) => d(44), R(2) => d(46), R(3) => d(47), R(4) => d(48));							 
							 	
-------------- part 4 --------------
							 
Y4 : BlockY port map (DI1 => d(25), a11 => d(28), DI2 => d(27), a12 => d(35),
							 PI1 => qq(6), CO1 => qq(7), S11 => d(49), PI2 => qq(7), CO2 => qq(8),
							 Pout1 => d(50), CI1 => d(51), a22 => d(52), Pout2 => d(53), CI2 => d(54));
							 
Y5 : BlockY port map (DI1 => d(34), a11 => d(37), DI2 => d(36), a12 => d(44),
							 PI1 => d(50), CO1 => d(51), S11 => d(52), PI2 => d(53), CO2 => d(54),
							 Pout1 => d(55), CI1 => d(56), a22 => d(57), Pout2 => d(58), CI2 => d(59));
							 
Y6 : BlockY port map (DI1 => d(43), a11 => d(46), DI2 => d(45), a12 => d(47),
							 PI1 => d(55), CO1 => d(56), S11 => d(57), PI2 => d(58), CO2 => d(59),
							 Pout1 => d(60), CI1 => d(61), a22 => d(62), Pout2 => d(63), CI2 => d(64));						 
							 
X4 : BlockX port map (DI1 => d(60), a(0) => d(48), a(1) => AA(13), a(2) => AA(14), a(3) => AA(15), a(4) => AA(16),
							 PI1 => d(60), CO1 => d(61), PI2 => d(63), CO2 => d(64),
							 DO1 => d(65), DO2 => d(67), R(0) => d(62), R(1) => d(66), R(2) => d(68), R(3) => d(69), R(4) => d(70));		
		
end Behavioral;

