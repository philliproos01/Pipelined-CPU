library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity IDEX is
	port(
		clk : in STD_LOGIC;
     		rst : in STD_LOGIC;
		enabled : in STD_LOGIC;
	
		instructionMem : in std_logic_vector(31 downto 0);
		Address_PC : in std_logic_vector(63 downto 0);
		
		extended_instruction : in std_logic_vector(63 downto 0);
		RD1 : in STD_LOGIC_VECTOR(63 downto 0);
		RD2 : in STD_LOGIC_VECTOR(63 downto 0);
	--cpu controls
		--Reg2Loc : in STD_LOGIC;
		CBranch : in STD_LOGIC; --conditional
		MemRead : in STD_LOGIC;
		MemtoReg : in STD_LOGIC;
		MemWrite : in STD_LOGIC;
		ALUSrc : in STD_LOGIC;
		RegWrite : in STD_LOGIC;
		UBranch : in STD_LOGIC; -- This is unconditional
		ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
		
		mux_sel_in : in STD_LOGIC_VECTOR(4 downto 0);


	--outputs
		instructionMem_output: out std_logic_vector(31 downto 0);
		Address_PC_output : out std_logic_vector(63 downto 0);
		
		extended_instruction_output : out std_logic_vector(63 downto 0);
		RD1_output : out STD_LOGIC_VECTOR(63 downto 0);
		RD2_output : out STD_LOGIC_VECTOR(63 downto 0);
	--cpu controls out
		--Reg2Loc_output : out STD_LOGIC;
		CBranch_output : out STD_LOGIC; --conditional
		MemRead_output : out STD_LOGIC;
		MemtoReg_output : out STD_LOGIC;
		MemWrite_output : out STD_LOGIC;
		ALUSrc_output : out STD_LOGIC;
		RegWrite_output : out STD_LOGIC;
		UBranch_output : out STD_LOGIC; -- This is unconditional
		inst_out : out STD_LOGIC_VECTOR(4 downto 0);
		mux_sel_out : out STD_LOGIC_VECTOR(4 downto 0);
		ALUOp_output : out STD_LOGIC_VECTOR(1 downto 0)
		
		

);
end IDEX;

architecture behavioral of IDEX is
begin
	process(rst, clk)
	begin
		if (rst = '1') then
			instructionMem_output <= X"00000000";
			Address_PC_output <= X"0000000000000000";

			extended_instruction_output <= X"0000000000000000";
			RD1_output <= X"0000000000000000";
			RD2_output <= X"0000000000000000";
			--cpu controls out
			--Reg2Loc_output <= '0';
			CBranch_output <= '0';
			MemRead_output <= '0';
			MemtoReg_output <= '0';
			MemWrite_output <= '0';
			ALUSrc_output <= '0';
			RegWrite_output <= '0';
			UBranch_output <= '0';
			ALUOp_output <= "00";
			mux_sel_out <= "00000";
			inst_out <= "00000";
		elsif (rst = '0') and rising_edge(clk) and (enabled = '1') then	
			instructionMem_output <= instructionMem;
			Address_PC_output <= Address_PC;
			
			extended_instruction_output <= extended_instruction;
			RD1_output <= RD1;
			RD2_output <= RD2;
			--cpu controls out
			--Reg2Loc_output <= Reg2Loc;
			CBranch_output <= CBranch;
			MemRead_output <= MemRead;
			MemtoReg_output <= MemtoReg;
			MemWrite_output <= MemWrite;
			ALUSrc_output <= ALUSrc;
			RegWrite_output <= RegWrite;
			UBranch_output <= UBranch;
			ALUOp_output <= ALUOp;
			mux_sel_out <= mux_sel_in;
			inst_out <= instructionMem(9 downto 5);

		


		end if;
	end process;
end;




