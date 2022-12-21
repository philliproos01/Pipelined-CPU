library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PipelinedCPU1 is
port(
	clk :in std_logic;
	rst :in std_logic;
	--Probe ports used for testing
	-- Forwarding control signals
	DEBUG_FORWARDA : out std_logic_vector(1 downto 0);
	DEBUG_FORWARDB : out std_logic_vector(1 downto 0);
--The current address (AddressOut from the PC)
	DEBUG_PC : out std_logic_vector(63 downto 0);
	--Value of PC.write_enable
	DEBUG_PC_WRITE_ENABLE : out STD_LOGIC;
--The current instruction (Instruction output of IMEM)
	DEBUG_INSTRUCTION : out std_logic_vector(31 downto 0);
--DEBUG ports from other components
	DEBUG_TMP_REGS : out std_logic_vector(64*4-1 downto 0);
	DEBUG_SAVED_REGS : out std_logic_vector(64*4-1 downto 0);
	DEBUG_MEM_CONTENTS : out std_logic_vector(64*4-1 downto 0)
);
end PipelinedCPU1;

architecture behavioral of PipelinedCPU1 is

component AND2 is
	port (
		in0 : in STD_LOGIC;
		in1 : in STD_LOGIC;
		output : out STD_LOGIC
	);
end component;

component ShiftLeft2 is -- Shifts the input by 2 bits
	port(
		x : in STD_LOGIC_VECTOR(63 downto 0);
		y : out STD_LOGIC_VECTOR(63 downto 0) -- x << 2
	);
end component;

--conects with the adders for inputs, output to program counter
component MUX64 is -- Two by one mux with 64 bit inputs/outputs
	port(
		in0 : in STD_LOGIC_VECTOR(63 downto 0); -- sel == 0
		in1 : in STD_LOGIC_VECTOR(63 downto 0); -- sel == 1
		sel : in STD_LOGIC; -- selects in0 or in1
		output : out STD_LOGIC_VECTOR(63 downto 0)
	);
end component;

--conects with ALU and registers
component MUX64_2 is -- Two by one mux with 64 bit inputs/outputs
	port(
		in0 : in STD_LOGIC_VECTOR(63 downto 0); -- sel == 0
		in1 : in STD_LOGIC_VECTOR(63 downto 0); -- sel == 1
		sel : in STD_LOGIC; -- selects in0 or in1
		output : out STD_LOGIC_VECTOR(63 downto 0)
	);
end component;

--conects with dmem
component MUX64_3 is -- Two by one mux with 64 bit inputs/outputs
	port(
		in0 : in STD_LOGIC_VECTOR(63 downto 0); -- sel == 0
		in1 : in STD_LOGIC_VECTOR(63 downto 0); -- sel == 1
		sel : in STD_LOGIC; -- selects in0 or in1
		output : out STD_LOGIC_VECTOR(63 downto 0)
	);
end component;

--connects with instruction memory and registers (RR2)
component MUX5 is -- Two by one mux with 5 bit inputs/outputs
	port(
		in0 : in STD_LOGIC_VECTOR(4 downto 0); -- sel == 0
		in1 : in STD_LOGIC_VECTOR(4 downto 0); -- sel == 1
		sel : in STD_LOGIC; -- selects in0 or in1
		output : out STD_LOGIC_VECTOR(4 downto 0)
	);
end component;

component CPUControl is
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
end component;

component ADD is
port(
	in0 : in STD_LOGIC_VECTOR(63 downto 0);
	in1 : in STD_LOGIC_VECTOR(63 downto 0);
	output : out STD_LOGIC_VECTOR(63 downto 0)
);
end component;

component registers is
port(RR1 : in STD_LOGIC_VECTOR (4 downto 0);
	RR2 : in STD_LOGIC_VECTOR (4 downto 0);
	WR : in STD_LOGIC_VECTOR (4 downto 0);
	WD : in STD_LOGIC_VECTOR (63 downto 0);
	RegWrite : in STD_LOGIC;
	Clock : in STD_LOGIC;
	RD1 : out STD_LOGIC_VECTOR (63 downto 0);
	RD2 : out STD_LOGIC_VECTOR (63 downto 0);
	--Probe ports used for testing.
	-- Notice the width of the port means that you are
	-- reading only part of the register file.
	-- This is only for debugging
	-- You are debugging a sebset of registers here
	-- Temp registers: $X9 & $X10 & X11 & X12
	-- 4 refers to number of registers you are debugging
	DEBUG_TMP_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0);
	-- Saved Registers X19 & $X20 & X21 & X22
	DEBUG_SAVED_REGS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end component;

component DMEM is
port(
     WriteData          : in  STD_LOGIC_VECTOR(63 downto 0); -- Input data
     Address            : in  STD_LOGIC_VECTOR(63 downto 0); -- Read/Write address
     MemRead            : in  STD_LOGIC; -- Indicates a read operation
     MemWrite           : in  STD_LOGIC; -- Indicates a write operation
     Clock              : in  STD_LOGIC; -- Writes are triggered by a rising edge
     ReadData           : out STD_LOGIC_VECTOR(63 downto 0); -- Output data
     --Probe ports used for testing
     DEBUG_MEM_CONTENTS : out STD_LOGIC_VECTOR(64*4 - 1 downto 0)
);
end component;


component Controller is -- 64-bit rising-edge triggered register with write-enable and Asynchronous reset
-- For more information on what the PC does, see page 251 in the textbook
port(
        CBranch : in std_logic;
	Ubranch : in std_logic;
   	MemRead : in std_logic;
   	MemtoReg : in std_logic;
   	MemWrite : in std_logic;
	RegWrite : in std_logic;
   	ALUSrc : in std_logic;
   	ALUOp : in std_logic_vector(1 downto 0); 
	
	--send out from controls
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
end component;

component ALU is
port(
	in0 : in STD_LOGIC_VECTOR(63 downto 0);
	in1 : in STD_LOGIC_VECTOR(63 downto 0);
	operation : in STD_LOGIC_VECTOR(3 downto 0);
	result : buffer STD_LOGIC_VECTOR(63 downto 0);
	zero : buffer STD_LOGIC;
	overflow : buffer STD_LOGIC
);
end component;

component ALUControl is
	port(
		ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
		Opcode : in STD_LOGIC_VECTOR(10 downto 0);
		Operation : out STD_LOGIC_VECTOR(3 downto 0)
	);
end component;

component SignExtend is
	port(
		x : in STD_LOGIC_VECTOR(31 downto 0);
		y : out STD_LOGIC_VECTOR(63 downto 0) -- sign-extend(x)
	);
end component;

component IMEM is
port(
	Address : in STD_LOGIC_VECTOR(63 downto 0); -- Address to read from
	ReadData : out STD_LOGIC_VECTOR(31 downto 0)
);
end component;

component ADDER1 is
-- Adds two signed 64-bit inputs
-- output = in1 + in2
port(
	in0 : in STD_LOGIC_VECTOR(63 downto 0);
	in1 : in STD_LOGIC_VECTOR(63 downto 0);
	output : out STD_LOGIC_VECTOR(63 downto 0)
);
end component;

component ADDER2 is
-- Adds two signed 64-bit inputs
-- output = in1 + in2
port(
	in0 : in STD_LOGIC_VECTOR(63 downto 0);
	--in1 : in STD_LOGIC_VECTOR(63 downto 0);
	output : out STD_LOGIC_VECTOR(63 downto 0)
);
end component;

component ALU_SEL is 
port(
	forwardA : in STD_LOGIC_VECTOR(1 downto 0);
	forwardB : in STD_LOGIC_VECTOR(1 downto 0);
	WD : in STD_LOGIC_VECTOR(63 downto 0);
	ALU_result_output : in STD_LOGIC_VECTOR(63 downto 0);
	RD1_output : in STD_LOGIC_VECTOR(63 downto 0);	
	ALUin1 : in std_logic_vector(63 downto 0);
	
	ALU_1 : out std_logic_vector(63 downto 0);
	ALU_2 : out std_logic_vector(63 downto 0)
);
end component;

component PC is -- 64-bit rising-edge triggered register with write-enable and Asynchronous reset
-- For more information on what the PC does, see page 251 in the textbook
    port(
        clk : in STD_LOGIC; -- Propogate AddressIn to AddressOut on rising edge of clock
        write_enable : in STD_LOGIC; -- Only write if ?1?
        rst : in STD_LOGIC; -- Asynchronous reset! Sets AddressOut to 0x0
        AddressIn : in STD_LOGIC_VECTOR(63 downto 0); -- Next PC address
        AddressOut : out STD_LOGIC_VECTOR(63 downto 0) -- Current PC address
    );
end component;

component IFID is
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
end component;

component EXMEM is
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
end component;

component IDEX is
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
		mux_sel_in : in STD_LOGIC_VECTOR(4 downto 0);
		ALUOp : in STD_LOGIC_VECTOR(1 downto 0);



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
end component;

component MEMWB is
	port(
		clk : in STD_LOGIC;
     		rst : in STD_LOGIC;
		enabled : in STD_LOGIC;
	
		instruction_short : in STD_LOGIC_VECTOR(4 downto 0);
		
		Address : in std_logic_vector(63 downto 0);
		ReadData : in STD_LOGIC_VECTOR(63 downto 0);
		--RD2 : in STD_LOGIC_VECTOR(63 downto 0);
	--cpu controls

		MemtoReg : in STD_LOGIC;
		
		RegWrite : in STD_LOGIC;
		Address_output : out std_logic_vector(63 downto 0);
		ReadData_output : out STD_LOGIC_VECTOR(63 downto 0);
		instruction_output_short : out STD_LOGIC_VECTOR(4 downto 0);
	
		MemtoReg_output : out STD_LOGIC;

		RegWrite_output : out STD_LOGIC
		

);
end component;

component Hazard is
port(
	instruct_IF_RN      : in  STD_LOGIC_VECTOR (4 downto 0); 
     	instruct_IDEX_MemRead    : in  STD_LOGIC; 
	instruct_IDEX_RegisterRD : in  STD_LOGIC_VECTOR (4 downto 0); 
     	instruct_IF_mem   : in  STD_LOGIC_VECTOR (4 downto 0);
     	
	IFID_write : out STD_LOGIC;
	controls : out STD_LOGIC;
    	PC    : out  STD_LOGIC
    	--RD1      : out STD_LOGIC_VECTOR (63 downto 0);
);
end component;

component forwarding is
port(
	
	MEMWBRd     : in  STD_LOGIC_VECTOR (4 downto 0);
	Rm      : in  STD_LOGIC_VECTOR (4 downto 0); 
     	EXMEMRd     : in  STD_LOGIC_VECTOR (4 downto 0); 
	Rn      : in  STD_LOGIC_VECTOR (4 downto 0);
	
	--needs logic control
	EXMEM_e : in STD_LOGIC;
	MEMWBRd_e : in STD_LOGIC;
	--WR       : in  STD_LOGIC_VECTOR (4 downto 0);

	forwardA : out STD_LOGIC_VECTOR (1 downto 0);
	forwardB : out STD_LOGIC_VECTOR (1 downto 0)
);
end component;
--signal starts 
signal instructionMem : std_logic_vector(31 downto 0);

--

signal RR2 : std_logic_vector(4 downto 0);
signal ALUin1 : std_logic_vector(63 downto 0);
signal ALUSrc : std_logic;
signal RD2 : std_logic_vector(63 downto 0);

--signal x : STD_LOGIC_VECTOR(31 downto 0); --signextend input, instruction output
signal y : std_logic_vector(63 downto 0);
--signal dmem_address : STD_LOGIC_VECTOR(63 downto 0);
signal MemtoReg : std_logic;
signal WD : STD_LOGIC_VECTOR(63 downto 0);
signal ReadData : std_logic_vector(63 downto 0);
signal result : std_logic_vector(63 downto 0);
signal sl2_output : STD_LOGIC_VECTOR(63 downto 0);
signal AddressOut_PC : STD_LOGIC_VECTOR(63 downto 0);
signal adder2_output : STD_LOGIC_VECTOR(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
signal adder1_output : STD_LOGIC_VECTOR(63 downto 0);
signal PC_AddressIn : STD_LOGIC_VECTOR(63 downto 0);
signal RD1 : std_logic_vector(63 downto 0);
signal operation : std_logic_vector(3 downto 0);

signal ALUOp : std_logic_vector(1 downto 0);
signal zero : std_logic;
signal overflow : std_logic;
signal Branch : STD_LOGIC;
signal Ubranch : std_logic;
signal CBranch : std_logic;
signal Reg2Loc : std_logic;
signal RegWrite : std_logic;
    
signal output_and : STD_LOGIC;  

signal MemWrite : std_logic;
signal MemRead : std_logic;
signal RR1 : STD_LOGIC_VECTOR (4 downto 0);
signal instructionMem_output : std_logic_vector(31 downto 0);

signal SIGNAL_DEBUG_TMP_REGS : std_logic_vector(64*4 - 1 downto 0);
	-- Saved Registers X19 & $X20 & X21 & X22
signal SIGNAL_DEBUG_SAVED_REGS : std_logic_vector(64*4 - 1 downto 0);
signal SIGNAL_DEBUG_MEM_CONTENTS : std_logic_vector(64*4 - 1 downto 0);
signal Address_PC_output : std_logic_vector(63 downto 0);
signal extended_instruction_output : std_logic_vector(63 downto 0);

signal enable_ifid  : std_logic := '1';
signal enable_idex  : std_logic := '1';
signal enable_exmem : std_logic := '1';
signal enable_memwb : std_logic := '1';

--signals for IDEX
signal Address_PC_output2 : std_logic_vector(63 downto 0);
signal instructionMem_output2 : std_logic_vector(31 downto 0);
signal RD1_output : std_logic_vector(63 downto 0);
signal RD2_output : std_logic_vector(63 downto 0);   
signal to_forward : std_logic_vector(4 downto 0);

--signal Reg2Loc_output : STD_LOGIC;
signal CBranch_output : std_logic;
signal MemRead_output : std_logic;
signal MemtoReg_output : std_logic;
signal MemWrite_output : std_logic;
signal ALUSrc_output : std_logic;
signal RegWrite_output : std_logic;
signal UBranch_output : std_logic;
signal ALUOp_output : std_logic_vector(1 downto 0);

 
--signals for EXMEM
signal CBranch_output2 : std_logic;
signal MemRead_output2 : std_logic;
signal MemtoReg_output2 : std_logic;
signal MemWrite_output2 : std_logic;
signal RegWrite_output2 : std_logic;
signal UBranch_output2 : std_logic;

signal ALU_Zero_output : std_logic;
signal ALU_result_output : std_logic_vector(63 downto 0);
signal ADD_output : STD_LOGIC_VECTOR(63 downto 0);
signal RD2_output2 : std_logic_vector(63 downto 0);
signal instructionMem_short_output : std_logic_vector(4 downto 0);

--signals for MEMWB
signal Address_output_MEMWB : std_logic_vector(63 downto 0);
signal ReadData_output : std_logic_vector(63 downto 0);
signal instruction_output_short2 : std_logic_vector(4 downto 0);

signal MemtoReg_output3 : std_logic;
signal RegWrite_output3 : std_logic;
signal andresult : STD_LOGIC;


--signals for hazard
signal instruct_IF_RN : STD_LOGIC_VECTOR(4 downto 0); 
signal instruct_IDEX_MemRead : STD_LOGIC; 
signal instruct_IDEX_RegisterRD : STD_LOGIC_VECTOR(4 downto 0); 
signal instruct_IF_mem : STD_LOGIC_VECTOR(4 downto 0);

signal IFID_signal_en : STD_LOGIC;
signal controls : std_logic;
signal PCinput : STD_LOGIC;
signal IFID_signal_reset : STD_LOGIC;

--signals for forward
signal forwardA : std_logic_vector(1 downto 0);
signal forwardB : std_logic_vector(1 downto 0);
signal Rm : std_logic_vector(4 downto 0);
signal CBranch_1 : std_logic;
signal Ubranch_1 : std_logic;
signal MemtoReg_1 : std_logic;
signal MemRead_1 : std_logic;
signal RegWrite_1 : std_logic;
signal MemWrite_1 : std_logic;
signal ALUSrc_1 : std_logic;
signal ALUOp_1 : std_logic_vector(1 downto 0);  

signal pc_write_enable : std_logic;
signal ALU_1 : std_logic_vector(63 downto 0);
signal ALU_2 : std_logic_vector(63 downto 0);

signal mux_select : std_logic;     

begin

uuthazard: Hazard port map(
	instruct_IF_RN => instructionMem_output(9 downto 5),
     	instruct_IDEX_MemRead => MemRead_output,
	instruct_IDEX_RegisterRD => instructionMem_output2(4 downto 0),
     	instruct_IF_mem => RR2,
     	
	IFID_write => enable_ifid,
	--send signals to controller for CPU
	controls => controls,
    	PC => pc_write_enable
    	--RD1      : out STD_LOGIC_VECTOR (63 downto 0);
);

uutforward: forwarding port map(
        Rn => to_forward,
        Rm => Rm,
        EXMEMRd => instructionMem_short_output,
	--needs logic control
        EXMEM_e => RegWrite_output2,

        MEMWBRd => instruction_output_short2,
	--needs logic control
        MEMWBRd_e => RegWrite_output3,

	--these go to muxes for ALU inputs
        forwardA => forwardA,
        forwardB => forwardB
    );

uuli: IMEM PORT MAP(
	Address => AddressOut_PC,
	ReadData => instructionMem
);

--send signals to the controller from CPUControl
uutl: CPUControl port map(Opcode => instructionMem_output(31 downto 21),
	Reg2Loc => Reg2Loc,
	CBranch => CBranch,
	MemRead => MemRead,
	MemtoReg => MemtoReg,
	MemWrite => MemWrite,
	ALUSrc => ALUSrc,
	RegWrite => RegWrite,
	UBranch => UBranch,
	ALUOp => ALUOp
	);
	
uut: MUX5 PORT MAP(in0 => instructionMem_output(20 downto 16), 
	in1 => instructionMem_output(4 downto 0), 
	sel => Reg2Loc, 
	output => RR2
	);

uuti: SignExtend PORT MAP(
	x => instructionMem_output(31 downto 0),
	y => y
	);
 



uutj: IFID PORT MAP(
		--: in STD_LOGIC;
		clk => clk,
     		rst => rst,
		enabled => enable_ifid,
	
		instructionMem => instructionMem,
--in std_logic_vector(31 downto 0);
		Address_PC => AddressOut_PC,
--in std_logic_vector(63 downto 0);

	
		instructionMem_output => instructionMem_output, --out std_logic_vector(31 downto 0);
		Address_PC_output => Address_PC_output --out std_logic_vector(63 downto 0)

);

uutk: IDEX PORT MAP(
	clk => clk,
     	rst => rst,
	enabled => enable_idex,
	
	instructionMem => instructionMem_output,
		Address_PC => Address_PC_output,
		
		extended_instruction => y,
		RD1 => RD1,
		RD2 => RD2,
	--cpu controls
		
		CBranch => CBranch_1,
		MemRead => MemRead_1,
		MemtoReg => MemtoReg_1,
		MemWrite => MemWrite_1,
		ALUSrc => ALUSrc_1,
		RegWrite => RegWrite_1,
		UBranch => Ubranch_1,
		ALUOp => ALUOp_1,

		mux_sel_in => RR2,

	--outputs
		instructionMem_output => instructionMem_output2,--: out std_logic_vector(31 downto 0);
		Address_PC_output => Address_PC_output2, --: out std_logic_vector(63 downto 0);
		
		extended_instruction_output => extended_instruction_output, --: out std_logic_vector(63 downto 0);
		RD1_output => RD1_output,--: out STD_LOGIC_VECTOR(63 downto 0);
		RD2_output => RD2_output,--: out STD_LOGIC_VECTOR(63 downto 0);
	--cpu controls out
		
		CBranch_output => CBranch_output,--: out STD_LOGIC; --conditional
		MemRead_output => MemRead_output,--: out STD_LOGIC;
		MemtoReg_output => MemtoReg_output,--: out STD_LOGIC;
		MemWrite_output => MemWrite_output,--: out STD_LOGIC;
		ALUSrc_output => ALUSrc_output, --: out STD_LOGIC;
		RegWrite_output => RegWrite_output,--: out STD_LOGIC;
		UBranch_output => UBranch_output, --: out STD_LOGIC; -- This is unconditional
		inst_out => to_forward,
		mux_sel_out => Rm,
		ALUOp_output => ALUOp_output--: out STD_LOGIC_VECTOR(1 downto 0)
	);

uutn: EXMEM port map(
		clk => clk,
     		rst => rst,
		enabled => enable_exmem,

		instructionMem_short => instructionMem_output2(4 downto 0),
		ALU_Zero => zero,
		ALU_result => result,
		ADD => adder1_output,
		RD2 => RD2_output,

	--cpu controls
		--Reg2Loc : in STD_LOGIC;
		CBranch => CBranch_output, --conditional
		MemRead => MemRead_output,
		MemtoReg => MemtoReg_output,
		MemWrite => MemWrite_output,
		--ALUSrc : in STD_LOGIC;
		RegWrite => RegWrite_output,
		UBranch => UBranch_output, -- This is unconditional
		--ALUOp : in STD_LOGIC_VECTOR(1 downto 0);



	--outputs
		instructionMem_short_output => instructionMem_short_output,
		ALU_Zero_output => ALU_Zero_output,
		ALU_result_output => ALU_result_output, --: out STD_LOGIC_VECTOR(63 downto 0);
		ADD_output => ADD_output, --: out STD_LOGIC_VECTOR(63 downto 0);
		RD2_output => RD2_output2, --: out STD_LOGIC_VECTOR(63 downto 0);
	--cpu controls out
		
		CBranch_output => CBranch_output2, --conditional
		MemRead_output => MemRead_output2,
		MemtoReg_output => MemtoReg_output2,
		MemWrite_output => MemWrite_output2,
		RegWrite_output => RegWrite_output2,
		UBranch_output => UBranch_output2 --: out STD_LOGIC -- This is unconditional
		
);

uutf: MEMWB port map(
		clk => clk,
     		rst => rst,
		enabled => enable_memwb,
	
		instruction_short => instructionMem_short_output, --: in STD_LOGIC_VECTOR(4 downto 0);
		
		Address => ALU_result_output,
		ReadData => ReadData,
		--RD2 => RD2_output,
	--cpu controls
		MemtoReg => MemtoReg_output2,
		RegWrite => RegWrite_output2,
	--outputs
		
		Address_output => Address_output_MEMWB,
		ReadData_output => ReadData_output,
		instruction_output_short => instruction_output_short2,
	--cpu controls out

		MemtoReg_output => MemtoReg_output3,
		RegWrite_output => RegWrite_output3
		
);

uti1: ShiftLeft2 PORT MAP(
	x => extended_instruction_output,
	y => sl2_output
	);

	 
uti2: ADD
     port map(
        in0 => sl2_output,
        in1 => Address_PC_output2,
        output => adder1_output
	);

uut2: MUX64_2 PORT MAP(
	in0 => RD2_output, 
	in1 => extended_instruction_output, 
	sel => ALUSrc_output,
	output => ALUin1
	);

--connects with two adders --left / top most mux
uut1: MUX64 PORT MAP(in0 => adder2_output, 
	in1 => ADD_output, 
	sel => mux_select, --selection based off of or gate results
	output => PC_AddressIn
	);

--dmem output mux
uut3: MUX64_3 PORT MAP(in0 => Address_output_MEMWB,--result, 
	in1 => ReadData_output, --ReadData, 
	--original
	--in0 => result, 
	--in1 => ReadData, 
	
	sel => MemtoReg_output3,--MemtoReg,
	output => WD
	);     

--uti3: ADDER2 PORT MAP(
	--in0 => AddressOut_PC,
	--in1 => "0000000000000000000000000000000000000000000000000000000000000100", --just set to 4 if necessary
	--output => adder2_output
--); 
adder2_output <= std_logic_vector(unsigned(AddressOut_PC) + 4);
 
uut4: PC PORT MAP(
        clk => clk,
        write_enable => pc_write_enable,
        rst => rst,
        AddressIn => PC_AddressIn,
        AddressOut => AddressOut_PC
    	);

uut7: ALUControl port map(
	ALUOp => ALUOp_output,
	Opcode => instructionMem_output2(31 downto 21),
	Operation => operation
	);

uut5: ALU PORT MAP(
	in0 => ALU_1,--RD1_output, 
	in1 => ALU_2,--ALUin1,
	operation => operation,
	result => result,
	zero => zero,
	overflow => overflow
	);

uut9: ALU_SEL PORT MAP(
	forwardA => forwardA,
	forwardB => forwardB,
	WD => WD,
	ALU_result_output => ALU_result_output,
	RD1_output => RD1_output,
	ALUin1 => ALUin1,
	
	ALU_1 => ALU_1,
	ALU_2 => ALU_2
);

uulr: registers PORT MAP(
	RR1 => instructionMem_output(9 downto 5),
	RR2 => RR2,
	WR => instruction_output_short2,--instructionMem(4 downto 0),
	WD => WD,
	RegWrite => RegWrite_output3,
	Clock => clk,
	RD1 => RD1,
	RD2 => RD2,
	-- 4 refers to number of registers you are debugging
	DEBUG_TMP_REGS => SIGNAL_DEBUG_TMP_REGS,
	-- Saved Registers X19 & $X20 & X21 & X22
	DEBUG_SAVED_REGS => SIGNAL_DEBUG_SAVED_REGS
);

ujde: Controller port map(
        CBranch => CBranch,
   	MemRead => MemRead,
   	MemtoReg => MemtoReg,
   	MemWrite => MemWrite,
   	ALUSrc => ALUSrc,
    	RegWrite => RegWrite,
    	Ubranch => Ubranch,
    	ALUOp => ALUOp,
	--use to control which CPUcontrol is triggered
	controls => controls,

	CBranch_1 => CBranch_1,
	Ubranch_1 => Ubranch_1,
   	MemRead_1 => MemRead_1,
	RegWrite_1 => RegWrite_1,
   	MemtoReg_1 => MemtoReg_1,
   	MemWrite_1 => MemWrite_1,
   	ALUSrc_1 => ALUSrc_1,
    	ALUOp_1 => ALUOp_1
   );

ull1: AND2 PORT MAP(
	in0 => CBranch_output2,
	in1 => ALU_Zero_output,
	output => andresult
	);

uuld: DMEM PORT MAP(
	WriteData => RD2_output2,
	Address => ALU_result_output,
     	MemRead => MemRead_output2,
     	MemWrite => MemWrite_output2,
     	Clock => clk,
     	ReadData => ReadData,
     	--Probe ports used for testing
     	DEBUG_MEM_CONTENTS => SIGNAL_DEBUG_MEM_CONTENTS
);

	DEBUG_PC_WRITE_ENABLE <= pc_write_enable;
	DEBUG_INSTRUCTION <= instructionMem;
	DEBUG_PC <= AddressOut_PC;
	DEBUG_TMP_REGS <= SIGNAL_DEBUG_TMP_REGS;
    	DEBUG_SAVED_REGS <= SIGNAL_DEBUG_SAVED_REGS;
    	DEBUG_MEM_CONTENTS <= SIGNAL_DEBUG_MEM_CONTENTS;
	DEBUG_FORWARDA <= forwardA;
    	DEBUG_FORWARDB <= forwardB;      

    	mux_select <= andresult or UBranch_output2;

	--DEBUG_RegWrite <= RegWrite;
	--DEBUG_RegWrite1 <= RegWrite_output;
	--DEBUG_RegWrite2 <= RegWrite_output2;
	--DEBUG_RegWrite3 <= RegWrite_output3;
     	--DEBUG_Opcode <= instructionMem_output(31 downto 21);

     
     	--DEBUG_INSOUT <= instructionMem_output;
	--DEBUG_OUTAND <= output_and;
	--DEBUG_ALUCONTROL <= instructionMem_output(31 downto 21);

end;