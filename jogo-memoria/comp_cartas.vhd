LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY comp_cartas IS
PORT (
    carta_a, carta_b : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    enable : IN BIT;
    result : OUT BIT
);
END comp_cartas;

ARCHITECTURE arch OF comp_cartas IS
BEGIN
    PROCESS(carta_a, carta_b, enable)
    BEGIN
        IF (enable = '1') THEN
            IF (carta_a = carta_b) THEN
                result <= '1';
            ELSE
                result <= '0';
            END IF;
        ELSE
            result <= '0';
        END IF;
    END PROCESS;
END arch;