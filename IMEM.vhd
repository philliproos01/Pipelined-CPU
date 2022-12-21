
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL; 

--entity IMEM is
-- The instruction memory is a byte addressable, little-endian, read-only memory
-- Reads occur continuously
-- HINT: Use the provided dmem.vhd as a starting point
generic(NUM_BYTES : integer := 128);
-- NUM_BYTES is the number of bytes in the memory (small to save computation resources)
port(
	Address : in STD_LOGIC_VECTOR(63 downto 0); -- Address to read from
	ReadData : out STD_LOGIC_VECTOR(31 downto 0)
);
end IMEM;

architecture behavioral of IMEM is
type ByteArray is array (0 to NUM_BYTES) of STD_LOGIC_VECTOR(7 downto 0); 
signal memBytes:ByteArray;
begin
	
	process(Address)
	variable checkInstruct:boolean := true; --boolean checkInstruct := true;
	begin
		if (checkInstruct) then
			memBytes(0) <= "00111111";
			memBytes(1) <= "00000000";
			memBytes(2) <= "00000000";
			memBytes(3) <= "00000000";
			memBytes(7) <= "10001011";
      			memBytes(6) <= "00001011";
      			memBytes(5) <= "00000001";
      			memBytes(4) <= "00101010";
			memBytes(8) <= "00000000";
			memBytes(	9	)  <= "00000000";
			

memBytes(	10	)  <= "00000000";
memBytes(	11	)  <= "00000000";
memBytes(	12	)  <= "00000000";
memBytes(	13	)  <= "00000000";
memBytes(	14	)  <= "00000000";
memBytes(	15	)  <= "00000000";
memBytes(	16	)  <= "00000000";
memBytes(	17	)  <= "00000000";
memBytes(	18	)  <= "00000000";
memBytes(	19	)  <= "00000000";
memBytes(	20	)  <= "00000000";
memBytes(	21	)  <= "00000000";
memBytes(	22	)  <= "00000000";
memBytes(	23	)  <= "00000000";
memBytes(	24	)  <= "00000000";
memBytes(	25	)  <= "00000000";
memBytes(	26	)  <= "00000000";
memBytes(	27	)  <= "00000000";
memBytes(	28	)  <= "00000000";
memBytes(	29	)  <= "00000000";
memBytes(	30	)  <= "00000000";
memBytes(	31	)  <= "00000000";
memBytes(	32	)  <= "00000000";
memBytes(	33	)  <= "00000000";
memBytes(	34	)  <= "00000000";
memBytes(	35	)  <= "00000000";
memBytes(	36	)  <= "00000000";
memBytes(	37	)  <= "00000000";
memBytes(	38	)  <= "00000000";
memBytes(	39	)  <= "00000000";
memBytes(	40	)  <= "00000000";
memBytes(	41	)  <= "00000000";
memBytes(	42	)  <= "00000000";
memBytes(	43	)  <= "00000000";
memBytes(	44	)  <= "00000000";
memBytes(	45	)  <= "00000000";
memBytes(	46	)  <= "00000000";
memBytes(	47	)  <= "00000000";
memBytes(	48	)  <= "00000000";
memBytes(	49	)  <= "00000000";
memBytes(	50	)  <= "00000000";
memBytes(	51	)  <= "00000000";
memBytes(	52	)  <= "00000000";
memBytes(	53	)  <= "00000000";
memBytes(	54	)  <= "00000000";
memBytes(	55	)  <= "00000000";
memBytes(	56	)  <= "00000000";
memBytes(	57	)  <= "00000000";
memBytes(	58	)  <= "00000000";
memBytes(	59	)  <= "00000000";
memBytes(	60	)  <= "00000000";
memBytes(	61	)  <= "00000000";
memBytes(	62	)  <= "00000000";
memBytes(	63	)  <= "00000000";
memBytes(	64	)  <= "00000000";
memBytes(	65	)  <= "00000000";
memBytes(	66	)  <= "00000000";
memBytes(	67	)  <= "00000000";
memBytes(	68	)  <= "00000000";
memBytes(	69	)  <= "00000000";
memBytes(	70	)  <= "00000000";
memBytes(	71	)  <= "00000000";
memBytes(	72	)  <= "00000000";
memBytes(	73	)  <= "00000000";
memBytes(	74	)  <= "00000000";
memBytes(	75	)  <= "00000000";
memBytes(	76	)  <= "00000000";
memBytes(	77	)  <= "00000000";
memBytes(	78	)  <= "00000000";
memBytes(	79	)  <= "00000000";
memBytes(	80	)  <= "00000000";
memBytes(	81	)  <= "00000000";
memBytes(	82	)  <= "00000000";
memBytes(	83	)  <= "00000000";
memBytes(	84	)  <= "00000000";
memBytes(	85	)  <= "00000000";
memBytes(	86	)  <= "00000000";
memBytes(	87	)  <= "00000000";
memBytes(	88	)  <= "00000000";
memBytes(	89	)  <= "00000000";
memBytes(	90	)  <= "00000000";
memBytes(	91	)  <= "00000000";
memBytes(	92	)  <= "00000000";
memBytes(	93	)  <= "00000000";
memBytes(	94	)  <= "00000000";
memBytes(	95	)  <= "00000000";
memBytes(	96	)  <= "00000000";
memBytes(	97	)  <= "00000000";
memBytes(	98	)  <= "00000000";
memBytes(	99	)  <= "00000000";
memBytes(	100	)  <= "00000000";
memBytes(	101	)  <= "00000000";
memBytes(	102	)  <= "00000000";
memBytes(	103	)  <= "00000000";
memBytes(	104	)  <= "00000000";
memBytes(	105	)  <= "00000000";
memBytes(	106	)  <= "00000000";
memBytes(	107	)  <= "00000000";
memBytes(	108	)  <= "00000000";
memBytes(	109	)  <= "00000000";
memBytes(	110	)  <= "00000000";
memBytes(	111	)  <= "00000000";
memBytes(	112	)  <= "00000000";
memBytes(	113	)  <= "00000000";
memBytes(	114	)  <= "00000000";
memBytes(	115	)  <= "00000000";
memBytes(	116	)  <= "00000000";
memBytes(	117	)  <= "00000000";
memBytes(	118	)  <= "00000000";
memBytes(	119	)  <= "00000000";
memBytes(	120	)  <= "00000000";
memBytes(	121	)  <= "00000000";
memBytes(	122	)  <= "00000000";
memBytes(	123	)  <= "00000000";
memBytes(	124	)  <= "00000000";
memBytes(	125	)  <= "00000000";
memBytes(	126	)  <= "00000000";
memBytes(	127	)  <= "00000000";

			checkInstruct := false;
		end if;
	end process;
	ReadData <= memBytes(to_integer(unsigned(Address))) & memBytes(to_integer(unsigned(Address)) + 1) & memBytes(to_integer(unsigned(Address)) + 2) & memBytes(to_integer(unsigned(Address)) + 3) ;--& memBytes(to_integer(unsigned(Address)) + 4) & memBytes(to_integer(unsigned(Address)) + 5) ;
end;
