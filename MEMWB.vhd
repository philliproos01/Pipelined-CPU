library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity MEMWB is
	port(
		clk : in STD_LOGIC;
     		rst : in STD_LOGIC;
		enabled : in STD_LOGIC;
	
		instruction_short : in STD_LOGIC_VECTOR(4 downto 0);
		
		Address : in std_logic_vector(63 downto 0);
		ReadData : in STD_LOGIC_VECTOR(63 downto 0);
		--RD2 : in STD_LOGIC_VECTOR(63 downto 0);
	--cpu controls
		--Reg2Loc : in STD_LOGIC;
		--CBranch : in STD_LOGIC; --conditional
		--MemRead : in STD_LOGIC;
		MemtoReg : in STD_LOGIC;
		--MemWrite : in STD_LOGIC;
		--ALUSrc : in STD_LOGIC;
		RegWrite : in STD_LOGIC;
		--UBranch : in STD_LOGIC; -- This is unconditional
		--ALUOp : in STD_LOGIC_VECTOR(1 downto 0);



	--outputs
		--instructionMem_output: out std_logic_vector(31 downto 0);
		
		Address_output : out std_logic_vector(63 downto 0);
		ReadData_output : out STD_LOGIC_VECTOR(63 downto 0);
		instruction_output_short : out STD_LOGIC_VECTOR(4 downto 0);
	--cpu controls out
		--Reg2Loc_output : out STD_LOGIC;
		--CBranch_output : out STD_LOGIC; --conditional
		--MemRead_output : out STD_LOGIC;
		MemtoReg_output : out STD_LOGIC;
		--MemWrite_output : out STD_LOGIC;
		--ALUSrc_output : out STD_LOGIC;
		RegWrite_output : out STD_LOGIC
		

);
end MEMWB;

architecture behavioral of MEMWB is
begin
	process(rst, clk)
	begin
		if (rst = '0') and rising_edge(clk) and (enabled = '1') then	
			instruction_output_short <= instruction_short; --maybe change this later
			Address_output <= Address;
			ReadData_output <= ReadData;
			--cpu controls out
			MemtoReg_output <= MemtoReg;
			RegWrite_output <= RegWrite;

		elsif (rst = '1') then
			ReadData_output <= X"0000000000000000";

			instruction_output_short <= "00000";
			Address_output <= X"0000000000000000";

			--cpu controls out
			MemtoReg_output <= '0';
			RegWrite_output <= '0';


		end if;
	end process;
end;



