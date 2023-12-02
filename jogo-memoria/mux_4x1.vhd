ENTITY mux_4x1 IS
PORT (
    a, b, c, d : IN BIT;                    -- data input
    sel        : IN BIT_VECTOR(1 DOWNTO 0); -- selector
    s          : OUT BIT                    -- output
);
END mux_4x1;

ARCHITECTURE arch OF mux_4x1 IS
BEGIN
    PROCESS (a, b, c, d, sel)
    BEGIN
        CASE sel IS
            WHEN "00" => s <= a;
            WHEN "01" => s <= b;
            WHEN "10" => s <= c;
            WHEN "11" => s <= d;
        END CASE;
    END PROCESS;
END arch;