library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity Controller is 
port(
        CBranch : in std_logic;
	Ubranch : in std_logic;
   	MemRead : in std_logic;
   	MemtoReg : in std_logic;
   	MemWrite : in std_logic;
	RegWrite : in std_logic;
   	ALUSrc : in std_logic;
   	ALUOp : in std_logic_vector(1 downto 0); 
	
	controls : in std_logic;

	CBranch_1 : out std_logic;
	Ubranch_1 : out std_logic;
   	MemRead_1 : out std_logic;
   	MemWrite_1 : out std_logic;
	MemtoReg_1 : out std_logic;
	RegWrite_1 : out std_logic;
   	ALUSrc_1 : out std_logic;
    	
    	
    	ALUOp_1 : out std_logic_vector(1 downto 0) 
);
end Controller;

architecture structural of Controller is
begin
	MemtoReg_1 <= MemtoReg 
	when controls = '1' else '0';
	MemWrite_1 <= MemWrite 
	when controls = '1' else '0';
	CBranch_1 <= CBranch 
	when controls = '1' else '0';
   	Ubranch_1 <= Ubranch 
	when controls = '1' else '0';
	MemRead_1 <= MemRead 
	when controls = '1' else '0';
   	ALUSrc_1 <= ALUSrc 
	when controls = '1' else '0';
    	RegWrite_1 <= RegWrite 
	when controls = '1' else '0';
    	ALUOp_1 <= ALUOp 
	when controls = '1' else "00";
end;
