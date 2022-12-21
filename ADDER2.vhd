library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- STD_LOGIC and STD_LOGIC_VECTOR
use IEEE.numeric_std.ALL; -- to_integer and unsigned

--use IEEE.std_logic_arith.all;
--use IEEE.std_logic_unsigned.all;


entity ADDER2 is
-- Adds two signed 64-bit inputs
-- output = in1 + in2
port(
	in0 : in STD_LOGIC_VECTOR(63 downto 0);
	--in1 : in STD_LOGIC_VECTOR(63 downto 0);
	output : out STD_LOGIC_VECTOR(63 downto 0)
);
end ADDER2;

architecture synth of ADDER2 is
begin
	output <= std_logic_vector(unsigned(in0) + 4);
	--output <= std_logic_vector(unsigned(in0) + in1);
end;