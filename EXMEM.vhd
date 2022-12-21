library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- STD_LOGIC and STD_LOGIC_VECTOR
use IEEE.numeric_std.ALL; -- to_integer and unsigned

entity EXMEM is
	port(
		clk : in STD_LOGIC;
     		rst : in STD_LOGIC;
		enabled : in STD_LOGIC;

		instructionMem_short : in std_logic_vector(4 downto 0);
		ALU_Zero : in STD_LOGIC;
		ALU_result : in STD_LOGIC_VECTOR(63 downto 0);
		ADD : in STD_LOGIC_VECTOR(63 downto 0);
		RD2 : in STD_LOGIC_VECTOR(63 downto 0);

	--cpu controls
		--Reg2Loc : in STD_LOGIC;
		CBranch : in STD_LOGIC; --conditional
		MemRead : in STD_LOGIC;
		MemtoReg : in STD_LOGIC;
		MemWrite : in STD_LOGIC;
		--ALUSrc : in STD_LOGIC;
		RegWrite : in STD_LOGIC;
		UBranch : in STD_LOGIC; -- This is unconditional
		--ALUOp : in STD_LOGIC_VECTOR(1 downto 0);



	--outputs
		instructionMem_short_output : out std_logic_vector(4 downto 0);
		ALU_Zero_output : out STD_LOGIC;
		ALU_result_output : out STD_LOGIC_VECTOR(63 downto 0);
		ADD_output : out STD_LOGIC_VECTOR(63 downto 0);
		RD2_output : out STD_LOGIC_VECTOR(63 downto 0);
	--cpu controls out
		--Reg2Loc_output : out STD_LOGIC;
		CBranch_output : out STD_LOGIC; --conditional
		MemRead_output : out STD_LOGIC;
		MemtoReg_output : out STD_LOGIC;
		MemWrite_output : out STD_LOGIC;
		--ALUSrc_output : out STD_LOGIC;
		RegWrite_output : out STD_LOGIC;
		UBranch_output : out STD_LOGIC -- This is unconditional
		--ALUOp_output : out STD_LOGIC_VECTOR(1 downto 0)



);
end EXMEM;

architecture behavioral of EXMEM is
begin
	process(rst, clk)
	begin
		if (rst = '0') and rising_edge(clk) and (enabled = '1') then	
			ALU_Zero_output <= ALU_Zero;
			ALU_result_output <= ALU_result;
			ADD_output <= ADD;
			RD2_output <= RD2;
			--cpu controls out
			--Reg2Loc_output <= Reg2Loc;
			CBranch_output <= CBranch;
			MemRead_output <= MemRead;
			MemtoReg_output <= MemtoReg;
			MemWrite_output <= MemWrite;
			--ALUSrc_output <= ALUSrc;
			RegWrite_output <= RegWrite;
			UBranch_output <= UBranch;
			--ALUOp_output <= ALUOp;
			instructionMem_short_output <= instructionMem_short;

		elsif (rst = '1') then

			ALU_Zero_output <= '0';
			ALU_result_output <= X"0000000000000000";
			ADD_output <= X"0000000000000000";
			RD2_output <= X"0000000000000000";
			--cpu controls out
			--Reg2Loc_output <= '0';
			CBranch_output <= '0';
			MemRead_output <= '0';
			MemtoReg_output <= '0';
			MemWrite_output <= '0';
			--ALUSrc_output <= '0';
			RegWrite_output <= '0';
			UBranch_output <= '0';
			--ALUOp_output <= "00";
			instructionMem_short_output <= "00000";


		end if;
	end process;
end;


