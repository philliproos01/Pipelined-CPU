library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity FULL_ADD is
--call this 64 times
port(
	in0 : in STD_LOGIC;
	in1 : in STD_LOGIC;
	carryin :  in STD_LOGIC;
	carryout : out std_logic;
	output : out STD_LOGIC
);
end FULL_ADD;

architecture data_flow of FULL_ADD is
begin

	output <= (in0 xor in1) xor carryin;
	carryout <= (in0 and carryin) or (in1 and carryin) or (in0 and in1);

end;
