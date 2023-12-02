ENTITY memoria_ram IS
    PORT (
        addr        : IN NATURAL RANGE 0 TO 15; -- access to 16 cards
        data_in     : IN BIT_VECTOR(2 DOWNTO 0); -- card
        enable_wr   : IN BIT;
        clk         : IN BIT;
        data_out    : OUT BIT_VECTOR(2 DOWNTO 0)
    );
END memoria_ram;


ARCHITECTURE arch OF memoria_ram IS
    TYPE MEMORY IS ARRAY (0 to 15) OF BIT_VECTOR(2 DOWNTO 0);
    SIGNAL mem : MEMORY := (others => (others => '0'));

    BEGIN
        PROCESS (clk)
        BEGIN
            IF (rising_edge(clk)) THEN
                IF (enable_wr = '1') THEN -- WRITE
                    mem(addr) <= data_in;
                END IF;
            END IF;
        END PROCESS;

        data_out <= mem(addr);
END arch;
