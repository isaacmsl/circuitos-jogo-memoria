USE work.our_pkg.ALL;

ENTITY foo IS
PORT (
    pos_a, pos_b     : IN NATURAL;
    cartas           : CARTAS_JOGO;
    carta_a, carta_b : OUT BIT_VECTOR(2 DOWNTO 0)
);
END foo;

ARCHITECTURE arch OF foo IS
BEGIN
    PROCESS(pos_a, pos_b)
    BEGIN   
            carta_a <= cartas(pos_a);
            carta_b <= cartas(pos_b);
    END PROCESS;
END arch;