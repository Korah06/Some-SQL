
CREATE TABLE gran_premio (
    id VARCHAR(2),
    nombre VARCHAR(50),
	pais VARCHAR(30),
    PRIMARY KEY (id)
);

CREATE TABLE coche (
    modelo VARCHAR(4),
    coste NUMERIC(11,2),
    PRIMARY KEY (modelo)
);


CREATE TABLE director_tecnico (
    dni VARCHAR(9),
    nombre VARCHAR(30),
	apellido VARCHAR(30),
	sueldo NUMERIC(7,2),
	telefono VARCHAR(9),
    PRIMARY KEY (dni)
);

CREATE TABLE mecanicos (
    dni VARCHAR(9),
    nombre VARCHAR(30),
	apellido VARCHAR(30),
	telefono VARCHAR(9),
	dni_dt VARCHAR(9),
    sueldo NUMERIC(9,2),
    PRIMARY KEY (dni),
    FOREIGN KEY (dni_dt) REFERENCES director_tecnico(dni)
);

CREATE TABLE m_reglaje (
    dni VARCHAR(9),
    PRIMARY KEY (dni),
    FOREIGN KEY (dni) REFERENCES mecanicos(dni)
);

CREATE TABLE m_carrera (
    dni VARCHAR(9),
	funcion VARCHAR(30),
    PRIMARY KEY (dni),
    FOREIGN KEY (dni) REFERENCES mecanicos(dni)
);

CREATE TABLE ingeniero_carrera (
    dni VARCHAR(9),
    PRIMARY KEY (dni),
    FOREIGN KEY (dni) REFERENCES mecanicos(dni)
);



CREATE TABLE pilotos (
    dni VARCHAR(9),
    nombre VARCHAR(30),
	apellido VARCHAR(30),
	telefono VARCHAR(9),
	sueldo NUMERIC(10,2),
	apodo VARCHAR(20),
	numero VARCHAR(2),
	dni_dt VARCHAR(9),
	n_sanciones NUMERIC(2),
    PRIMARY KEY (dni),
    FOREIGN KEY (dni_dt) REFERENCES director_tecnico(dni)
);


CREATE TABLE piezas(
id VARCHAR(5),
nombre VARCHAR(20),
coste NUMERIC(9,2),
n_piezas NUMERIC(2),
n_sanciones NUMERIC(2),
PRIMARY KEY (id)
);

CREATE TABLE ruedas (
    nombre VARCHAR(2),
    tipo VARCHAR(10),
	durabilidad VARCHAR(10),
    PRIMARY KEY (nombre)
);

CREATE TABLE sancion (
    id VARCHAR(2),
    sancion VARCHAR(100),
	descripcion VARCHAR(100),
    PRIMARY KEY (id)
);


CREATE TABLE sancionar_piezas(
piez_id VARCHAR(5),
sancion_id VARCHAR(2),
PRIMARY KEY (piez_id,sancion_id),
CONSTRAINT FK_sancionar_piez1 FOREIGN KEY (piez_id) REFERENCES piezas(id),
CONSTRAINT FK_sancionar_piez2 FOREIGN KEY (sancion_id) REFERENCES sancion(id)
);

CREATE TABLE cambiar_ruedas(
dni_m VARCHAR(9),
gp_id VARCHAR(2),
r_nombre VARCHAR(2),
PRIMARY KEY (dni_m,gp_id,r_nombre),
CONSTRAINT FK_cambiarRuedas1 FOREIGN KEY (dni_m) REFERENCES m_carrera(dni),
CONSTRAINT FK_cambiarRuedas2 FOREIGN KEY (gp_id) REFERENCES gran_premio(id),
CONSTRAINT FK_cambiarRuedas3 FOREIGN KEY (r_nombre) REFERENCES ruedas(nombre)
);


CREATE TABLE reglar(
    dni VARCHAR(9),
    modelo VARCHAR(4),
    PRIMARY KEY (dni,modelo),
    CONSTRAINT FK_reglar1 FOREIGN KEY (dni) REFERENCES m_reglaje(dni),
    CONSTRAINT FK_reglar2 FOREIGN KEY (modelo) REFERENCES coche(modelo)
);

CREATE TABLE formar(
    id VARCHAR(5),
    modelo VARCHAR(4),
    PRIMARY KEY (id,modelo),
    CONSTRAINT FK_formar1 FOREIGN KEY (id) REFERENCES piezas(id),
    CONSTRAINT FK_formar2 FOREIGN KEY (modelo) REFERENCES coche(modelo)
);

CREATE TABLE participar(
    dni VARCHAR(9),
    id VARCHAR(2),
    p_salida NUMERIC(2) CHECK (p_salida <=20),
    puntos NUMERIC(2),
    p_fin NUMERIC(2),
    PRIMARY KEY (dni,id),
    CONSTRAINT FK_participar1 FOREIGN KEY (id) REFERENCES gran_premio(id),
    CONSTRAINT FK_participar2 FOREIGN KEY (dni) REFERENCES pilotos(dni)
);

CREATE TABLE accidente (
    id VARCHAR(2),
    causa VARCHAR(50),
	id_p VARCHAR(2),
	dni VARCHAR(9),
    PRIMARY KEY (id),
CONSTRAINT FK_accidente FOREIGN KEY (dni,id_p) REFERENCES participar(dni,id)
);

CREATE TABLE comunicar(
    id VARCHAR(2),
    dni_m VARCHAR(9),
    dni_p VARCHAR(9),
    tipo VARCHAR(30),
    instrucciones VARCHAR(100),
    PRIMARY KEY(id),
    CONSTRAINT FK_comunicar1 FOREIGN KEY (dni_m) REFERENCES ingeniero_carrera(dni),
    CONSTRAINT FK_comunicar2 FOREIGN KEY (dni_p) REFERENCES pilotos(dni)

);



CREATE TABLE reparar(
    modelo VARCHAR(4),
    id_pieza VARCHAR (5),
    id_accidente VARCHAR(3),
    PRIMARY KEY(modelo, id_pieza,id_accidente),
    CONSTRAINT FK_reparar1 FOREIGN KEY (modelo) REFERENCES coche(modelo),
    CONSTRAINT FK_reparar2 FOREIGN KEY (id_pieza) REFERENCES piezas(id),
    CONSTRAINT FK_reparar3 FOREIGN KEY (id_accidente) REFERENCES accidente(id)
);

CREATE TABLE sancionar_pilotos(
    dni VARCHAR(9), 
    id VARCHAR(2),
    PRIMARY KEY (dni,id),
    CONSTRAINT FK_sancionar_pilotos1 FOREIGN KEY (dni) REFERENCES pilotos(dni),
    CONSTRAINT FK_sancionar_pilotos2 FOREIGN KEY (id) REFERENCES sancion(id)

);

ALTER TABLE gran_premio ADD COLUMN circuito VARCHAR(30);