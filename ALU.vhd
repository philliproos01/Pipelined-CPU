library ieee;
use ieee.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;


entity ALU is
-- Implement: AND, OR, ADD (signed), SUBTRACT (signed)
-- as described in Section 4.4 in the textbook.
-- The functionality of each instruction can be found on the ?ARM Reference Data? sheet at the
-- front of the textbook (or the ISA pdf on Canvas).
port(
	in0 : in STD_LOGIC_VECTOR(63 downto 0);
	in1 : in STD_LOGIC_VECTOR(63 downto 0);
	operation : in STD_LOGIC_VECTOR(3 downto 0);
	result : buffer STD_LOGIC_VECTOR(63 downto 0);
	zero : buffer STD_LOGIC;
	overflow : buffer STD_LOGIC
);
end ALU;

architecture behavioral of ALU is
--signal ifOverflow : std_logic;
signal extensionBit : STD_LOGIC_VECTOR(64 downto 0):= "00000000000000000000000000000000000000000000000000000000000000000";
signal output : STD_LOGIC_VECTOR(63 downto 0):= "0000000000000000000000000000000000000000000000000000000000000000";
component ADD
	port(
		in0 : in STD_LOGIC_VECTOR(63 downto 0);
		in1 : in STD_LOGIC_VECTOR(63 downto 0);
		output : out STD_LOGIC_VECTOR(63 downto 0)
	);
END COMPONENT;
begin
	uut: ADD PORT MAP (
			in0 => in0,
			in1 => in1,
			output => output
			);
	process(in0, in1, operation)
	variable ifOverflow:boolean := false;
	begin
		if (operation = "0000") then --AND
			result <= in0 and in1;
			--if (result = "0000") then
			if (result = X"0000000000000000") then
				zero <= '1';
			else
				zero <= '0';
			end if;
				overflow <= '0';			

		elsif (operation = "0110") then --SUBTRACT
			result <= in0 - in1;
						
--extensionBit <= ('0' & in0) - ('0' & in1);
			--ifOverflow := true;
			--if (result = "0000") then
			--if (result = "0000") then
			if (result = X"0000000000000000") then
				zero <= '1';
			else
				zero <= '0';
			end if;

			if (in0 > result) or (in1 > result) then
				overflow <= '1';
			else
				overflow <= '0';
			end if;
			
			
			--overflow <= (extensionBit(63) xor extensionBit(64));
		elsif (operation = "0111") then --pass input b
			result <= in1; --THIS MIGHT BE WRONG
			
			--if (result = "0000") then
			if (result = X"0000000000000000") then
				zero <= '1';
			else
				zero <= '0';
			end if;
				overflow <= '0';

		elsif (operation = "0001") then --OR
			result <= in0 or in1;
			--if (result = "0000") then
			if (result = X"0000000000000000") then
				zero <= '1';
			else
				zero <= '0';
			end if;
				overflow <= '0';
			--all set

		elsif (operation = "0010") then --ADD
			--result <= output; 
			result <= in0 + in1;
			--previous add statement was used as place holder
			--extensionBit <= ('0' & in0) + ('0' & in1);
			--overflow <= (extensionBit(63) xor extensionBit(64));
			--if (result = "0000") then
			if (result = X"0000000000000000") then
				zero <= '1';
			else
				zero <= '0';
			end if;
			
			if (in0 > result) or (in1 > result) then
				overflow <= '1';
			else
				overflow <= '0';
			end if;
			--ifOverflow := true;

		
		elsif (operation = "1100") then --NOR
			result <= in0 NOR in1;
			--if (result = "0000") then
			if (result = X"0000000000000000") then
				zero <= '1';
			else
				zero <= '0';
			end if;
				overflow <= '0';
		--check for overflow
		--elsif (ifOverflow) then
			--overflow <= (extensionBit(63) xor extensionBit(64));
			--ifOverFlow := false;
		else
			--result if no option for given operation 
			result <= "0000000000000000000000000000000000000000000000000000000000000000";
			--result <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";	
		end if;

		--if result /= X"0000000000000000" then
			--zero <= '0';
		--else
			--zero <= '1';
		--end if;
	end process;
end;