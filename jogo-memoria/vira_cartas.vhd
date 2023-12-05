USE work.our_pkg.ALL;

ENTITY vira_cartas IS 
PORT (
    clrn                 : IN BIT;
    clk                  : IN BIT;
    comp_res             : IN BIT;
    pos_a, pos_b         : IN NATURAL;
    pos                  : IN BIT_VECTOR(1 DOWNTO 0);
    cartas_viradas       : OUT BIT_VECTOR(15 DOWNTO 0)
);
END vira_cartas;

ARCHITECTURE arch OF vira_cartas IS
BEGIN
    PROCESS (pos, comp_res, clrn, clk)
    BEGIN
        IF(clrn = '0') THEN
            cartas_viradas <= (OTHERS => clk); 
        ELSE 
            IF (pos = "01") THEN
                cartas_viradas(pos_a) <= '1';
            ELSIF (pos = "10") THEN
                cartas_viradas(pos_b) <= '1';
            ELSIF (pos = "00") THEN
                cartas_viradas(pos_a) <= comp_res;
                cartas_viradas(pos_b) <= comp_res;
            END IF;
        END IF;
    END PROCESS;
END arch;