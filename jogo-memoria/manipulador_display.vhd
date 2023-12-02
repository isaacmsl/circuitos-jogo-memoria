ENTITY manipulador_display IS
PORT (
    cartas_jogo      : IN BIT_VECTOR(15 DOWNTO 0);       
    cartas_viradas   : IN BIT_VECTOR(15 DOWNTO 0)
);
END manipulador_display;

ARCHITECTURE arch OF manipulador_display IS
    COMPONENT dec_display
    PORT (
        enable		: IN BIT; 
        card		: IN BIT_VECTOR(2 DOWNTO 0);
        display		: OUT BIT_VECTOR(6 DOWNTO 0)
    );
    END COMPONENT;

    SIGNAL s0, s1, s2, s3, s4, s5, s6, s7 : BIT_VECTOR(6 DOWNTO 0);
    SIGNAL s8, s9, s10, s11, s12, s13, s14, s15 : BIT_VECTOR(6 DOWNTO 0);
    
    BEGIN
        d0 : dec_display PORT MAP (cartas_viradas(0), "000", s0);
        d1 : dec_display PORT MAP (cartas_viradas(1), "000", s1);
        d2 : dec_display PORT MAP (cartas_viradas(2), "000", s2);
        d3 : dec_display PORT MAP (cartas_viradas(3), "000", s3);
        d4 : dec_display PORT MAP (cartas_viradas(4), "000", s4);
        d5 : dec_display PORT MAP (cartas_viradas(5), "000", s5);
        d6 : dec_display PORT MAP (cartas_viradas(6), "000", s6);
        d7 : dec_display PORT MAP (cartas_viradas(7), "000", s7);
        d8 : dec_display PORT MAP (cartas_viradas(8), "000", s8);
        d9 : dec_display PORT MAP (cartas_viradas(9), "000", s9);
        d10 : dec_display PORT MAP (cartas_viradas(10), "000", s10);
        d11 : dec_display PORT MAP (cartas_viradas(11), "000", s11);
        d12 : dec_display PORT MAP (cartas_viradas(12), "000", s12);
        d13 : dec_display PORT MAP (cartas_viradas(13), "000", s13);
        d14 : dec_display PORT MAP (cartas_viradas(14), "000", s14);
        d15 : dec_display PORT MAP (cartas_viradas(15), "000", s15);
END arch;