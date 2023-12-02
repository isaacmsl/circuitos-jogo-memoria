ENTITY comp_cartas IS
PORT (
    enable           : IN BIT;                      -- enable
    carta_a, carta_b : IN BIT_VECTOR(2 DOWNTO 0);   -- cartas escolhidas
    result           : OUT BIT                      -- resultado
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