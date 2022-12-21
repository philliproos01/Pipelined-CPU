library ieee;
use ieee.std_logic_1164.all;

entity AND2 is
port (
	in0 : in STD_LOGIC;
	in1 : in STD_LOGIC;
	output : out STD_LOGIC
);
end AND2;

architecture synth of AND2 is
begin
	output <= in0 AND in1;

end synth;