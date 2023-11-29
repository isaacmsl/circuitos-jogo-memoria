LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;


ENTITY cod_card IS
PORT(	position    : IN INTEGER range 0 to 16;         -- decimal input
	card_selected   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)  -- data output
);
END cod_card;

ARCHITECTURE behavior OF cod_card IS
BEGIN
	PROCESS(position)
		BEGIN
		CASE position-1 IS
			WHEN 0 => card_selected <= "0000";
			WHEN 1 => card_selected <= "0001";
			WHEN 2 => card_selected <= "0010";
			WHEN 3 => card_selected <= "0011";
			WHEN 4 => card_selected <= "0100";
			WHEN 5 => card_selected <= "0101";
			WHEN 6 => card_selected <= "0110";
			WHEN 7 => card_selected <= "0111";
			WHEN 8 => card_selected <= "1000";
               		WHEN 9 => card_selected <= "1001";
                	WHEN 10 => card_selected <= "1010";
                	WHEN 11 => card_selected <= "1011";
                	WHEN 12 => card_selected <= "1100";
                	WHEN 13 => card_selected <= "1101";
                	WHEN 14 => card_selected <= "1110";
                	WHEN OTHERS => card_selected <= "1111";
		END CASE;
	END PROCESS;
END behavior;
		
	