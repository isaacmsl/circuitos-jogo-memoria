ENTITY jogo IS
    PORT (
        clk : IN BIT
    );
END jogo;

ARCHITECTURE arch OF jogo IS

COMPONENT memoria_ram IS
    GENERIC (
        addr_size    : INTEGER := 16;
        data_size    : INTEGER := 3
    );
    PORT (
        addr        : IN NATURAL RANGE 0 TO addr_size - 1; -- access to 16 cards
        data_in     : IN BIT_VECTOR(data_size - 1 DOWNTO 0); -- card
        enable_wr   : IN BIT;
        clk         : IN BIT;
        data_out    : OUT BIT_VECTOR(data_size - 1 DOWNTO 0)
    );
END COMPONENT;

SIGNAL carta_jogo : BIT_VECTOR(2 DOWNTO 0);
SIGNAL carta_virada : BIT_VECTOR(0 DOWNTO 0);

BEGIN
    cartas_jogo     : memoria_ram PORT MAP (0, "000", '0', clk, carta_jogo);
    cartas_viradas  : memoria_ram GENERIC MAP (16, 1) PORT MAP (0, "0", '0', clk, carta_virada);
END arch;