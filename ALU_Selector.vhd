library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--created for selecting the correct ALU input... based on forwarding / stalling inputs
entity ALU_SEL is
port(
	forwardA : in STD_LOGIC_VECTOR(1 downto 0);
	forwardB : in STD_LOGIC_VECTOR(1 downto 0);
	WD : in STD_LOGIC_VECTOR(63 downto 0);
	ALU_result_output : in STD_LOGIC_VECTOR(63 downto 0);
	RD1_output : in STD_LOGIC_VECTOR(63 downto 0);	
	ALUin1 : in std_logic_vector(63 downto 0);
	
	--choose an output
	ALU_1 : out std_logic_vector(63 downto 0);
	ALU_2 : out std_logic_vector(63 downto 0)
);
end ALU_SEL;

architecture structural of ALU_SEL is
begin

    	ALU_1 <= ALU_result_output when forwardA = "10" else WD when forwardA = "01" else RD1_output;
    	ALU_2 <= ALU_result_output when forwardB = "10" else WD when forwardB = "01" else ALUin1;
end;
