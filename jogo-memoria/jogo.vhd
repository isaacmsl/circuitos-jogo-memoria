LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY jogo IS
    PORT (
        clk  : IN BIT;
        clrn : IN BIT
    );
END jogo;

ARCHITECTURE arch OF jogo IS

COMPONENT maq_estados IS
PORT (
    clk               : IN BIT;                          -- clock
    clrn              : IN BIT;                          -- clear
    escolheu          : IN BIT;                          -- escolheu as duas cartas
    viradas           : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- cartas viradas
    ena_comp, ena_cod : OUT BIT                          -- enables
);
END COMPONENT;

COMPONENT comp_cartas IS
PORT (
    enable           : IN BIT;                      -- enable
    carta_a, carta_b : IN BIT_VECTOR(2 DOWNTO 0);   -- cartas escolhidas
    result           : OUT BIT                      -- resultado
);
END COMPONENT;

COMPONENT cod_card IS
PORT(	enable		    : IN BIT;							-- enable
        position        : IN INTEGER range 0 to 16;         -- decimal input
	    card_selected   : OUT BIT_VECTOR(3 DOWNTO 0)        -- data output
);
END COMPONENT;

COMPONENT contador IS
    GENERIC (W : NATURAL := 4);
    PORT (
        ena     : IN BIT;                               -- enable
        clk     : IN BIT;                               -- clock
        clrn    : IN BIT;                               -- clear
        load    : IN BIT;                               -- load
        d       : IN STD_LOGIC_VECTOR(W-1 DOWNTO 0);    -- data input
        q       : BUFFER STD_LOGIC_VECTOR(W-1 DOWNTO 0) -- data output
    );
END COMPONENT;

COMPONENT manipulador_display IS
PORT (
    cartas_jogo      : IN BIT_VECTOR(15 DOWNTO 0);       
    cartas_viradas   : IN BIT_VECTOR(15 DOWNTO 0)
);
END COMPONENT;

COMPONENT memoria_ram IS
    GENERIC (
        addr_size    : INTEGER := 16;
        data_size    : INTEGER := 3
    );
    PORT (
        addr        : IN NATURAL RANGE 0 TO addr_size - 1;   -- access to 16 cards
        data_in     : IN BIT_VECTOR(data_size - 1 DOWNTO 0); -- card
        enable_wr   : IN BIT;
        clk         : IN BIT;
        data_out    : OUT BIT_VECTOR(data_size - 1 DOWNTO 0)
    );
END COMPONENT;


SIGNAL carta_jogo : BIT_VECTOR(2 DOWNTO 0);
SIGNAL carta_virada : BIT_VECTOR(0 DOWNTO 0);

SIGNAL comp_res          : BIT;
SIGNAL ena_comp, ena_cod : BIT;
SIGNAL int               : INTEGER range 0 to 16;
SIGNAL pos_a, pos_b      : BIT_VECTOR(3 DOWNTO 0);
SIGNAL cartas, viradas   : BIT_VECTOR(15 DOWNTO 0);
SIGNAL carta_a, carta_b  : BIT_VECTOR(2 DOWNTO 0);
SIGNAL cont_cartas       : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    cartas_jogo     : memoria_ram PORT MAP (0, "000", '0', clk, carta_jogo);
    cartas_viradas  : memoria_ram GENERIC MAP (16, 1) PORT MAP (0, "0", '0', clk, carta_virada);
    states          : maq_estados PORT MAP (clk, clrn, '0', cont_cartas, ena_comp, ena_cod);
    comp            : comp_cartas PORT MAP ( ena_comp, carta_a, carta_b, comp_res);
    cod             : cod_card PORT MAP (ena_cod, int, pos_a);
    cont            : contador PORT MAP (comp_res, clk, clrn, comp_res, "000", cont_cartas);
    displays        : manipulador_display PORT MAP (cartas, viradas);

END arch;