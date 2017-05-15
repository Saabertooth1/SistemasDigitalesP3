LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY FSM_ascensor IS PORT (
        clk: IN STD_LOGIC;
        reset: IN STD_LOGIC; 
        codigo_piso: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        sube, baja: OUT STD_LOGIC;
        piso_donde_esta: OUT STD_LOGIC_VECTOR (1 DOWNTO 0));
END FSM_ascensor; 

ARCHITECTURE FSM_arquitectura OF FSM_ascensor IS
	TYPE estados IS (Piso_0,Piso_1,Piso_2);
	SIGNAL e_actual, e_futuro: estados;
BEGIN
	PROCESS(e_actual, codigo_piso)
	BEGIN
		CASE e_actual IS
			WHEN Piso_0 =>
                                piso_donde_esta<="00";
				IF codigo_piso = "01" THEN 
					e_futuro<= Piso_1;
                                        sube<= '1';
                                        baja<= '0';
                                ELSIF codigo_piso = "10" THEN
                                        e_futuro<=Piso_2;
                                        sube<= '1';
                                        baja<= '0';
				ELSE
					e_futuro<= Piso_0;
                                        sube<= '0';
                                        baja<= '0';
				END IF;
	                  
			WHEN Piso_1 =>
                                piso_donde_esta<="01";
				IF codigo_piso = "10" THEN
					e_futuro<= Piso_2;
                                        sube<= '1';
                                        baja<= '0';
				ELSIF codigo_piso = "00" THEN
					e_futuro<= Piso_0;
                                        sube<= '0';
                                        baja<= '1';
                                ELSE 
                                        e_futuro<=Piso_1;
                                        sube<= '0';
                                        baja<= '0';
				END IF;
			             
			WHEN Piso_2 =>
                                piso_donde_esta<="10";
                                IF codigo_piso = "01" THEN
				        e_futuro<= Piso_1;
                                        sube<= '0';
                                        baja<= '1';
                                ELSIF codigo_piso = "00" THEN
				        e_futuro<= Piso_0;
                                        sube<= '0';
                                        baja<= '1';
                                ELSE
                                        e_futuro<= Piso_2;
                                        sube<= '0';
                                        baja<= '0';
                                END IF;
		END CASE;	
	END PROCESS;


	PROCESS
	BEGIN
		WAIT UNTIL (rising_edge(clk) OR reset='0');
		IF (reset= '0') THEN
			e_actual<= Piso_0;
		ELSE
			e_actual<= e_futuro;
		END IF;
	END PROCESS;

END FSM_arquitectura;