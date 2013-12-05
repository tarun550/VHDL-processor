library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;   

entity memory is
port ( 	clock	: 	in std_logic;
		rst		: 	in std_logic;
		Mre		:	in std_logic;
		Mwe		:	in std_logic;
		address	:	in std_logic_vector(7 downto 0);
		data_in	:	in std_logic_vector(15 downto 0);
		data_out:	out std_logic_vector(15 downto 0)
);
end memory;

architecture behv of memory is			

  type ram_type is array (0 to 255) of 
        		std_logic_vector(15 downto 0);
  signal tmp_ram: ram_type;

begin
	

							
	write: process(clock, rst, Mre, address, data_in)
	begin
		if rst='1' then		
			tmp_ram <= (------------------------------------------------------------ 
						-- following instruction for debugging purpose
						-- 0 => "0011001000101011",			   	-- R2 <= #2B
						-- 1 => "0011001100001001",			   	-- R3 <= #09
						-- 2 => "0001001100001010",			   	-- M[A] <= R3
						-- 3 => "0000011000001000",			   	-- R6 <= M[8]
						-- 4 => "0010001100100000",				-- M[R3] <= R2
						-- 5 => "0100001100100000",				-- R3 <= R3 + R2
						-- 6 => "0101001001100000",				-- R2 <= R2 - R6
						-- 7 => "0110000000000000",				-- jz if R0=0
						-- 8 => "1111000000000000",				-- halt	
						-------------------------------------------------------------
						
						-- program to generate 10 fabonacci number	  
							
						0 => "0011000000000000",	   		-- mov R0, #0
						1 => "0011000100000001",			-- mov R1, #1
						2 => "0011001000110100",			-- mov R2, #52
						3 => "0011001100000001",			-- mov R3, #1
						4 => "0001000000110010",			-- mov M[50], R0
						5 => "0001000100110011",			-- mov M[51], R1
						6 => "0001000101100100",			-- mov M[100], R1
						7 => "0100000100000000",			-- add R1, R0
						8 => "0000000001100100",			-- mov M[100], R0
						9 => "0010001000010000",			-- mov M[R2], R1
						10 => "0100001000110000",			-- add R2, R3
						11 => "0000010000111011",			-- mov R4, M[59]
						12 => "0110010000000101",  			-- jz R4, #6
						
						13 => "0111000000110010",			-- output  M[50]
						14 => "0111000000110011",			--		,, M[51]
						15 => "0111000000110100",			--		,, M[52]
						16 => "0111000000110101",			--		,, M[53]
						17 => "0111000000110110",			--		,, M[54]
						18 => "0111000000110111",			--		,, M[55]
						19 => "0111000000111000",			--		,, M[56]
						20 => "0111000000111001",			--		,, M[57]
						21 => "0111000000111010",			--		,, M[58]
						22 => "0111000000111011",			--		,, M[59]
												
						23 => "1111000000000000",			-- halt
						others => "0000000000000000");
		else
			if (clock'event and clock = '1') then
				if (Mwe ='1' and Mre = '0') then
					tmp_ram(conv_integer(address)) <= data_in;
				end if;
			end if;
		end if;
	end process;

    read: process(clock, rst, Mwe, address)
	begin
		if rst='1' then
			data_out <= (others=>'0');
		else
			if (clock'event and clock = '1') then
				if (Mre ='1' and Mwe ='0') then								 
					data_out <= tmp_ram(conv_integer(address));
				end if;
			end if;
		end if;
	end process;
end behv;
