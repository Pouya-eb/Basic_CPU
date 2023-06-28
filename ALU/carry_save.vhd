
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity carry_save is
    Port ( a,b : in  STD_LOGIC_VECTOR (5 downto 0);
           p : out  STD_LOGIC_VECTOR (11 downto 0));
end carry_save;

architecture Behavioral of carry_save is

component ma is
    Port ( x,y,si,ci : in  STD_LOGIC;
           so,co : out  STD_LOGIC);
end component;

signal sum : STD_LOGIC_VECTOR (30 downto 0);
signal carry : STD_LOGIC_VECTOR (41 downto 0);

begin

-------------- sec 1 ---------------

ma1 : ma port map (x => a(0), y => b(0), si => '0', ci => '0', so => p(0), co => carry(0));

-------------- sec 2 ---------------

ma2 : ma port map (x => a(1), y => b(0), si => '0', ci => '0', so => sum(1), co => carry(1));
ma3 : ma port map (x => a(0), y => b(1), si => sum(1), ci => carry(0), so => p(1), co => carry(2));

-------------- sec 3 ---------------

ma4 : ma port map (x => a(2), y => b(0), si => '0', ci => '0', so => sum(2), co => carry(3));
ma5 : ma port map (x => a(1), y => b(1), si => sum(2), ci => carry(1), so => sum(3), co => carry(4));
ma6 : ma port map (x => a(0), y => b(2), si => sum(3), ci => carry(2), so => p(2), co => carry(5));

-------------- sec 4 ---------------   

ma7 : ma port map (x => a(3), y => b(0), si => '0', ci => '0', so => sum(4), co => carry(6));
ma8 : ma port map (x => a(2), y => b(1), si => sum(4), ci => carry(3), so => sum(5), co => carry(7));
ma9 : ma port map (x => a(1), y => b(2), si => sum(5), ci => carry(4), so => sum(6), co => carry(8));
ma10 : ma port map (x => a(0), y => b(3), si => sum(6), ci => carry(5), so => p(3), co => carry(9));

-------------- sec 5 ---------------   

ma11 : ma port map (x => a(4), y => b(0), si => '0', ci => '0', so => sum(7), co => carry(10));
ma12 : ma port map (x => a(3), y => b(1), si => sum(7), ci => carry(6), so => sum(8), co => carry(11));
ma13 : ma port map (x => a(2), y => b(2), si => sum(8), ci => carry(7), so => sum(9), co => carry(12));
ma14 : ma port map (x => a(1), y => b(3), si => sum(9), ci => carry(8), so => sum(10), co => carry(13));
ma15 : ma port map (x => a(0), y => b(4), si => sum(10), ci => carry(9), so => p(4), co => carry(14));

-------------- sec 6 ---------------   

ma16 : ma port map (x => a(5), y => b(0), si => '0', ci => '0', so => sum(11), co => carry(15));
ma17 : ma port map (x => a(4), y => b(1), si => sum(11), ci => carry(10), so => sum(12), co => carry(16));
ma18 : ma port map (x => a(3), y => b(2), si => sum(12), ci => carry(11), so => sum(13), co => carry(17));
ma19 : ma port map (x => a(2), y => b(3), si => sum(13), ci => carry(12), so => sum(14), co => carry(18));
ma20 : ma port map (x => a(1), y => b(4), si => sum(14), ci => carry(13), so => sum(15), co => carry(19));
ma21 : ma port map (x => a(0), y => b(5), si => sum(15), ci => carry(14), so => p(5), co => carry(20));

-------------- sec 7 ---------------   

ma22 : ma port map (x => a(5), y => b(1), si => '0', ci => carry(15), so => sum(16), co => carry(21));
ma23 : ma port map (x => a(4), y => b(2), si => sum(16), ci => carry(16), so => sum(17), co => carry(22));
ma24 : ma port map (x => a(3), y => b(3), si => sum(17), ci => carry(17), so => sum(18), co => carry(23));
ma25 : ma port map (x => a(2), y => b(4), si => sum(18), ci => carry(18), so => sum(19), co => carry(24));
ma26 : ma port map (x => a(1), y => b(5), si => sum(19), ci => carry(19), so => sum(20), co => carry(25));
ma27 : ma port map (x => '0', y => '1', si => sum(20), ci => carry(20), so => p(6), co => carry(26));

-------------- sec 8 ---------------

ma28 : ma port map (x => a(5), y => b(2), si => '0', ci => carry(21), so => sum(21), co => carry(27));
ma29 : ma port map (x => a(4), y => b(3), si => sum(21), ci => carry(22), so => sum(22), co => carry(28));
ma30 : ma port map (x => a(3), y => b(4), si => sum(22), ci => carry(23), so => sum(23), co => carry(29));
ma31 : ma port map (x => a(2), y => b(5), si => sum(23), ci => carry(24), so => sum(24), co => carry(30));
ma32 : ma port map (x => carry(26), y => '1', si => sum(24), ci => carry(25), so => p(7), co => carry(31));

-------------- sec 9 ---------------   

ma33 : ma port map (x => a(5), y => b(3), si => '0', ci => carry(27), so => sum(25), co => carry(32));
ma34 : ma port map (x => a(4), y => b(4), si => sum(25), ci => carry(28), so => sum(26), co => carry(33));
ma35 : ma port map (x => a(3), y => b(5), si => sum(26), ci => carry(29), so => sum(27), co => carry(34));
ma36 : ma port map (x => carry(31), y => '1', si => sum(27), ci => carry(30), so => p(8), co => carry(35));

-------------- sec 10 ---------------   

ma37 : ma port map (x => a(5), y => b(4), si => '0', ci => carry(32), so => sum(28), co => carry(36));
ma38 : ma port map (x => a(4), y => b(5), si => sum(28), ci => carry(33), so => sum(29), co => carry(37));
ma39 : ma port map (x => carry(35), y => '1', si => sum(29), ci => carry(34), so => p(9), co => carry(38));

-------------- sec 11 ---------------   

ma40 : ma port map (x => a(5), y => b(5), si => '0', ci => carry(36), so => sum(30), co => carry(39));
ma41 : ma port map (x => carry(38), y => '1', si => sum(30), ci => carry(37), so => p(10), co => carry(40));

-------------- sec 12 ---------------   

ma42 : ma port map (x => carry(40), y => '1', si => '0', ci => carry(39), so => p(11), co => carry(41));

 

end Behavioral;

