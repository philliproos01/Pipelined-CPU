library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity IFID is
	port(
		clk : in STD_LOGIC;
     		rst : in STD_LOGIC;
		enabled : in STD_LOGIC;
	
		instructionMem : in std_logic_vector(31 downto 0);
		Address_PC : in std_logic_vector(63 downto 0);

	--outputs
		instructionMem_output: out std_logic_vector(31 downto 0);
		Address_PC_output : out std_logic_vector(63 downto 0)

);
end IFID;

architecture behavioral of IFID is
begin
	process(rst, clk)
	begin
		if (rst = '0') and rising_edge(clk) and (enabled = '1') then	
			instructionMem_output <= instructionMem;
			Address_PC_output <= Address_PC;
		elsif (rst = '1') then
			instructionMem_output <= X"00000000";
			Address_PC_output <= X"0000000000000000";
		end if;
	end process;
end;
