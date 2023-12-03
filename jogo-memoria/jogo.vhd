LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.our_pkg.ALL;

ENTITY jogo IS
    PORT (
        clk  : IN BIT;
        clrn : IN BIT;
        input : IN NATURAL -- tecla selecionada
    );
END jogo;

ARCHITECTURE arch OF jogo IS

COMPONENT maq_estados IS
PORT (
    clk               : IN BIT;                          -- clock
    clrn              : IN BIT;                          -- clear
    escolheu          : IN BIT;                          -- escolheu as duas cartas
    viradas           : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- cartas viradas
    ena_comp          : OUT BIT                          -- enables
);
END COMPONENT;

COMPONENT comp_cartas IS
PORT (
    enable           : IN BIT;                      -- enable
    carta_a, carta_b : IN BIT_VECTOR(2 DOWNTO 0);   -- cartas escolhidas
    result           : OUT BIT                      -- resultado
);
END COMPONENT;

COMPONENT contador IS
    GENERIC (W : NATURAL := 4);
    PORT (
        ena     : IN BIT;                               -- enable
        clk     : IN BIT;                               -- clock
        clrn    : IN BIT;                               -- clear
        d       : IN STD_LOGIC_VECTOR(W-1 DOWNTO 0);    -- data input
        q       : BUFFER STD_LOGIC_VECTOR(W-1 DOWNTO 0) -- data output
    );
END COMPONENT;

COMPONENT manipulador_display IS
PORT (
    cartas_jogo      : IN CARTAS_JOGO;       
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

COMPONENT foo IS
PORT (
    pos_a, pos_b     : IN NATURAL;
    cartas           : CARTAS_JOGO;
    carta_a, carta_b : OUT BIT_VECTOR(2 DOWNTO 0);
    escolheu         : OUT BIT
);
END COMPONENT;

COMPONENT vira_cartas IS 
PORT (
    enable               : IN BIT;
    comp_res             : IN BIT;
    pos_a, pos_b         : IN NATURAL;
    cartas_viradas       : OUT BIT_VECTOR(15 DOWNTO 0)
);
END COMPONENT;

SIGNAL carta_jogo : BIT_VECTOR(2 DOWNTO 0);
SIGNAL carta_virada : BIT_VECTOR(0 DOWNTO 0);

SIGNAL comp_res          : BIT;
SIGNAL ena_comp          : BIT;
SIGNAL escolheu          : BIT;
SIGNAL int               : INTEGER range 0 to 16;
SIGNAL carta_a, carta_b  : BIT_VECTOR(2 DOWNTO 0);
SIGNAL pos_a, pos_b      : NATURAL;
SIGNAL cartas, viradas   : BIT_VECTOR(15 DOWNTO 0);
SIGNAL cont_cartas       : STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL cartas_jogo : CARTAS_JOGO := (
    "001", "001", "010", "011", "101", "110", "111", "100",
    "111", "011", "101", "010", "000", "110", "100", "000"
);

BEGIN
    bar             : foo PORT MAP(pos_a, pos_b, cartas_jogo, carta_a, carta_b, escolheu);
    states          : maq_estados PORT MAP (clk, clrn, escolheu, cont_cartas, ena_comp);
    comp            : comp_cartas PORT MAP (ena_comp, carta_a, carta_b, comp_res);
    vira            : vira_cartas PORT MAP (ena_comp, comp_res, pos_a, pos_b, viradas);
    cont            : contador PORT MAP (comp_res, clk, clrn, "0000", cont_cartas);
    displays        : manipulador_display PORT MAP (cartas_jogo, viradas);
END arch;