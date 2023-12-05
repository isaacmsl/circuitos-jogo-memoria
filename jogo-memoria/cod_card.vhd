ENTITY cod_card IS
PORT(	enable			: IN BIT;						-- enable
		position   		: IN NATURAL;        			-- natural input
		viradas			: IN BIT_VECTOR(15 DOWNTO 0);	-- cartas viradas
		escolheu		: OUT BIT;						-- duas cartas escolhidas
		pos_a, pos_b   	: OUT NATURAL;  				-- data output
		pos 			: OUT BIT_VECTOR(1 DOWNTO 0);	-- virar carta
		num_card   		: BUFFER BIT; 					-- buffer
		last_pos 		: BUFFER NATURAL				-- ultima posição		
);
END cod_card;

ARCHITECTURE behavior OF cod_card IS
BEGIN
	PROCESS(position, enable)
		BEGIN
		pos <= "11";
		IF ((enable = '1') AND NOT (position-1 = last_pos) AND NOT (position = 0) AND (viradas(position-1) = '0')) THEN
			IF(num_card = '0') THEN
				num_card <= '1';
				escolheu <= '0';
				pos_a <= position-1;
				pos <= "01";
			ELSE 
				num_card <= '0';
				escolheu <= '1';
				pos_b <= position-1;
				pos <= "10";
			END IF;
			last_pos <= position-1;
		ELSE
			IF(enable = '0') THEN
				pos <= "00";
			END IF;
			escolheu <= '0';
			num_card <= num_card;
			last_pos <= last_pos;
		END IF;
	END PROCESS;
END behavior;
		
	