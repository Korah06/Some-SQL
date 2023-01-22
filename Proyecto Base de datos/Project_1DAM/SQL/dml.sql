INSERT INTO gran_premio VALUES
('01','GP de Bahrein','Bahrein','Sakhir'),
('02','GP de Emilia-Romagna','Italia','Imola'),
('03','GP de España','España','Montmeló'),
('04','GP de Mónaco','Mónaco','Montecarlo'),
('05','GP de Azerbaiyán','Azerbaiyán','Bakú'),
('06','GP de Francia','Francia','Paul Ricard'),
('07','GP de Estiria','Austria','Spielberg'),
('08','GP de Austria','Austria','Spielberg'),
('09','GP de Gran Bretaña','Gran Bretaña','Silverstone'),
('10','GP de Hungria','Hungria','Hungaroring'),
('11','GP de Belgica','Belgica','Spa-Francorchamps'),
('12','GP de Paises Bajos','Paises Bajos','Zandvoort'),
('13','GP de Italia','Italia','Monza'),
('14','GP de Rusia','Rusia','Sochi'),
('15','GP de Turquia','Turquia','Estanbul'),
('16','GP de EE UU','Estados Unidos','Circuito de las americas'),
('17','GP de Ciudad de México','México','Hermanos Rodriguez'),
('18','GP de Sao Paulo','Brasil','Interlagos'),
('19','GP de Qatar','Qatar','Losail'),
('20','GP de Arabia Saudi','Arabia Saudi','Yeda'),
('21','GP de Abu Dhabi','Abu Dhabi','Yas Marina')
;

INSERT INTO coche VALUES
('SF21',5651000);

INSERT INTO director_tecnico VALUES
('10296382M','Mattia','Binotto',80000,'649245676');

INSERT INTO mecanicos VALUES
('49235298O','Ricardo','Addami','650642236','10296382M',110000),
('85638135N','Jock','Clear','670422187','10296382M',110000),
('18734235N','Steve','Johnson','670422187','10296382M',45000),
('42351623J','Paco','Gomez','672187987','10296382M',45000),
('18734235A','Will','Lebron','789381047','10296382M',45000),
('18351239S','James','Smith','610934187','10296382M',45000),
('19291235J','Anthony','Davis','687653487','10296382M',50000),
('12894735H','Michael','Jordan','677985673','10296382M',50000),
('68736535C','Bill','Clinton','656412187','10296382M',50000),
('23736727G','Santiago','Matinez','777984562','10296382M',50000);

INSERT INTO ingeniero_carrera VALUES
('49235298O'),
('18734235N');

INSERT INTO m_carrera VALUES
('18734235N','Cambiar Ruedas'),
('42351623J','Levantar morro'),
('18734235A','Levantar parte trasera'),
('18351239S','Control de semaforo');

INSERT INTO m_reglaje VALUES
('19291235J'),
('12894735H'),
('68736535C'),
('23736727G');

INSERT INTO pilotos VALUES
('49926127C','Carlos','Sainz','608983634',10200000, 'Charles LeChair','16','10296382M'),
('12943872K','Charles','Leclerc','632094142',6800000,'Chili','55','10296382M');

INSERT INTO piezas VALUES
('MSF21','Motor',4100000,4),
('CCF21','Caja de cambios',570000,5),
('TEF21','Tubo de escape',230000,6),
--DE AQUI PARA ABAJO HACER UN UPDATE PARA QUE SEAN NULL
('CHF21','Chasis',105000,20),
('FSF21','Frenos',185000,25),
('ADF21','Aleron delantero',190000,10),
('ATF21','Aleron trasero',190000,10),
('VSF21','Volante',26000,10),
('ERF21', 'ERS', 200000,10);


INSERT INTO ruedas VALUES
('C1','seco','duro'),
('C2','seco','medio'),
('C3','seco','blando'),
('C4','mojado','intermedio'),
('C5','mojado','mojado');



INSERT INTO participar VALUES
('49926127C','01',8,4,8),
('12943872K','01',4,8,6),
('49926127C','02',11,10,5),
('12943872K','02',4,12,4),
('49926127C','03',6,6,7),
('12943872K','03',4,12,4),
('49926127C','04',4,18,2),
('12943872K','04',null,0,20),
('49926127C','05',5,4,8),
('12943872K','05',1,12,4),
('49926127C','06',5,0,11),
('12943872K','06',7,0,16),
('49926127C','07',12,8,6),
('12943872K','07',7,6,7),
('49926127C','08',10,10,5),
('12943872K','08',12,4,8),
('49926127C','09',10,8,6),
('12943872K','09',4,18,2),
('49926127C','10',15,15,3),
('12943872K','10',7,0,18),
('49926127C','11',11,1,10),
('12943872K','11',9,2,8),
('49926127C','12',6,6,7),
('12943872K','12',5,10,5),
('49926127C','13',6,8,6),
('12943872K','13',5,12,4),
('49926127C','14',2,15,3),
('12943872K','14',19,0,15),
('49926127C','15',19,4,8),
('12943872K','15',3,12,4),
('49926127C','16',5,6,7),
('12943872K','16',4,12,4),
('49926127C','17',6,8,6),
('12943872K','17',8,10,5),
('49926127C','18',3,9,6),
('12943872K','18',6,10,5),
('49926127C','19',5,6,7),
('12943872K','19',13,4,8),
('49926127C','20',15,4,8),
('12943872K','20',4,6,7),
('49926127C','21',5,15,3),
('12943872K','21',7,1,10);


INSERT INTO accidente VALUES
('01','Choque contra una barrera','04','12943872K'),
('02', 'Golpe en el aleron trasero con otro piloto','06','12943872K'),
('03', 'Golpe contra un muro tras un subviraje','07','12943872K'),
('04', 'Pinchazo tras pisar un trozo de chasis', '20','49926127C')
;


INSERT INTO comunicar VALUES
('01','49235298O','49926127C','Entrar a boxes','Tienes que entrar a boxes en la siguiente vuelta'),
('02','18734235N','12943872K','Fallo motor','Estas teniendo fallos en el motor en bajas revoluciones evita bajarlas demasiado'),
('03','18734235N','12943872K','Bandera amarilla','Ten cuidado hay bandera amarilla en el tercer sector'),
('04','18734235N','12943872K','Golpe','Te encuentras bien, ha sido un duro golpe, quédate hay esta llegando el safety car');



INSERT INTO sancion VALUES
('01','10 posiciones de penalizacion','Por exceder el limite de motores posibles en un mundial'),
('02','10 segundos en carrera','Por adelantar por fuera de pista y no devolver la posicion'),
('03','8 posiciones de penalizacion','Por cambiar el sistema electrico del motor '),
('04','Multa de 10.000 euros','Debido a tocar un Formula 1 de un equipo contrario');


INSERT INTO cambiar_ruedas VALUES
('18734235N','01','C2'),
('18734235N','02','C1'),
('18734235N','02','C4'),
('18734235N','03','C2'),
('18734235N','04','C3'),
('18734235N','05','C2'),
('18734235N','06','C1'),
('18734235N','06','C4'),
('18734235N','07','C1'),
('18734235N','08','C1'),
('18734235N','08','C2'),
('18734235N','09','C1'),
('18734235N','10','C5'),
('18734235N','11','C2'),
('18734235N','12','C3'),
('18734235N','13','C2'),
('18734235N','13','C1'),
('18734235N','14','C2'),
('18734235N','14','C4'),
('18734235N','15','C2'),
('18734235N','16','C4'),
('18734235N','16','C2'),
('18734235N','17','C1'),
('18734235N','18','C1'),
('18734235N','19','C2'),
('18734235N','20','C2'),
('18734235N','21','C2');


INSERT INTO sancionar_pilotos VALUES
('49926127C','01'),
('12943872K','02'),
('12943872K','03'),
('12943872K','04');


INSERT INTO reparar VALUES
('SF21','CHF21','01'),
('SF21','ATF21','02'),
('SF21','ADF21','03');


INSERT INTO formar VALUES
('MSF21','SF21'),
('CCF21','SF21'),
('TEF21','SF21'),
('CHF21','SF21'),
('FSF21','SF21'),
('ADF21','SF21'),
('ATF21','SF21'),
('VSF21','SF21');


INSERT INTO reglar VALUES
('19291235J','SF21'),
('12894735H','SF21'),
('68736535C','SF21'),
('23736727G','SF21');


INSERT INTO sancionar_piezas VALUES
('MSF21','01'),
('ERF21','02');



