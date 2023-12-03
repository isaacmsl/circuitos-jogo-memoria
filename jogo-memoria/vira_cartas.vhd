USE work.our_pkg.ALL;

ENTITY vira_cartas IS 
PORT (
    enable               : IN BIT;
    comp_res             : IN BIT;
    pos_a, pos_b         : IN NATURAL;
    cartas_viradas       : OUT BIT_VECTOR(15 DOWNTO 0)
);
END vira_cartas;

ARCHITECTURE arch OF vira_cartas IS
BEGIN
    PROCESS (enable)
    BEGIN
        IF (enable = '1') THEN
            cartas_viradas(pos_a) <= comp_res;
            cartas_viradas(pos_b) <= comp_res;
        END IF;
    END PROCESS;
END arch;