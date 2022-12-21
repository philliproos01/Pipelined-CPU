library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ALUControl is
-- Functionality should match truth table shown in Figure 4.13 in the textbook.
-- Check table on page2 of ISA.pdf on canvas. Pay attention to opcode of operations and type of operations.
-- If an operation doesn?t use ALU, you don?t need to check for its case in the ALU control implemenetation.
-- To ensure proper functionality, you must implement the "don?t-care" values in the funct field,
-- for example when ALUOp = ?00", Operation must be "0010" regardless of what Funct is.
port(
	ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
	Opcode : in STD_LOGIC_VECTOR(10 downto 0);
	Operation : out STD_LOGIC_VECTOR(3 downto 0)
);
end ALUControl;

architecture behavioral of ALUControl is
begin
	process(ALUOp, Opcode)
	begin
		case ALUOp is
			when "00" => operation <= "0010";
			when "01" => operation <= "0111";
			when "10" => 
				case Opcode(10 downto 0) is when "10001011000" => operation <= "0010";
				when "11001011000" => operation <= "0110"; 
				when "10001010000" => operation <= "0000";
				when "10101010000" => operation <= "0010";
				case Opcode(10 downto 1) is when "1001000100" => operation <= "0010";
				when "1011000100" => operation <= "0010";
				--
				when "1001001000" => operation <= "0000";
				when "1111001000" => operation <= "0000";
				--
				when "1011001000" => operation <= "0001";
				
				--
				when "1101000100" => operation <= "0110";
				when "1111000100" => operation <= "0110";
				--
				



				when others => operation <= "0010"; --dont care pt1
			end case;
			when others => operation <= "0010";
		end case;
		when others => operation <= "0010"; --dont care pt2
		end case;
	end process;
end;
