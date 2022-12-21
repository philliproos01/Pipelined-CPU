
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity ADDER1 is
-- Adds two signed 64-bit inputs
-- output = in1 + in2
port(
	in0 : in STD_LOGIC_VECTOR(63 downto 0);
	in1 : in STD_LOGIC_VECTOR(63 downto 0);
	output : out STD_LOGIC_VECTOR(63 downto 0)
);
end ADDER1;

architecture structural of ADDER1 is
	component FULL_ADD
	port(
		in0 : in STD_LOGIC;
		in1 : in STD_LOGIC;
		carryin :  in STD_LOGIC;
		carryout : out std_logic;
		output : out STD_LOGIC
		);
	END COMPONENT;
--signal in0 : STD_LOGIC_VECTOR(63 downto 0);
--signal in1 : STD_LOGIC_VECTOR(63 downto 0);
--signal output : STD_LOGIC_VECTOR(63 downto 0);
signal carryin : std_logic;
signal carryout : std_logic;
signal carryx : std_logic;
signal carry0 : std_logic;
signal carry1	: std_logic;
signal carry2	: std_logic;
signal carry3	: std_logic;
signal carry4	: std_logic;
signal carry5	: std_logic;
signal carry6	: std_logic;
signal carry7	: std_logic;
signal carry8	: std_logic;
signal carry9	: std_logic;
signal carry10	: std_logic;
signal carry11	: std_logic;
signal carry12	: std_logic;
signal carry13	: std_logic;
signal carry14	: std_logic;
signal carry15	: std_logic;
signal carry16	: std_logic;
signal carry17	: std_logic;
signal carry18	: std_logic;
signal carry19	: std_logic;
signal carry20	: std_logic;
signal carry21	: std_logic;
signal carry22	: std_logic;
signal carry23	: std_logic;
signal carry24	: std_logic;
signal carry25	: std_logic;
signal carry26	: std_logic;
signal carry27	: std_logic;
signal carry28	: std_logic;
signal carry29	: std_logic;
signal carry30	: std_logic;
signal carry31	: std_logic;
signal carry32	: std_logic;
signal carry33	: std_logic;
signal carry34	: std_logic;
signal carry35	: std_logic;
signal carry36	: std_logic;
signal carry37	: std_logic;
signal carry38	: std_logic;
signal carry39	: std_logic;
signal carry40	: std_logic;
signal carry41	: std_logic;
signal carry42	: std_logic;
signal carry43	: std_logic;
signal carry44	: std_logic;
signal carry45	: std_logic;
signal carry46	: std_logic;
signal carry47	: std_logic;
signal carry48	: std_logic;
signal carry49	: std_logic;
signal carry50	: std_logic;
signal carry51	: std_logic;
signal carry52	: std_logic;
signal carry53	: std_logic;
signal carry54	: std_logic;
signal carry55	: std_logic;
signal carry56	: std_logic;
signal carry57	: std_logic;
signal carry58	: std_logic;
signal carry59	: std_logic;
signal carry60	: std_logic;
signal carry61	: std_logic;
signal carry62	: std_logic;
signal carry63	: std_logic;


begin
uut0: FULL_ADD PORT MAP(output => output(0), in0 => in0(0), carryin => '0', in1 => in1(0), carryout => carry0);
uut1: FULL_ADD PORT MAP(output => output(1), in0 => in0(1), carryin => carry0, in1 => in1(1), carryout => carry1);
uut2: FULL_ADD PORT MAP(output => output(2), in0 => in0(2), carryin => carry1, in1 => in1(2), carryout => carry2);
uut3: FULL_ADD PORT MAP(output => output(3), in0 => in0(3), carryin => carry2, in1 => in1(3), carryout => carry3);
uut4: FULL_ADD PORT MAP(output => output(4), in0 => in0(4), carryin => carry3, in1 => in1(4), carryout => carry4);
uut5: FULL_ADD PORT MAP(output => output(5), in0 => in0(5), carryin => carry4, in1 => in1(5), carryout => carry5);
uut6: FULL_ADD PORT MAP(output => output(6), in0 => in0(6), carryin => carry5, in1 => in1(6), carryout => carry6);
uut7: FULL_ADD PORT MAP(output => output(7), in0 => in0(7), carryin => carry6, in1 => in1(7), carryout => carry7);
uut8: FULL_ADD PORT MAP(output => output(8), in0 => in0(8), carryin => carry7, in1 => in1(8), carryout => carry8);
uut9: FULL_ADD PORT MAP(output => output(9), in0 => in0(9), carryin => carry8, in1 => in1(9), carryout => carry9);
uut10: FULL_ADD PORT MAP(output => output(10), in0 => in0(10), carryin => carry9, in1 => in1(10), carryout => carry10);
uut11: FULL_ADD PORT MAP(output => output(11), in0 => in0(11), carryin => carry10, in1 => in1(11), carryout => carry11);
uut12: FULL_ADD PORT MAP(output => output(12), in0 => in0(12), carryin => carry11, in1 => in1(12), carryout => carry12);
uut13: FULL_ADD PORT MAP(output => output(13), in0 => in0(13), carryin => carry12, in1 => in1(13), carryout => carry13);
uut14: FULL_ADD PORT MAP(output => output(14), in0 => in0(14), carryin => carry13, in1 => in1(14), carryout => carry14);
uut15: FULL_ADD PORT MAP(output => output(15), in0 => in0(15), carryin => carry14, in1 => in1(15), carryout => carry15);
uut16: FULL_ADD PORT MAP(output => output(16), in0 => in0(16), carryin => carry15, in1 => in1(16), carryout => carry16);
uut17: FULL_ADD PORT MAP(output => output(17), in0 => in0(17), carryin => carry16, in1 => in1(17), carryout => carry17);
uut18: FULL_ADD PORT MAP(output => output(18), in0 => in0(18), carryin => carry17, in1 => in1(18), carryout => carry18);
uut19: FULL_ADD PORT MAP(output => output(19), in0 => in0(19), carryin => carry18, in1 => in1(19), carryout => carry19);
uut20: FULL_ADD PORT MAP(output => output(20), in0 => in0(20), carryin => carry19, in1 => in1(20), carryout => carry20);
uut21: FULL_ADD PORT MAP(output => output(21), in0 => in0(21), carryin => carry20, in1 => in1(21), carryout => carry21);
uut22: FULL_ADD PORT MAP(output => output(22), in0 => in0(22), carryin => carry21, in1 => in1(22), carryout => carry22);
uut23: FULL_ADD PORT MAP(output => output(23), in0 => in0(23), carryin => carry22, in1 => in1(23), carryout => carry23);
uut24: FULL_ADD PORT MAP(output => output(24), in0 => in0(24), carryin => carry23, in1 => in1(24), carryout => carry24);
uut25: FULL_ADD PORT MAP(output => output(25), in0 => in0(25), carryin => carry24, in1 => in1(25), carryout => carry25);
uut26: FULL_ADD PORT MAP(output => output(26), in0 => in0(26), carryin => carry25, in1 => in1(26), carryout => carry26);
uut27: FULL_ADD PORT MAP(output => output(27), in0 => in0(27), carryin => carry26, in1 => in1(27), carryout => carry27);
uut28: FULL_ADD PORT MAP(output => output(28), in0 => in0(28), carryin => carry27, in1 => in1(28), carryout => carry28);
uut29: FULL_ADD PORT MAP(output => output(29), in0 => in0(29), carryin => carry28, in1 => in1(29), carryout => carry29);
uut30: FULL_ADD PORT MAP(output => output(30), in0 => in0(30), carryin => carry29, in1 => in1(30), carryout => carry30);
uut31: FULL_ADD PORT MAP(output => output(31), in0 => in0(31), carryin => carry30, in1 => in1(31), carryout => carry31);
uut32: FULL_ADD PORT MAP(output => output(32), in0 => in0(32), carryin => carry31, in1 => in1(32), carryout => carry32);
uut33: FULL_ADD PORT MAP(output => output(33), in0 => in0(33), carryin => carry32, in1 => in1(33), carryout => carry33);
uut34: FULL_ADD PORT MAP(output => output(34), in0 => in0(34), carryin => carry33, in1 => in1(34), carryout => carry34);
uut35: FULL_ADD PORT MAP(output => output(35), in0 => in0(35), carryin => carry34, in1 => in1(35), carryout => carry35);
uut36: FULL_ADD PORT MAP(output => output(36), in0 => in0(36), carryin => carry35, in1 => in1(36), carryout => carry36);
uut37: FULL_ADD PORT MAP(output => output(37), in0 => in0(37), carryin => carry36, in1 => in1(37), carryout => carry37);
uut38: FULL_ADD PORT MAP(output => output(38), in0 => in0(38), carryin => carry37, in1 => in1(38), carryout => carry38);
uut39: FULL_ADD PORT MAP(output => output(39), in0 => in0(39), carryin => carry38, in1 => in1(39), carryout => carry39);
uut40: FULL_ADD PORT MAP(output => output(40), in0 => in0(40), carryin => carry39, in1 => in1(40), carryout => carry40);
uut41: FULL_ADD PORT MAP(output => output(41), in0 => in0(41), carryin => carry40, in1 => in1(41), carryout => carry41);
uut42: FULL_ADD PORT MAP(output => output(42), in0 => in0(42), carryin => carry41, in1 => in1(42), carryout => carry42);
uut43: FULL_ADD PORT MAP(output => output(43), in0 => in0(43), carryin => carry42, in1 => in1(43), carryout => carry43);
uut44: FULL_ADD PORT MAP(output => output(44), in0 => in0(44), carryin => carry43, in1 => in1(44), carryout => carry44);
uut45: FULL_ADD PORT MAP(output => output(45), in0 => in0(45), carryin => carry44, in1 => in1(45), carryout => carry45);
uut46: FULL_ADD PORT MAP(output => output(46), in0 => in0(46), carryin => carry45, in1 => in1(46), carryout => carry46);
uut47: FULL_ADD PORT MAP(output => output(47), in0 => in0(47), carryin => carry46, in1 => in1(47), carryout => carry47);
uut48: FULL_ADD PORT MAP(output => output(48), in0 => in0(48), carryin => carry47, in1 => in1(48), carryout => carry48);
uut49: FULL_ADD PORT MAP(output => output(49), in0 => in0(49), carryin => carry48, in1 => in1(49), carryout => carry49);
uut50: FULL_ADD PORT MAP(output => output(50), in0 => in0(50), carryin => carry49, in1 => in1(50), carryout => carry50);
uut51: FULL_ADD PORT MAP(output => output(51), in0 => in0(51), carryin => carry50, in1 => in1(51), carryout => carry51);
uut52: FULL_ADD PORT MAP(output => output(52), in0 => in0(52), carryin => carry51, in1 => in1(52), carryout => carry52);
uut53: FULL_ADD PORT MAP(output => output(53), in0 => in0(53), carryin => carry52, in1 => in1(53), carryout => carry53);
uut54: FULL_ADD PORT MAP(output => output(54), in0 => in0(54), carryin => carry53, in1 => in1(54), carryout => carry54);
uut55: FULL_ADD PORT MAP(output => output(55), in0 => in0(55), carryin => carry54, in1 => in1(55), carryout => carry55);
uut56: FULL_ADD PORT MAP(output => output(56), in0 => in0(56), carryin => carry55, in1 => in1(56), carryout => carry56);
uut57: FULL_ADD PORT MAP(output => output(57), in0 => in0(57), carryin => carry56, in1 => in1(57), carryout => carry57);
uut58: FULL_ADD PORT MAP(output => output(58), in0 => in0(58), carryin => carry57, in1 => in1(58), carryout => carry58);
uut59: FULL_ADD PORT MAP(output => output(59), in0 => in0(59), carryin => carry58, in1 => in1(59), carryout => carry59);
uut60: FULL_ADD PORT MAP(output => output(60), in0 => in0(60), carryin => carry59, in1 => in1(60), carryout => carry60);
uut61: FULL_ADD PORT MAP(output => output(61), in0 => in0(61), carryin => carry60, in1 => in1(61), carryout => carry61);
uut62: FULL_ADD PORT MAP(output => output(62), in0 => in0(62), carryin => carry61, in1 => in1(62), carryout => carry62);
uut63: FULL_ADD PORT MAP(output => output(63), in0 => in0(63), carryin => carry62, in1 => in1(63), carryout => carry63);
end;