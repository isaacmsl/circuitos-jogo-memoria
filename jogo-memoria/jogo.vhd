LIBRARY IEEE;
USE work.our_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

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

COMPONENT contador IS
    GENERIC (W : NATURAL := 4);
    PORT (
        ena     : IN BIT;                               -- enable
        clk     : IN BIT;                               -- clock
        clrn    : IN BIT;                               -- clear
        q       : BUFFER STD_LOGIC_VECTOR(W-1 DOWNTO 0) -- data output
    );
END COMPONENT;

COMPONENT manipulador_display IS
PORT (
    cartas_jogo_in   : IN CARTAS_JOGO;
    cartas_viradas   : IN BIT_VECTOR(15 DOWNTO 0);
    cartas_visual    : OUT CARTAS_DISPLAY
);
END COMPONENT;

COMPONENT foo IS
PORT (
    pos_a, pos_b     : IN NATURAL;
    cartas           : CARTAS_JOGO;
    carta_a, carta_b : OUT BIT_VECTOR(2 DOWNTO 0)
);
END COMPONENT;

COMPONENT vira_cartas IS 
PORT (
    clrn                 : IN BIT;
    clk                  : IN BIT;
    comp_res             : IN BIT;
    pos_a, pos_b         : IN NATURAL;
    pos                  : IN BIT_VECTOR(1 DOWNTO 0);
    cartas_viradas       : OUT BIT_VECTOR(15 DOWNTO 0)
);
END COMPONENT;

COMPONENT cod_card IS
PORT(   enable			: IN BIT;						-- enable
		position   		: IN NATURAL;        			-- natural input
		viradas			: IN BIT_VECTOR(15 DOWNTO 0);	-- cartas viradas
		escolheu		: OUT BIT;						-- duas cartas escolhidas
		pos_a, pos_b   	: OUT NATURAL;  				-- data output
		pos 			: OUT BIT_VECTOR(1 DOWNTO 0);	-- virar carta
		num_card   		: BUFFER BIT; 					-- buffer
		last_pos 		: BUFFER NATURAL				-- ultima posição
);
END COMPONENT;

SIGNAL buf                      : BIT;
SIGNAL comp_res                 : BIT;
SIGNAL escolheu                 : BIT;
SIGNAL ena_comp, ena_cod        : BIT;
SIGNAL pos_a, pos_b, last_pos   : NATURAL;
SIGNAL pos                      : BIT_VECTOR(1 DOWNTO 0);
SIGNAL carta_a, carta_b         : BIT_VECTOR(2 DOWNTO 0);
SIGNAL viradas                  : BIT_VECTOR(15 DOWNTO 0);
SIGNAL cont_cartas              : STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL cartas_jogo : CARTAS_JOGO := (
    "001", "001", "010", "011", "101", "110", "111", "100",
    "111", "011", "101", "010", "000", "110", "100", "000"
);
SIGNAL cartas_display : CARTAS_DISPLAY;

BEGIN
    bar             : foo PORT MAP (pos_a, pos_b, cartas_jogo, carta_a, carta_b);
    states          : maq_estados PORT MAP (clk, clrn, escolheu, cont_cartas, ena_comp, ena_cod);
    comp            : comp_cartas PORT MAP (ena_comp, carta_a, carta_b, comp_res);
    vira            : vira_cartas PORT MAP (clrn, clk, comp_res, pos_a, pos_b, pos, viradas);
    cont            : contador PORT MAP (comp_res, clk, clrn, cont_cartas);
    displays        : manipulador_display PORT MAP (cartas_jogo, viradas, cartas_display);
    cod             : cod_card PORT MAP (ena_cod, input, viradas, escolheu, pos_a, pos_b, pos, buf, last_pos);
END arch;