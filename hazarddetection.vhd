library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hazard is
port(
	instruct_IF_RN      : in  STD_LOGIC_VECTOR (4 downto 0); 
     	instruct_IDEX_MemRead    : in  STD_LOGIC; 
	instruct_IDEX_RegisterRD : in  STD_LOGIC_VECTOR (4 downto 0); 
     	instruct_IF_mem   : in  STD_LOGIC_VECTOR (4 downto 0);
     	
	IFID_write : out STD_LOGIC;
	controls : out STD_LOGIC;
    	PC    : out  STD_LOGIC
);
end Hazard;

architecture behavioral of Hazard is
begin

	process(instruct_IF_RN, instruct_IDEX_MemRead, instruct_IDEX_RegisterRD, instruct_IF_mem)
	begin
		if (instruct_IF_RN = instruct_IDEX_RegisterRD or instruct_IF_mem = instruct_IDEX_RegisterRD) and (instruct_IDEX_MemRead = '1') then
			IFID_write <= '0';
			controls <= '0';
    			PC <= '0';
		else
			IFID_write <= '1';
			controls <= '1';
    			PC <= '1';
		end if;
	end process;
end;