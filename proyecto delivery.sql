DROP DATABASE IF EXISTS proyecto_delivery;
CREATE DATABASE proyecto_delivery;
USE proyecto_delivery;
-- tabla de registro de clientes
CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(100) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- tabla de restaurante pasa informacion a la tabla productos
CREATE TABLE restaurante(
	id_restaurante INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL,
	direccion VARCHAR (100) NOT NULL,
	categoria VARCHAR (100),
	telefono VARCHAR (30),
	email VARCHAR (100),
	horario_apertura TIME,
	horario_cierre TIME
);

-- tabla de productos de los restaurantes, recibe datos de restaurantes
CREATE TABLE producto(
	id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_restaurante INT NOT NULL,
	producto VARCHAR(100),
	precio DECIMAL(12,2),
	descripcion VARCHAR(100),
	FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante)
);

-- repartidores 
CREATE TABLE repartidor(
	id_repartidor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL,
	apellido VARCHAR (100) NOT NULL,
	telefono VARCHAR (100) NOT NULL
);

-- tabla de direcciones de los clientes, toma informacion de la tabla clientes
CREATE TABLE direccion(
	id_direccion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_cliente INT NOT NULL,
	direccion VARCHAR (100),
	referencias VARCHAR (150),
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

-- tabla metodo de pago
CREATE TABLE metodo_pago(
id_metodo_pago INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (50) NOT NULL,
descripcion VARCHAR (150)
);

-- tabla de pedidos, toma informacion de la tabla clientes, direccion, producto, repartidor
CREATE TABLE pedido(
	id_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_cliente INT NOT NULL,
	id_direccion INT NOT NULL,
	id_repartidor INT,
    id_restaurante INT NOT NULL,
    id_metodo_pago INT NOT NULL,
	estado ENUM('Pendiente', 'Preparando', 'En Camino', 'Entregado', 'Cancelado'),
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
	hora_entrega DATETIME,
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
	FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
	FOREIGN KEY (id_repartidor) REFERENCES repartidor(id_repartidor),
    FOREIGN KEY (id_metodo_pago) REFERENCES metodo_pago(id_metodo_pago),
    FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante)
);



-- tabla detalle del pedido, separa los pedidos para que se pueden pedir por cantidad
CREATE TABLE detalle_pedido(
	id_detalle_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_pedido INT NOT NULL, 
	id_producto INT NOT NULL,
	cantidad int,
	precio_unitario DECIMAL(12, 2),
	FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Tabla de facturacion
CREATE TABLE factura(
	id_factura INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_pedido INT NOT NULL,
    id_restaurante INT NOT NULL,
	tipo_factura ENUM('A', 'B', 'C','Ticket') NOT NULL, -- usar ENUM para opciones fijas que no cambien
	fecha_emision DATETIME DEFAULT CURRENT_TIMESTAMP,  -- fecha por default
	cuit VARCHAR (30) NOT NULL,
	FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_restaurante) REFERENCES restaurante(id_restaurante)
);

#-------CARGA DE DATOS------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------


INSERT INTO cliente (nombre, apellido, dni, email, telefono, fecha_registro) 
VALUES ('Juan', 'Pérez', '30123456', 'juan.perez@email.com', '1144556677', '2024-01-10 10:30:00'),
('María', 'García', '32456789', 'm.garcia@email.com', '1155667788', '2024-01-12 11:15:00'),
('Ricardo', 'Darín', NULL, 'richie@actor.com', '1122334455', '2024-01-15 09:00:00'),
('Elena', 'Rodríguez', '28555444', 'elena.rod@webmail.com', '1199887766', '2024-01-18 15:45:00'),
('Carlos', 'Sánchez', '35000111', 'carlos_s@web.com', '1144112233', '2024-01-20 18:20:00'),
('Ana', 'Martínez', '44564432', 'ana.m@correo.es', '1133445522', '2024-01-22 12:00:00'),
('Luis', 'López', '40111222', 'lucho_lopez@mail.com', '1166778899', '2024-01-25 14:10:00'),
('Sofía', 'González', '38222333', 'sofi.gonz@fastmail.com', '1122998877', '2024-01-28 20:30:00'),
('Jorge', 'Hernández', NULL, 'jorge.h@servidor.com', '1188990011', '2024-01-30 08:45:00'),
('Lucía', 'Díaz', '25666777', 'lucia.diaz@email.com', '1144332211', '2024-02-02 16:20:00'),
('Mateo', 'Álvarez', '42000333', 'm.alvarez@email.com', '1122112233', '2024-02-05 10:00:00'),
('Valentina', 'Torres', '26873454', 'valen.t@mail.com', '1155443322', '2024-02-08 11:30:00'),
('Diego', 'Ramírez', '31999888', 'diego.ram@outlook.com', '1199008877', '2024-02-10 13:45:00'),
('Camila', 'Flores', '36777666', 'cami.f@web.ar', '1166332211', '2024-02-12 17:15:00'),
('Nicolás', 'Benítez', NULL, 'nico.b88@email.com', '1177665544', '2024-02-15 09:20:00'),
('Martina', 'Medina', '33444555', 'marti.medina@mail.com', '1166554433', '2024-02-18 21:00:00'),
('Joaquín', 'Castro', '39111000', 'joaco.c@fastmail.com', '1144221199', '2024-02-20 14:50:00'),
('Victoria', 'Ortiz', NULL, 'vicky.ortiz@servidor.com', '1155887744', '2024-02-22 18:10:00'),
('Julián', 'Silva', '27nombre555333', 'j.silva@email.com', '1133221100', '2024-02-25 12:30:00'),
('Florencia', 'Rojas', '41222888', 'flor.rojas@mail.com', '1188776655', '2024-02-28 15:00:00'),
('Santiago', 'Molina', NULL, 'santi.m@web.com', '1199112233', '2024-03-02 08:00:00'),
('Paola', 'Morales', '34888111', 'pao.morales@email.com', '1122339988', '2024-03-05 22:15:00'),
('Emiliano', 'Vázquez', '37111444', 'emi.vaz@net.com', '1155994411', '2024-03-08 11:40:00'),
('Bautista', 'Godoy', '43876745', 'bauti.g@mail.com', '1122883377', '2024-03-10 16:50:00'),
('Delfina', 'Luna', '43111222', 'delfi.luna@web.ar', '1177334499', '2024-03-12 19:20:00'),
('Facundo', 'Acosta', '32555666', 'facu.acosta@gmail.com', '1166993322', '2024-03-15 10:10:00'),
('Micaela', 'Páez', NULL, 'mica.paez@email.com', '1144882200', '2024-03-18 14:00:00'),
('Gabriel', 'Suárez', '29444111', 'gabi.s@servidor.com', '1133990022', '2024-03-20 17:30:00'),
('Agustina', 'Blanco', '38999000', 'agus.b@mail.com', '1155440022', '2024-03-22 09:45:00'),
('Ignacio', 'Bravo', NULL, 'nacho.bravo@web.com', '1166442288', '2024-03-25 20:00:00'),
('Lorena', 'Cabrera', '31666333', 'lore.c@email.com', '1199331155', '2024-03-28 13:15:00'),
('Tomás', 'Figueroa', '40555222', 'tomi.figue@web.com', '1155228844', '2024-04-01 11:50:00'),
('Rocío', 'Giménez', '46345566', 'ro.gim@mail.com', '1144772211', '2024-04-03 16:30:00'),
('Felipe', 'Ibarra', '35222111', 'feli.iba@net.com', '1144771100', '2024-04-05 18:10:00'),
('Juana', 'Mansilla', '44111333', 'juana.m@email.com', '1188339922', '2024-04-08 12:40:00'),
('Marcos', 'Navarro', NULL, 'marcos.n@servidor.com', '1133114488', '2024-04-10 09:20:00'),
('Sol', 'Peralta', '37888555', 'sol.peralta@mail.com', '1155883344', '2024-04-12 21:55:00'),
('Francisco', 'Quiroga', '32999444', 'fran.q@gmail.com', '1177003311', '2024-04-15 14:15:00'),
('Lola', 'Sosa', NULL, 'lola.sosa@web.ar', '1122668833', '2024-04-18 10:05:00'),
('Mateo', 'Vera', '41666111', 'mateo.vera@email.com', '1166224400', '2024-04-20 17:45:00'),
('Ema', 'Zeballos', '28111999', 'ema.z@mail.com', '1133772211', '2024-04-22 13:30:00'),
('Pedro', 'Aguirre', '45465436', 'pedro.ag@webmail.com', '1155001144', '2024-04-25 08:50:00'),
('Guadalupe', 'Correa', '36444222', 'guada.c@servidor.com', '1199442277', '2024-04-28 19:10:00'),
('Ramiro', 'Duarte', '33888777', 'ramiro.d@email.com', '1133771199', '2024-05-01 12:00:00'),
('Ambar', 'Esquivel', NULL, 'ambar.e@web.com', '1122665544', '2024-05-03 15:40:00'),
('Bruno', 'Fuentes', '42777444', 'bruno.f@mail.com', '1177229955', '2024-05-05 10:20:00'),
('Catalina', 'Gaitan', '30222999', 'cata.g@mail.com', '1122551100', '2024-05-08 18:30:00'),
('Dante', 'Juarez', NULL, 'dante.j@email.com', '1166118833', '2024-05-10 14:15:00'),
('Elena', 'Ledesma', '39555111', 'elena.l@servidor.com', '1133994422', '2024-05-12 11:00:00'),
('Felix', 'Mendez', '26333000', 'felix.m@gmail.com', '1144993377', '2024-05-15 09:10:00'),
('Gia', 'Ojeda', NULL, 'gia.o@web.ar', '1188440022', '2024-05-18 20:45:00'),
('Hugo', 'Paredes', '40999333', 'hugo.p@email.com', '1133006611', '2024-05-20 13:20:00'),
('Iris', 'Quintana', '34222888', 'iris.q@mail.com', '1155773311', '2024-05-22 16:55:00'),
('Jano', 'Rios', NULL, 'jano.rios@net.com', '1177551100', '2024-05-25 10:40:00'),
('Kiara', 'Salinas', '31555222', 'kiara.s@servidor.com', '1122994488', '2024-05-28 14:05:00'),
('Leonel', 'Tapia', '38111666', 'leo.tapia@email.com', '1166330099', '2024-05-30 08:30:00'),
('Mia', 'Urbina', '38392834', 'mia.u@web.com', '1144229933', '2024-06-02 21:15:00'),
('Noah', 'Vallejos', '43666000', 'noah.v@mail.com', '1144118822', '2024-06-05 12:50:00'),
('Olivia', 'Yañez', '29888444', 'olivia.y@mail.com', '1188229955', '2024-06-08 17:00:00'),
('Pilar', 'Zarate', NULL, 'pilar.z@email.com', '1133660011', '2024-06-10 11:30:00'),
('Quirino', 'Almada', '35444999', 'quirino.a@servidor.com', '1155992211', '2024-06-12 15:10:00'),
('Renata', 'Barrios', '32111777', 'renata.b@gmail.com', '1177993344', '2024-06-15 10:00:00'),
('Simón', 'Campos', '39874657', 'simon.c@web.ar', '1122005588', '2024-06-18 19:40:00'),
('Tiziana', 'Delgado', '41555000', 'tizi.d@email.com', '1166882211', '2024-06-20 14:25:00'),
('Ulises', 'Espinosa', '27999222', 'ulises.e@mail.com', '1133440011', '2024-06-22 12:10:00'),
('Vera', 'Farías', '32654637', 'vera.f@webmail.com', '1155339900', '2024-06-25 08:20:00'),
('Walter', 'Gaitán', '38444111', 'walter.g@servidor.com', '1199662244', '2024-06-28 18:50:00'),
('Ximena', 'Ibarra', '33777555', 'xime.i@email.com', '1133550077', '2024-07-01 13:15:00'),
('Yago', 'Jara', '32345657', 'yago.j@web.com', '1122774433', '2024-07-03 16:40:00'),
('Zoe', 'Luz', '42555888', 'zoe.luz@mail.com', '1177441166', '2024-07-05 10:30:00'),
('Abel', 'Maldonado', '30999111', 'abel.m@mail.com', '1122774499', '2024-07-08 19:10:00'),
('Belen', 'Nieves', NULL, 'belu.n@email.com', '1166003388', '2024-07-10 14:00:00'),
('Ciro', 'Orozco', '39666222', 'ciro.o@servidor.com', '1133880022', '2024-07-12 11:20:00'),
('Dora', 'Peralta', '26888555', 'dora.p@gmail.com', '1144229900', '2024-07-15 09:05:00'),
('Elias', 'Quinteros', NULL, 'elias.q@web.ar', '1188116644', '2024-07-18 20:55:00'),
('Faustina', 'Reyes', '40333777', 'fausti.r@email.com', '1133884422', '2024-07-20 13:40:00'),
('Guido', 'Soria', '34666000', 'guido.s@mail.com', '1122990033', '2024-07-22 17:15:00'),
('Hilda', 'Tello', NULL, 'hilda.t@net.com', '1177228833', '2024-07-25 10:15:00'),
('Ivan', 'Uribe', '31222444', 'ivan.u@servidor.com', '1122447700', '2024-07-28 14:30:00'),
('Jazmin', 'Vidal', '37555111', 'jaz.v@email.com', '1166991155', '2024-07-30 08:45:00'),
('Kevin', 'Wolff', '43345445', 'kevin.w@web.com', '1155224499', '2024-08-02 21:25:00'),
('Lara', 'Xerez', '43444999', 'lara.x@mail.com', '1144883366', '2024-08-05 12:10:00'),
('Milton', 'Yunes', '29111333', 'milton.y@mail.com', '1188550044', '2024-08-08 17:35:00'),
('Nora', 'Zarza', NULL, 'nora.z@email.com', '1133449922', '2024-08-10 11:45:00'),
('Oscar', 'Arce', '35777222', 'oscar.a@servidor.com', '1144770033', '2024-08-12 15:20:00'),
('Priscila', 'Bustos', '32333888', 'pris.b@gmail.com', '1177114488', '2024-08-15 10:50:00'),
('Ruso', 'Coronel', NULL, 'ruso.c@web.ar', '1122330055', '2024-08-18 19:00:00'),
('Tania', 'Duarte', '41888333', 'tania.d@email.com', '1166551199', '2024-08-20 14:10:00'),
('Uriel', 'Elias', '27222666', 'uriel.e@mail.com', '1133992211', '2024-08-22 12:45:00'),
('Vanesa', 'Frías', NULL, 'vane.f@webmail.com', '1155883300', '2024-08-25 08:55:00');

INSERT INTO restaurante (nombre, direccion, categoria, telefono, email, horario_apertura, horario_cierre)
VALUES
('La Mezzetta', 'Av. Álvarez Thomas 1321', 'Pizzas', '1145541122', 'contacto@lamezzetta.com', '11:00:00', '23:00:00'),
('Burger Joint', 'Jorge Luis Borges 1766', 'Hamburguesas', '1148331515', 'hola@burgerjoint.com', '12:00:00', '00:00:00'),
('Sushi Club', 'Alicia Moreau de Justo 286', 'Sushi', '08102227874', 'info@sushiclub.com.ar', '19:00:00', '23:30:00'),
('Don Julio', 'Guatemala 4699', 'Parrilla', '1148319564', 'reservas@parrilladonjulio.com', '12:00:00', '23:59:00'),
('Tea Connection', 'Uriburu 1597', 'Saludable', '1148057162', 'delivery@teaconnection.com', '08:00:00', '20:00:00'),
('Kentucky', 'Av. Santa Fe 2702', 'Pizzas', '1148215500', 'santafe@kentucky.com.ar', '06:00:00', '02:00:00'),
('Fabric Sushi', 'Av. del Libertador 6002', 'Sushi', '1147816640', 'libertador@fabricsushi.com', '19:30:00', '23:30:00'),
('The Birra Bar', 'Av. San Juan 4359', 'Hamburguesas', '1149231122', 'info@thebirrabar.com', '18:00:00', '01:00:00'),
('El Cuartito', 'Talcahuano 937', 'Pizzas', '1148161758', 'pedidos@elcuartito.com', '11:30:00', '23:30:00'),
('Dean & Dennys', 'Malabia 1591', 'Hamburguesas', '1148334455', 'palermo@deananddennys.com', '11:00:00', '00:00:00'),
('La Cholita', 'Rodríguez Peña 1165', 'Parrilla', '1148154506', 'info@lacholita.com', '12:00:00', '00:00:00'),
('Green Eat', 'Florida 102', 'Saludable', '1143265500', 'microcentro@greeneat.com', '08:00:00', '19:00:00'),
('Hell’s Pizza', 'Humboldt 1654', 'Pizzas', '1147731100', 'humboldt@hells.com.ar', '12:00:00', '01:00:00'),
('Pizzería Güerrín', 'Av. Corrientes 1368', 'Pizzas', '1143718141', 'info@pizzeriaguerrin.com', '11:00:00', '01:00:00'),
('Kansas Grill', 'Av. del Libertador 4625', 'Americana', '1147764100', 'palermo@kansas.com.ar', '12:00:00', '00:00:00'),
('Mizuki', 'Juana Manso 1519', 'Sushi', '1152186638', 'puertomadero@mizuki.com', '19:00:00', '23:30:00'),
('La Cabrera', 'José A. Cabrera 5127', 'Parrilla', '1148325745', 'ventas@lacabrera.com.ar', '12:00:00', '23:30:00'),
('Tostado Café', 'Av. Córdoba 1501', 'Cafetería', '1148112233', 'cordoba@tostado.com.ar', '07:00:00', '21:00:00'),
('Tandoor', 'Laprida 1293', 'India', '1148213676', 'info@tandoor.com.ar', '19:00:00', '23:30:00'),
('Sarkis', 'Thames 1101', 'Árabe', '1147724911', 'pedidos@sarkis.com.ar', '12:00:00', '15:30:00');

INSERT INTO repartidor (nombre, apellido, telefono) VALUES
('Carlos', 'Sánchez', '1122334455'),
('Matias', 'Gómez', '1133445566'),
('Laura', 'Paz', '1144556677'),
('Kevin', 'Rodríguez', '1155667788'),
('Brian', 'López', '1166778899'),
('Sofía', 'Martínez', '1177889900'),
('Diego', 'Álvarez', '1188990011'),
('Nicolás', 'Díaz', '1199001122'),
('Julieta', 'Herrera', '1100112233'),
('Esteban', 'Quito', '1122446688'),
('Facundo', 'Rojas', '1133557799'),
('Micaela', 'Blanco', '1144668800'),
('Lucas', 'Torres', '1155779911'),
('Agustín', 'Medina', '1166880022'),
('Valentina', 'Castro', '1177991133'),
('Andrés', 'Silva', '1188002244'),
('Camila', 'Ortiz', '1199113355'),
('Rodrigo', 'Benítez', '1100224466'),
('Dante', 'Molina', '1122335577'),
('Elena', 'Vázquez', '1133446688'),
('Gabriel', 'Suárez', '1144557799'),
('Paula', 'Giménez', '1155668800'),
('Hugo', 'Paredes', '1166779911'),
('Rocío', 'Luna', '1177880022'),
('Ignacio', 'Bravo', '1188991133');

INSERT INTO producto (id_restaurante, producto, precio, descripcion) VALUES
-- 1. La Mezzetta (Pizzas)
(1, 'Muzzarella Corte', 1200.00, 'La clásica porción de muzzarella al molde.'),
(1, 'Fugazzetta Rellena', 8500.00, 'Pizza entera rellena de queso y mucha cebolla.'),
(1, 'Faina', 800.00, 'Porción de faina crocante.'),
(1, 'Muzzarella Entera', 7200.00, 'Pizza entera de 8 porciones.'),

-- 2. Burger Joint (Hamburguesas)
(2, 'La Bleu', 5500.00, 'Hamburguesa con queso azul, cebolla caramelizada y rúcula.'),
(2, 'La Mexican', 5300.00, 'Picante, con guacamole, jalapeños y nachos.'),
(2, 'Papas Grandes', 2500.00, 'Papas fritas caseras con doble cocción.'),
(2, 'Burger Clásica', 4800.00, 'Cheddar, lechuga, tomate y salsa especial.'),

-- 3. Sushi Club (Sushi)
(3, 'Placer Real (9 piezas)', 9500.00, 'Roll de salmón, palta y queso crema.'),
(3, 'Nigiri Salmón (5 piezas)', 6200.00, 'Cortes de salmón fresco sobre arroz.'),
(3, 'Geishas Salmón', 7100.00, 'Finas láminas de salmón rellenas de queso y palta.'),
(3, 'Hot Roll', 8800.00, 'Roll rebozado y frito con salsa teriyaki.'),

-- 4. Don Julio (Parrilla)
(4, 'Ojo de Bife', 15500.00, 'Corte premium de 400g a la leña.'),
(4, 'Choripán de Novillo', 3800.00, 'Chorizo artesanal en pan de campo.'),
(4, 'Provoleta', 4200.00, 'Queso provolone fundido con orégano y oliva.'),
(4, 'Entraña', 14200.00, 'Corte tierno y jugoso de la casa.'),

-- 5. Tea Connection (Saludable)
(5, 'Wok de Vegetales', 5200.00, 'Arroz integral, verduras de estación y tofu.'),
(5, 'Ensalada Caesar', 4900.00, 'Pollo grillado, mix de verdes, croutons y aderezo.'),
(5, 'Limonada con Menta', 1800.00, 'Jarra individual de limonada natural.'),
(5, 'Bowl Energético', 5400.00, 'Quinoa, palta, huevo soft y semillas.'),

-- 6. Kentucky (Pizzas)
(6, 'Pizza Napolitana', 7600.00, 'Salsa de tomate, muzzarella y rodajas de tomate.'),
(6, 'Pizza Calabresa', 7900.00, 'Muzzarella y rodajas de longaniza picante.'),
(6, 'Combo 2 Porciones + Gaseosa', 3500.00, 'Almuerzo rápido clásico.'),

-- 7. Fabric Sushi (Sushi)
(7, 'Roll New York', 8200.00, 'Salmón, palta y pepino.'),
(7, 'Temaki Salmón', 4500.00, 'Cono de alga nori relleno.'),
(7, 'Sashimi (5 cortes)', 5900.00, 'Cortes de pescado puro sin arroz.'),

-- 8. The Birra Bar (Hamburguesas)
(8, 'The Golden', 5600.00, 'Doble medallón, mucho cheddar y bacon crocante.'),
(8, 'Veggie Burger', 5100.00, 'Medallón de lentejas y arroz yamani.'),
(8, 'Pinta IPA', 3200.00, 'Cerveza artesanal de la casa.'),

-- 9. El Cuartito (Pizzas)
(9, 'Pizza de Canchero', 6800.00, 'Mucha salsa de tomate y ajo, sin queso.'),
(9, 'Especial con Jamón', 8200.00, 'Muzzarella, jamón cocido y morrones.'),
(9, 'Empanada de Carne', 950.00, 'Frita o al horno, carne cortada a cuchillo.'),

-- 10. Dean & Dennys (Hamburguesas)
(10, 'Dean Bacon', 5400.00, 'Hamburguesa con salsa Dean, queso y panceta.'),
(10, 'Dennys Fried Chicken', 5200.00, 'Pollo frito crocante con lechuga y mayonesa.'),
(10, 'Shake de Vainilla', 2800.00, 'Batido espeso de helado premium.'),

-- 11. La Cholita (Parrilla)
(11, 'Matambre a la Pizza', 9800.00, 'Con papas fritas incluidas.'),
(11, 'Bondiola de Cerdo', 8500.00, 'Acompañada de puré de manzanas.'),
(11, 'Vino Malbec (Copa)', 2200.00, 'Selección de la casa.'),

-- 12. Green Eat (Saludable)
(12, 'Sandwich de Salmón Ahumado', 5800.00, 'En pan integral con queso crema y eneldo.'),
(12, 'Roll de Pollo y Palta', 4700.00, 'Envuelto en tortilla de trigo.'),
(12, 'Jugo Detox', 1900.00, 'Manzana, espinaca, pepino y limón.'),

-- 13. Hell’s Pizza (Pizzas)
(13, 'Obie Pizza', 8500.00, 'Estilo New York, gigante de pepperoni.'),
(13, 'Lincoln Slice', 1400.00, 'Porción extra grande de muzzarella.'),
(13, 'Hell’s Wings', 4200.00, 'Alitas de pollo con salsa búfalo.'),

-- 14. Pizzería Güerrín (Pizzas)
(14, 'Pizza de Fugazza', 6900.00, 'Solo cebolla y especias, muy crocante.'),
(14, 'Muzzarella al Molde', 7500.00, 'La pizza más famosa de calle Corrientes.'),
(14, 'Porción Especial', 1500.00, 'Muzzarella, jamón y morrón por unidad.'),

-- 15. Kansas Grill (Americana)
(15, 'Houston’s Ribs', 18500.00, 'Costillitas de cerdo con salsa BBQ y papas.'),
(15, 'Club Sandwich', 6200.00, 'Triple piso con pollo, huevo, bacon y queso.'),
(15, 'Key Lime Pie', 3900.00, 'Tarta de lima clásica americana.'),

-- 16. Mizuki (Sushi)
(16, 'Roll Philadelphia', 8900.00, 'Salmón y queso Philadelphia.'),
(16, 'Ebi Tempura', 7500.00, 'Langostinos rebozados fritos.'),
(16, 'Sopa Miso', 2800.00, 'Caldo tradicional japonés.'),

-- 17. La Cabrera (Parrilla)
(17, 'Bife de Chorizo', 14800.00, 'Corte ancho de 500g con guarniciones pequeñas.'),
(17, 'Achuras Mix', 7200.00, 'Chinchulín, riñón y molleja.'),
(17, 'Papas con Huevo frito', 3500.00, 'Porción generosa para compartir.'),

-- 18. Tostado Café (Cafetería)
(18, 'Tostado Mixto', 3800.00, 'Jamón y queso en pan de molde tostado.'),
(18, 'Capuccino Grande', 2500.00, 'Café con leche espumada y cacao.'),
(18, 'Muffin de Arándanos', 1500.00, 'Dulce y esponjoso.'),

-- 19. Tandoor (India)
(19, 'Chicken Tikka Masala', 8200.00, 'Pollo en salsa de especias cremosa.'),
(19, 'Naan con Ajo', 1200.00, 'Pan plano tradicional al horno de barro.'),
(19, 'Samosas (2 unidades)', 2600.00, 'Empanaditas de vegetales especiadas.'),

-- 20. Sarkis (Árabe)
(20, 'Kepe Crudo', 5800.00, 'Carne vacuna con trigo burgol y especias.'),
(20, 'Hummus', 3100.00, 'Puré de garbanzos con tahine.'),
(20, 'Shawarma de Carne', 5200.00, 'En pan de pita con vegetales y salsa.'),
(20, 'Baklawa', 1800.00, 'Postre de masa filo, nueces y almíbar.');


INSERT INTO direccion(id_cliente, direccion, referencias)VALUES
-- Clientes 1 al 10 (Muchos viven en departamentos)
(1, 'Av. Rivadavia 1234', 'Piso 4, Depto C. Timbre no funciona, llamar.'),
(2, 'Thames 550', 'Casa de rejas negras, entre Castillo y Loyola.'),
(3, 'Av. Corrientes 4500', 'Piso 12, Depto 2. Dejar en recepción.'),
(4, 'Gorriti 3210', 'Portón de madera. Casa con muchas plantas.'),
(5, 'French 2800', 'Piso 2, Depto B. Tocar timbre "Sánchez".'),
(6, 'Malabia 1500', 'Timbre B. Local comercial en planta baja.'),
(7, 'Av. Santa Fe 3200', 'Piso 8, Depto A. Cerca de la estación Agüero.'),
(8, 'Aráoz 1100', 'Casa antigua. Puerta blanca.'),
(9, 'Julian Alvarez 2100', 'Piso 5, Depto D. Frente al supermercado.'),
(10, 'Humboldt 1900', 'Oficinas de co-working. Piso 3.'),

-- Clientes 11 al 20
(11, 'Av. Pueyrredón 1500', 'Piso 1, Depto 4. Escalera a la derecha.'),
(12, 'Juncal 2300', 'Edificio moderno. Seguridad 24hs.'),
(13, 'Arenales 1800', 'Piso 6, Depto C.'),
(14, 'Bulnes 2500', 'Casa con frente de piedra.'),
(15, 'Serrano 1200', 'Depto interno por pasillo. Timbre 3.'),
(16, 'Fitz Roy 2100', 'Productora de TV. Dejar en guardia.'),
(17, 'Soler 4800', 'Esquina con calle Armenia.'),
(18, 'Cabrera 3900', 'Piso 3, Depto 12. Edificio sin ascensor.'),
(19, 'Bilinghurst 1700', 'Casa con portón automático gris.'),
(20, 'Mansilla 3100', 'Piso 7, Depto B.'),

-- Clientes con segunda dirección (Simulando "Trabajo")
(1, 'Florida 100', 'Piso 2. Galería Jardín. Oficina 234.'),
(5, 'Av. del Libertador 450', 'Torre de oficinas. Piso 15.'),
(15, 'Diagonal Norte 800', 'Banco. Entrar por lateral.'),

-- Clientes 21 al 50
(21, 'Scalabrini Ortiz 2400', 'Piso 9, Depto F.'),
(22, 'Cerviño 3600', 'Frente al hospital.'),
(23, 'Laprida 1100', 'Depto 2, planta baja.'),
(24, 'Agüero 1900', 'Piso 4, Depto A.'),
(25, 'Austria 2100', 'Casa con garaje pintado de azul.'),
(26, 'Pacheco de Melo 2800', 'Piso 11, Depto C.'),
(27, 'Av. Las Heras 2300', 'Piso 3, Depto B.'),
(28, 'Uriburu 1200', 'Facultad de Medicina. Puerta principal.'),
(29, 'Azcuénaga 1500', 'Piso 5, Depto 10.'),
(30, 'Larrea 1100', 'Casa de altos.'),
(31, 'Junín 1400', 'Piso 2, Depto D.'),
(32, 'Ayacucho 1700', 'Piso 8, Depto A.'),
(33, 'Riobamaba 1100', 'Casa con reja negra alta.'),
(34, 'Callao 1500', 'Piso 1, Depto 3.'),
(35, 'Rodriguez Peña 1800', 'Piso 6, Depto B.'),
(36, 'Montevideo 1200', 'Esquina con Alvear.'),
(37, 'Paraná 1000', 'Edificio antiguo, puerta de bronce.'),
(38, 'Uruguay 1100', 'Piso 4, Depto C.'),
(39, 'Talcauno 900', 'Cerca de Tribunales.'),
(40, 'Libertad 1200', 'Joyeria en PB.'),
(41, 'Cerrito 1400', 'Vista a la 9 de Julio.'),
(42, 'Carlos Pellegrini 1100', 'Piso 10, Depto B.'),
(43, 'Suipacha 1300', 'Hotel Alvear Icon. Dejar en recepción.'),
(44, 'Esmeralda 1000', 'Piso 2, Depto A.'),
(45, 'Maipú 900', 'Casa de cambio en PB.'),
(46, 'San Martín 800', 'Edificio de oficinas.'),
(47, 'Reconquista 600', 'Pub irlandés en la esquina.'),
(48, '25 de Mayo 400', 'Piso 5, Depto 1.'),
(49, 'Av. Leandro N. Alem 1000', 'Edificio Bouchard.'),
(50, 'Av. Eduardo Madero 900', 'Piso 12. Oficinas Techint.'),

-- Clientes 51 al 90 (Variedad de barrios)
(51, 'Olazábal 2400', 'Piso 3, Depto C. Belgrano.'),
(52, 'Mendoza 2100', 'Casa con jardín adelante.'),
(53, 'Juramento 1900', 'Piso 8, Depto B.'),
(54, 'Echeverría 2300', 'Piso 4, Depto 12.'),
(55, 'La Pampa 2800', 'Esquina con Cramer.'),
(56, 'Sucre 2100', 'Casa con portón de hierro.'),
(57, 'Av. del Libertador 6500', 'Piso 20, Depto A.'),
(58, 'Congreso 1500', 'Piso 2, Depto D.'),
(59, 'Quesada 2400', 'Casa color naranja.'),
(60, 'Iberá 2100', 'Piso 5, Depto C.'),
(61, 'Guayra 1900', 'Barrio Núñez. Portón blanco.'),
(62, 'Av. Cabildo 3500', 'Piso 10, Depto A.'),
(63, 'Juana Azurduy 2300', 'Depto interno.'),
(64, 'Manuela Pedraza 2500', 'Piso 1, Depto 4.'),
(65, 'Crisólogo Larralde 2800', 'Casa con garaje.'),
(66, 'Av. Ricardo Balbín 3100', 'Piso 6, Depto B.'),
(67, 'Melián 2100', 'Zona residencial, casa antigua.'),
(68, 'Tronador 1900', 'Frente a la plaza.'),
(69, 'Estomba 2400', 'Cerca de la estación Coghlan.'),
(70, 'Roosevelt 2100', 'Piso 3, Depto A.'),
(71, 'Enrique Martínez 1100', 'Colegiales. Casa rejas verdes.'),
(72, 'Conde 900', 'Piso 2, Depto 8.'),
(73, 'Zapiola 1400', 'Piso 4, Depto B.'),
(74, 'Freire 1700', 'Casa con árbol grande afuera.'),
(75, 'Av. Elcano 3200', 'Piso 1, Depto C.'),
(76, 'Av. de los Incas 3500', 'Piso 7, Depto A.'),
(77, 'Virrey del Pino 2400', 'Piso 10, Depto 4.'),
(78, 'Jose Hernandez 1900', 'Piso 5, Depto B.'),
(79, 'Av. Federico Lacroze 2300', 'Piso 2, Depto 10.'),
(80, 'Teodoro Garcia 2100', 'Casa de dos pisos.'),
(81, 'Av. Forest 1500', 'Piso 3, Depto C.'),
(82, 'Av. Alvarez Thomas 1100', 'Esquina con Olleros.'),
(83, 'Giribone 900', 'Casa con frente de madera.'),
(84, 'Charlone 1200', 'Piso 1, Depto B.'),
(85, 'Roseti 1400', 'Depto por pasillo.'),
(86, 'Fraga 1100', 'Casa color crema.'),
(87, 'Guevara 900', 'Piso 4, Depto A.'),
(88, 'Av. Triunvirato 3500', 'Esquina con Monroe.'),
(89, 'Bauness 2100', 'Villa Urquiza. Casa rejas negras.'),
(90, 'Bucarelli 1900', 'Piso 2, Depto D.'),

-- Más segundas direcciones
(30, 'Av. Callao 200', 'Congreso. Oficina Piso 4.'),
(60, 'Maure 1500', 'Estudio de arquitectura.'),
(88, 'Av. de los Constituyentes 4000', 'Fábrica. Tocar en el portón.');

INSERT INTO metodo_pago (nombre, descripcion) VALUES 
('Efectivo', 'Pago en efectivo al momento de recibir el pedido.'),
('Tarjeta de Crédito', 'Pago online procesado a través de la plataforma.'),
('Tarjeta de Débito', 'Pago online con fondos inmediatos.'),
('Mercado Pago', 'Transferencia o pago con QR desde la billetera virtual.');

INSERT INTO pedido (id_cliente, id_direccion, id_repartidor, id_metodo_pago, id_restaurante, estado, fecha_pedido, hora_entrega) VALUES
(1, 1, 1, 1, 1, 'Entregado', '2024-03-01 12:30:00', '2024-03-01 13:10:00'),
(5, 22, 2, 2, 2, 'Entregado', '2024-03-01 13:15:00', '2024-03-01 14:00:00'),
(9, 9, NULL, 1, 3, 'Pendiente', '2024-03-02 20:00:00', NULL),
(15, 23, 3, 3, 4, 'Cancelado', '2024-03-02 21:00:00', NULL),
(20, 20, 4, 4, 5, 'En Camino', '2024-03-03 12:45:00', NULL),
(31, 34, 5, 2, 6, 'Preparando', '2024-03-03 19:30:00', NULL),
(40, 43, 6, 1, 7, 'Entregado', '2024-03-04 11:00:00', '2024-03-04 11:45:00'),
(43, 46, 7, 4, 8, 'En Camino', '2024-03-04 13:20:00', NULL);

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
-- Pedido 1 (Juan Pérez en La Mezzetta)
(1, 1, 2, 1200.00), -- 2 Porciones de Muzzarella Corte
(1, 3, 1, 800.00),  -- 1 Porción de Faina

-- Pedido 2 (Carlos Sánchez en Burger Joint)
(2, 5, 1, 5500.00), -- 1 Hamburguesa La Bleu
(2, 7, 1, 2500.00), -- 1 Papas Grandes

-- Pedido 3 (Jorge Hernández en El Cuartito)
(3, 31, 1, 8200.00), -- 1 Pizza Especial con Jamón
(3, 32, 3, 950.00),  -- 3 Empanadas de Carne

-- Pedido 4 (Nicolás Benítez en Sarkis - Aunque está cancelado, el detalle debe existir)
(4, 65, 2, 5200.00), -- 2 Shawarma de Carne
(4, 64, 1, 3100.00), -- 1 Hummus

-- Pedido 5 (Florencia Rojas en Hell’s Pizza)
(5, 42, 1, 8500.00), -- 1 Obie Pizza (Pepperoni Gigante)

-- Pedido 6 (Lorena Cabrera en Kansas Grill)
(6, 48, 1, 18500.00), -- 1 Houston’s Ribs (Costillitas BBQ)
(6, 50, 1, 3900.00),  -- 1 Key Lime Pie

-- Pedido 7 (Mateo Vera en Pizzería Güerrín)
(7, 46, 1, 7500.00), -- 1 Muzzarella al Molde entera

-- Pedido 8 (Guadalupe Correa en Tostado Café)
(8, 57, 2, 3800.00), -- 2 Tostados Mixtos
(8, 58, 2, 2500.00); -- 2 Capuccinos Grandes

INSERT INTO factura (id_pedido, id_restaurante, tipo_factura, cuit) VALUES
-- Pedido 1 (La Mezzetta - id 1)
(1, 1, 'Ticket', '30-54551122-8'),

-- Pedido 2 (Burger Joint - id 2)
(2, 2, 'B', '30-48331515-5'),

-- Pedido 3 (El Cuartito - id 9)
(3, 9, 'Ticket', '30-48161758-2'),

-- Pedido 4 (Sarkis - id 20)
(4, 20, 'B', '30-47724911-3'),

-- Pedido 5 (Hell’s Pizza - id 13)
(5, 13, 'C', '30-47731100-4'),

-- Pedido 6 (Kansas Grill - id 15)
(6, 15, 'A', '30-47764100-9'),

-- Pedido 7 (Pizzería Güerrín - id 14)
(7, 14, 'Ticket', '30-43718141-1'),

-- Pedido 8 (Tostado Café - id 18)
(8, 18, 'B', '30-48112233-6');


#-------VIEWS------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------


-- modificaciones

-- Vistas
-- 1 quien compro? repartidor y restaurante que envia

CREATE OR REPLACE VIEW vista_pedidos_activos AS
SELECT
	p.id_pedido, 
    c.nombre AS nombre_cliente, 
    c.apellido, res.nombre AS restaurante, 
    r.nombre AS repartidor,
    p.fecha_pedido,
    p.estado
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
JOIN repartidor r ON p.id_repartidor = r.id_repartidor
JOIN restaurante res ON p.id_restaurante = res.id_restaurante
WHERE p.estado NOT IN ('Entregado', 'Cancelado');
	

--  2 Facturacion detallada 2 factura + restaurante 


CREATE VIEW vista_total_factura AS
SELECT
	f.id_factura, 
	r.nombre,
    SUM(dp.cantidad * dp.precio_unitario) AS total
FROM factura f
JOIN restaurante r ON f.id_restaurante = r.id_restaurante
JOIN detalle_pedido dp ON f.id_pedido = dp.id_pedido
GROUP BY f.id_factura, r.nombre;
 
 
 -- 3 Pedidos pendientes de asignacion

CREATE VIEW vista_pedidos_pendientes AS
SELECT 
    p.id_pedido,
    c.nombre AS cliente,
    r.nombre AS restaurante,
    p.estado,
    p.fecha_pedido
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
JOIN restaurante r ON p.id_restaurante = r.id_restaurante
WHERE p.estado IN ('Pendiente', 'Preparando', 'En Camino')
OR p.id_repartidor IS NULL;

-- 4 historial del cliente
#  cliente, direccion, pedido, repartidor, detalle_pedido a producto, 
CREATE VIEW vista_historial AS
SELECT 
	CONCAT(c.nombre, ' ', c.apellido) AS nombre_cliente,
    d.direccion,
    p.id_pedido,
    CONCAT('id repartidor: ',r.id_repartidor, ' ', r.nombre, ' ', r.apellido ) AS repartidor,
    GROUP_CONCAT(producto.producto SEPARATOR ', ') AS productos
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
JOIN direccion d ON p.id_direccion = d.id_direccion
LEFT JOIN repartidor r ON p.id_repartidor = r.id_repartidor
JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
JOIN producto ON dp.id_producto = producto.id_producto
GROUP BY p.id_pedido;

-- 5 Productos mas vendidos
CREATE VIEW productos_mas_vendidos AS
SELECT 
	pro.producto AS nombre_producto,
	r.nombre AS restaurante,
    SUM(dp.cantidad) AS total_vendido,
    COUNT(p.id_pedido) AS veces_elegido
FROM detalle_pedido dp 
JOIN pedido p ON dp.id_pedido = p.id_pedido
JOIN producto pro ON dp.id_producto = pro.id_producto
JOIN restaurante r ON pro.id_restaurante = r.id_restaurante
GROUP BY pro.producto, r.nombre
ORDER BY total_vendido DESC;
                                                                


# FUNCIONES
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------

-- Calcular costo de envio

DELIMITER //

CREATE FUNCTION calcular_costo_envio(monto_total DECIMAL(12, 2))
RETURNS DECIMAL(12, 2)
DETERMINISTIC
BEGIN
    DECLARE costo DECIMAL(12,2);
    
    -- Corregido: usamos >= para que aplique de 15 mil en adelante
    IF monto_total >= 15000.00 THEN
        SET costo = 0.00;
    ELSE
        SET costo = 3000.00;
    END IF;
    
    RETURN costo;
END //

DELIMITER ;

-- FUNCION CODIGO DE DESCUENTO
DELIMITER //

CREATE FUNCTION aplicar_cupon_descuento(monto_total DECIMAL(12,2), codigo_cupon VARCHAR(30))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
	DECLARE total_final DECIMAL(12,2); 
    IF codigo_cupon = 'Bienvenida' THEN-- decuento del 20 %
		SET total_final = monto_total * 0.80;
	
    ELSEIF codigo_cupon = 'Delivery2026' THEN 
		SET total_final = monto_total * 0.85; -- descuento del 15 %
        
	ELSEIF codigo_cupon = 'Miercolesdelivery' THEN
		SET total_final = monto_total - 4000;
			
	ELSE
		SET total_final = monto_final;
	END IF;
    
	RETURN total_final;

END//

DELIMITER ;
    


-- STORE PROCEDURE ---------------------------------------------------------
-- --------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------

-- Asignar repartidor a un pedido
DELIMITER //

CREATE PROCEDURE asignar_repartidor(IN p_id_pedido INT, IN p_id_repartidor INT)
BEGIN
	DECLARE nombre_completo VARCHAR(100);
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    ROLLBACK;
    SELECT 'Error:';
END;
-- nombre del repartidor asignado
SELECT CONCAT (nombre, ' ', apellido) INTO nombre_completo
FROM repartidor
WHERE id_repartidor = p_id_repartidor;

START TRANSACTION;
	UPDATE pedido
    SET id_repartidor = p_id_repartidor,
		estado = 'En Camino'
	WHERE id_pedido = p_id_pedido;
    COMMIT;
SELECT CONCAT ('El repartidor', nombre_completo,' fue asignado correctamente al pedido') AS 'Repartidor Asignado';
    
END //
DELIMITER ;

-- Actualizar precio de un producto

DELIMITER //

CREATE PROCEDURE sp_actualizar_precio( 
IN p_id_producto INT, IN p_nuevo_precio DECIMAL(12,2)
)
BEGIN
	DECLARE v_nombre_producto VARCHAR(100);
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    
		ROLLBACK;
        SELECT 'ERROR';
	END;
    
    SELECT producto INTO v_nombre_producto
    FROM producto
    WHERE id_producto = p_id_producto;
    
START TRANSACTION;
	UPDATE producto
    SET precio = p_nuevo_precio
    WHERE id_producto = p_id_producto;
COMMIT;

SELECT CONCAT ('el producto ', v_nombre_producto, ' fue modificado correctamente') AS 'Precio Modificado';

END //
DELIMITER ;

-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- TRIGERS
-- Normalización de Datos del Cliente (El "Corrector")
SELECT * FROM cliente

DELIMITER //

CREATE TRIGGER tgr_normalizar_datos
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
	SET NEW.nombre = UPPER(TRIM(NEW.nombre));
    SET NEW.apellido = UPPER(TRIM(NEW.apellido));
    SET NEW.email = LOWER(TRIM(NEW.email));
    
END //

DELIMITER ;

-- Historial de cambios de precio
SELECT * FROM producto;
-- cree nueva tabla de historial de precio
CREATE TABLE historial_precio (
	id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    precio_anterior DECIMAL (12,2),
    precio_nuevo DECIMAL (12,2),
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP
)
-- triger con cambios
DELIMITER //
CREATE TRIGGER tgr_historial_precio
AFTER UPDATE ON producto
FOR EACH ROW
BEGIN
	IF OLD.precio != NEW.precio THEN
		INSERT INTO historial_precio
        (id_producto, precio_anterior, precio_nuevo)
		VALUES
        (OLD.id_producto, OLD.precio, NEW.precio);
	END IF;
END //
DELIMITER ;

-- precios invalidos

DELIMITER //
CREATE TRIGGER tgr_validar_precio_insert
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
	IF NEW.precio <= 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'El precio debe ser mayor a 0';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER tgr_validar_precio_update
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN
	IF NEW.precio <= 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'El precio debe ser mayor a 0';
	END IF;
END //
DELIMITER ;
	






