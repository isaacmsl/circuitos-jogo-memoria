LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY maq_estados IS
PORT (
    clk     : IN BIT;                           -- clock
    clrn    : IN BIT;                           -- clear
    escolheu : IN BIT;                          -- escolheu as duas cartas
    viradas : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  -- cartas viradas
    ena_comp, ena_cod : OUT BIT                 -- enables
);
END maq_estados;

ARCHITECTURE arch OF maq_estados IS
TYPE state_type IS (espera, comparacao, fim);

SIGNAL state_reg    : state_type;
SIGNAL next_state   : state_type;

BEGIN
p_state_reg : PROCESS (clk, state_reg, clrn)
    BEGIN
        IF (clrn = '0') THEN
            state_reg <= espera;
        ELSE
            state_reg <= next_state;
        END IF;
    END PROCESS;

p_next_state : PROCESS (state_reg, viradas, escolheu)
    BEGIN
        CASE (state_reg) IS
            WHEN espera =>
                IF (viradas = "1000") THEN
                    next_state <= fim;
                ELSIF (escolheu = '1') THEN
                    next_state <= comparacao;
                END IF;
            WHEN OTHERS =>
                next_state <= espera;
        END CASE;
    END PROCESS;

-- OUTPUT
p_output : PROCESS (state_reg)
    BEGIN
        ena_comp <= '0';
        ena_cod <= '1';
        IF (state_reg = comparacao) THEN
            ena_comp <= '1';
            ena_cod <= '0';
        END IF;
    END PROCESS;
END arch;