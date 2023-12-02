ENTITY memoria_ram IS
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
END memoria_ram;


ARCHITECTURE arch OF memoria_ram IS
    TYPE MEMORY IS ARRAY (0 to addr_size - 1) OF BIT_VECTOR(data_size - 1 DOWNTO 0);
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
