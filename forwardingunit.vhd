library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity forwarding is
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
end forwarding;

architecture behavioral of forwarding is 
begin
	process(Rn, Rm, EXMEMRd, EXMEM_e, MEMWBRd_e)
	begin
	if (EXMEM_e = '1') and (EXMEMRd /= "11111") and (EXMEMRd = Rn) then
            forwardA <= "10";
	
	--THIS ONE OFF CANVAS
    	elsif MEMWBRd_e = '1' and MEMWBRd /= "11111" and not(EXMEM_e = '1' and (EXMEMRd /= "11111") and (EXMEMRd = Rn)) and MEMWBRd = Rn then
            forwardA <= "01";
	else
            forwardA <= "00";
    	end if;

    	if (EXMEM_e = '1') and (EXMEMRd /= "11111") and (EXMEMRd = Rm) then
            forwardB <= "10";
	
	--THIS ONE OFF CANVAS
	elsif MEMWBRd_e = '1' and MEMWBRd /= "11111" and not(EXMEM_e = '1' and (EXMEMRd /="11111") and (EXMEMRd = Rm)) and MEMWBRd = Rm then
            forwardB <= "01";
    	else
            forwardB <= "00";
    	end if;



	end process;
end;

--from canvas
--if (MEM/WB.Regwrite
--and ( MEM/WB.RegisterRd 6= 11111 )
--and not(EX/MEM.RegWrite and (EX/MEM.RegisterRd 6= 11111 )
--and (EX/MEM.RegisterRd = ID/EX.RegisterRs))
--and (MEM/WB.RegisterRd = ID/EX.RegisterRs)) ForwardA = 01
--if (MEM/WB.Regwrite
--and (MEM/WB.RegisterRd 6= 11111 )
--and not(EX/MEM.RegWrite and (EX/MEM.RegisterRd 6= 11111 )
--and (EX/MEM.RegisterRd = ID/EX.RegisterRt))
--and (MEM/WB.RegisterRd = ID/EX.RegisterRt)) ForwardB = 01
