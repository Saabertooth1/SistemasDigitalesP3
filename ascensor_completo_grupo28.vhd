LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY ascensor_completo IS
PORT
	(
	clk : IN STD_LOGIC;
	reset: IN STD_LOGIC;
	botones : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	sube, baja : OUT STD_LOGIC;
	piso_donde_esta : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
	);
END ascensor_completo;

ARCHITECTURE arquitectura_ascensor_completo OF ascensor_completo IS

SIGNAL CTOCODIGOPOISO : STD_LOGIC_VECTOR (1 DOWNTO 0);

COMPONENT FSM_ascensor IS
PORT
	(
	clk : IN STD_LOGIC;
	reset: IN STD_LOGIC;
	codigo_piso : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	sube, baja : OUT STD_LOGIC;
	piso_donde_esta : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT codifica_boton IS
PORT
	(
	B : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	C : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
END COMPONENT;

BEGIN

ascen: FSM_ascensor
PORT MAP
	(
	clk => clk,
	reset => reset,
	codigo_piso => CTOCODIGOPOISO,
	sube => sube, 
	baja => baja, 
	piso_donde_esta => piso_donde_esta,
	)
codificador: codifica_boton
PORT MAP
	(
	B => botones
	C => CTOCODIGOPOISO
	