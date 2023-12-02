LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY dec_display IS
PORT (	enable		: IN BIT; 
		card		: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		display		: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);
END dec_display;

ARCHITECTURE behavior OF dec_display IS
BEGIN
	PROCESS(enable, card)
		BEGIN
			IF (enable = '1') THEN
				CASE card IS
					WHEN "000" => display <= "1000010";
					WHEN "001" => display <= "1001001";
					WHEN "010" => display <= "0100101";
					WHEN "011" => display <= "1001010";
					WHEN "100" => display <= "0111000";
					WHEN "101" => display <= "0011101";
					WHEN "110" => display <= "0110110";
					WHEN "111" => display <= "0011000";
					WHEN OTHERS => display <= "0000000";
				END CASE;
			else
				display <= "1111111";
			END IF;
	END PROCESS;
END behavior;
