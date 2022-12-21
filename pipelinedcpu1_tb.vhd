library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- STD_LOGIC and STD_LOGIC_VECTOR
use IEEE.numeric_std.ALL; -- to_integer and unsigned


entity PipelinedCPU1_tb is

end PipelinedCPU1_tb;

architecture behavioral of PipelinedCPU1_tb is
component PipelinedCPU1
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
end component;

--signal DEBUG_ALUCONTROL : STD_LOGIC_VECTOR(10 downto 0);
signal clk : std_logic:= '0';
signal rst : std_logic:= '1';
--signal DEBUG_OUTAND : std_logic;
signal DEBUG_PC : STD_LOGIC_VECTOR(63 downto 0):= X"0000000000000000";
signal DEBUG_INSTRUCTION : STD_LOGIC_VECTOR(31 downto 0);
--signal DEBUG_INSOUT : STD_LOGIC_VECTOR(31 downto 0);
signal DEBUG_TMP_REGS : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
signal DEBUG_SAVED_REGS : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
signal DEBUG_MEM_CONTENTS : STD_LOGIC_VECTOR(64*4 - 1 downto 0);
signal DEBUG_RegWrite : std_logic;
signal DEBUG_RegWrite1 : std_logic;
signal DEBUG_RegWrite2 : std_logic;
signal DEBUG_RegWrite3 : std_logic;
signal DEBUG_Opcode : std_logic_vector(10 downto 0);
signal DEBUG_FORWARDA : std_logic_vector(1 downto 0);
signal DEBUG_FORWARDB : std_logic_vector(1 downto 0);
signal DEBUG_PC_WRITE_ENABLE : STD_LOGIC;

begin



     	uut: PipelinedCPU1 port map(clk => clk,
     		rst => rst,
     		DEBUG_PC => DEBUG_PC,
     		DEBUG_INSTRUCTION => DEBUG_INSTRUCTION,
     		DEBUG_TMP_REGS => DEBUG_TMP_REGS,
     		DEBUG_SAVED_REGS => DEBUG_SAVED_REGS,
		--DEBUG_RegWrite => DEBUG_RegWrite,
		--DEBUG_RegWrite1 => DEBUG_RegWrite1,
		--DEBUG_RegWrite2 => DEBUG_RegWrite2,
		--DEBUG_RegWrite3 => DEBUG_RegWrite3,
		--DEBUG_Opcode => DEBUG_Opcode,
		--DEBUG_ALUCONTROL => DEBUG_ALUCONTROL,
		--DEBUG_OUTAND => DEBUG_OUTAND,
		--DEBUG_INSOUT => DEBUG_INSOUT,
		DEBUG_FORWARDA => DEBUG_FORWARDA,
		DEBUG_FORWARDB => DEBUG_FORWARDB,
		DEBUG_PC_WRITE_ENABLE => DEBUG_PC_WRITE_ENABLE,
     		DEBUG_MEM_CONTENTS => DEBUG_MEM_CONTENTS--,
		---in0 => RD1,

	);
	
	rst <= '0';
	process_clock: process
	begin
		
		clk <= not clk;
		wait for 25 ns;

	end process;

	--reset_process: process
	--begin
	
end;
