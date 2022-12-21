library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;


entity SignExtend is
	port(
		x : in STD_LOGIC_VECTOR(31 downto 0);
		y : out STD_LOGIC_VECTOR(63 downto 0) -- sign-extend(x)

	);
end SignExtend;

architecture behavioral of SignExtend is

--different instructions from asm require different extensions
begin
	--y <= std_logic_vector(resize(signed(x), y'length));
	process(x)
		begin
		--if x(31)='1' then
			--y(31 downto 0) <= x;
			--y(63 downto 32) <= x"FFFFFFFF";
		--else
			--y(31 downto 0) <= x;
			--y(63 downto 32) <= x"00000000";
		--end if;
--
--

--
--
		if x(21) = '0' and x(27 downto 24) = "1000" then
			y <= std_logic_vector(resize(signed(x(20 downto 12)), y'length));
		
		elsif x(31 downto 24) = "10110100" then
			y <= std_logic_vector(resize(signed(x(23 downto 5)), y'length));
		--
		elsif x(31 downto 26) = "000101" then
			y <= std_logic_vector(resize(signed(x(25 downto 0)), y'length));
		
		--
		elsif (x(28 downto 26) = "100") and (x(23 downto 22) = "00") and (x(31) = '1') then
			y <= std_logic_vector(resize(signed(x(21 downto 10)), y'length));
		else
			y(63 downto 32) <= x"00000000";
			y(31 downto 0) <= x;
		end if;
	end process;
end;
