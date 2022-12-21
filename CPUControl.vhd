
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity CPUControl is
-- Functionality should match the truth table shown in Figure 4.22 of the textbook, inlcuding the
-- output ?X? values.
-- The truth table in Figure 4.22 omits the unconditional branch instruction:
-- UBranch = ?1?
-- MemWrite = RegWrite = ?0?
-- all other outputs = ?X?
port(Opcode : in STD_LOGIC_VECTOR(10 downto 0);
	Reg2Loc : out STD_LOGIC;
	CBranch : out STD_LOGIC; --conditional
	MemRead : out STD_LOGIC;
	MemtoReg : out STD_LOGIC;
	MemWrite : out STD_LOGIC;
	ALUSrc : out STD_LOGIC;
	RegWrite : out STD_LOGIC;
	UBranch : out STD_LOGIC; -- This is unconditional
	ALUOp : out STD_LOGIC_VECTOR(1 downto 0)
);
end CPUControl;

architecture behavioral of CPUControl is
begin
	--implementing ADD, ADDI, AND, ANDI, CBNZ, CBZ, LDUR, LSL, LSR, ORR, ORI, STUR, SUB, SUBI
	process(Opcode)
	begin
		--case Opcode is 
			--R type instruction --1XX0101X000
			if (Opcode(10) = '1') and (Opcode(7 downto 4) = "0101") and (Opcode(2 downto 0) = "000") then
			--if Opcode = "1XX0101X000" then --=> 
				Reg2Loc <= '0';
				ALUSrc <= '0';
				MemtoReg <= '0';
				RegWrite <= '1';
				MemRead <= '0';
				MemWrite <= '0';
				CBranch <= '0';
				ALUOp <= "10";
				UBranch <= '0';
			
			--does LDUR instruction
			elsif Opcode = "11111000010" then --=>  
				Reg2Loc <= 'X'; --x
				ALUSrc <= '1';
				MemtoReg <= '1';
				RegWrite <= '1';
				MemRead <= '1';
				MemWrite <= '0';
				CBranch <= '0';
				ALUOp <= "00";
				UBranch <= '0';
			--does STUR instruction
			elsif Opcode = "11111000000" then --=> 
				Reg2Loc <= '1';
				ALUSrc <= '1';
				MemtoReg <= 'X'; --x
				RegWrite <= '0'; --RegWrite <= '0'
				MemRead <= '0';
				MemWrite <= '1';
				CBranch <= '0';
				ALUOp <= "00";
				UBranch <= '0';
			
			--does CBZ
			 elsif Opcode(10 downto 3) = "10110100" then
			--elsif Opcode = "10110100XXX" then --=> 
				Reg2Loc <= '1';
				ALUSrc <= '0';
				MemtoReg <= 'X';
				RegWrite <= '0';
				MemRead <= '0';
				MemWrite <= '0';
				CBranch <= '1';
				ALUOp <= "01";
				UBranch <= '0';
			
			--unconditional
			elsif Opcode(10 downto 5) = "000101" then --=> 
				Reg2Loc <= 'X'; --x
				ALUSrc <= 'X'; --x
				MemtoReg <= 'X'; --x
				RegWrite <= '0'; --0
				MemRead <= 'X'; --x
				MemWrite <= '0'; --0
				CBranch <= 'X'; --x
				ALUOp <= "XX"; --x
				UBranch <= '1'; --1

			--does I-type instructions for immediate
			--elsif Opcode = "1XX100XX00X" then --=>	
			 elsif (Opcode(10) = '1') and (Opcode(7 downto 5) = "100") and (Opcode(2 downto 1) = "00") then 		
				Reg2Loc <= '0';
				ALUSrc <= '1';
				MemtoReg <= '0';
				RegWrite <= '1';
				MemRead <= '0';
				MemWrite <= '1';
				CBranch <= '0';
				ALUOp <= "10";
				UBranch <= '0';

			else
			--when others =>		--might need to be all "x" instead of 0
				Reg2Loc <= '0';
				ALUSrc <= '0';
				MemtoReg <= '0';
				RegWrite <= '0';
				MemRead <= '0';
				MemWrite <= '0';
				CBranch <= '0';
				ALUOp <= "00";
				UBranch <= '0';

			end if;
		--end case;

	end process;
end;