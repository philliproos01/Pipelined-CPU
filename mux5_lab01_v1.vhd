library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity MUX5 is -- Two by one mux with 5 bit inputs/outputs
	port(
		in0 : in STD_LOGIC_VECTOR(4 downto 0); -- sel == 0
		in1 : in STD_LOGIC_VECTOR(4 downto 0); -- sel == 1
		sel : in STD_LOGIC; -- selects in0 or in1
		output : out STD_LOGIC_VECTOR(4 downto 0)
	);
end MUX5;

architecture behavioral of MUX5 is 
begin
	process(sel, in0, in1)
	begin
		if sel = '1' then
			output <= in1;
		else
			output <= in0;
		end if;
	end process;
end;
