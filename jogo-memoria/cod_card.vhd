ENTITY cod_card IS
PORT(	enable			: IN BIT;						-- enable
		position   		: IN NATURAL;        			-- natural input
		escolheu		: OUT BIT;						-- duas cartas escolhidas
		pos_a, pos_b   	: OUT NATURAL;  				-- data output
		num_card   		: BUFFER BIT; 					-- buffer
		last_pos 		: BUFFER NATURAL				-- ultima posição		
);
END cod_card;

ARCHITECTURE behavior OF cod_card IS
BEGIN
	PROCESS(position, enable)
		BEGIN
		IF ((enable = '1') AND NOT (position = last_pos)) THEN
			IF(num_card = '0') THEN
				num_card <= '1';
				pos_a <= position;
				escolheu <= '0';
			ELSE 
				num_card <= '0';
				pos_b <= position;
				escolheu <= '1';
			END IF;
			last_pos <= position;
		ELSE
			num_card <= num_card;
			last_pos <= last_pos;
			escolheu <= '0';
		END IF;
	END PROCESS;
END behavior;
		
	