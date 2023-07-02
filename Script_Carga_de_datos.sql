USE dbSalesWine;
GO
INSERT INTO persons (number_dni, names, last_name, cell_phone, email, birthday, type_person)
VALUES
('15288111', 'Adriana', 'Vázquez Carranza', '991548789', 'adriana.vasquez@saleswine.com', '1985-03-18', 'V'),
('45781236', 'Carlos', 'Guerra Tasayco', '987845123', 'carlos.guerra@saleswine.com', '1980-10-20', 'J'),
('15263698', 'Daniel', 'Lombardi Pérez', '998523641', 'daniel.lombardi@saleswine.com', '1982-06-09', 'J'),
('45123698', 'Roberto', 'Palacios Castillo', '985236417', 'roberto.palacios@saleswine.com', '1988-10-15', 'V'),
('15264477', 'Carlos', 'Palomino Fernández', '984512557', 'carlos.palomino@saleswine.com', '1989-01-03', 'V'),
('45127866', 'Fabricio', 'Rosales Zegarra', '974815231', 'fabricio@yahoo.com', '1975-03-02', 'C'),
('15487865', 'Rosaura', 'Dávila Sánchez', '974815254', 'rosaurac@gmail.com', '1979-06-16', 'C'),
('46632157', 'Noemí', 'Juárez Martínez', '984525741', 'noemi.juarez@gmail.com', '1979-09-25', 'C'),
('47258533', 'Issac', 'Sánchez Jobs', '953625147', 'issac.sanchez@outlook.com', '1995-10-30', 'C'),
('15258544', 'Fabiana', 'Carrizales Campos', '951144236', 'fabiana.carrizales@outlook.com', '1997-04-05', 'C'),
('44712214', 'Valeria', 'Mendoza Solano', '972544681', 'valeria.mendoza@yahoo.com', '1997-06-16', 'C');

-- Crear vista para mostrar los datos de persons
SELECT
id AS 'ID',
number_dni AS 'DNI',
CONCAT(UPPER(last_name), ', ', names) AS 'PERSONA',
cell_phone AS 'CELULAR',
email AS 'EMAIL',
FORMAT(birthday, 'dd - MMM - yyyy') AS [FEC. NACIMIENTO],
CASE
WHEN type_person = 'V' THEN 'Vendedor'
WHEN type_person = 'C' THEN 'Cliente'
WHEN type_person = 'J' THEN 'Jefe'
END AS 'Tipo'
FROM persons;


-- Insertar datos en la tabla product
INSERT INTO product (code, names, type, volume, country, price, stock, state)
VALUES
('P01', 'Ramos Pinto Porto', 'V', 750, 'P', 119.00, 60, 'A'),
('P02', 'Santa Julia Cabernet', 'V', 750, 'A', 199.00, 45, 'A'),
('P03', 'Pulenta Estate Cabernet Sauvignon', 'V', 750, 'A', 189.95, 70, 'A'),
('P04', 'La Rioja Alta Viña Alberdi', 'V', 500, 'E', 540.00, 80, 'A'),
('P05', 'Amayna Pinot Noir', 'V', 750, 'C', 774.00, 100, 'A'),
('P06', 'Pisco Don Santiago Mosto Verde Italia', 'P', 750, 'P', 59.00, 75, 'A'),
('P07', 'Pisco Portón Mosto Verde Torontel', 'P', 750, 'P', 89.00, 100, 'A'),
('P08', 'Tequila Olmeca Blanco', 'T', 500, 'M', 54.90, 85, 'A'),
('P09', 'Tequila Olmeca Reposado', 'T', 750, 'M', 54.90, 85, 'A'),
('P10', 'Black Whiskey Don Michael', 'W', 750, 'P', 159.90, 70, 'A'),
('P11', 'Whisky Chivas Regal 12 Años', 'W', 500, 'E', 89.90, 70, 'A');

-- Crear vista para mostrar los datos de product

SELECT
code AS 'CODIGO',
names AS 'PRODUCTO',
CASE
WHEN type = 'V' THEN 'VINO'
WHEN type = 'P' THEN 'PISCO'
WHEN type = 'T' THEN 'TEQUILA'
WHEN type = 'W' THEN 'WHISKY'
END AS 'TIPO',
CONCAT(volume, ' ml.') AS 'VOLUMEN',
CASE country
WHEN 'P' THEN 'Perú'
WHEN 'A' THEN 'Argentina'
WHEN 'C' THEN 'Chile'
WHEN 'E' THEN 'España'
WHEN 'M' THEN 'México'
END AS 'PAIS',
CONCAT('S/', price) AS 'PRECIO',
stock AS 'STOCK',
CASE state
WHEN 'A' THEN 'Activo'
WHEN 'I' THEN 'Inactivo'
END AS 'ESTADO'
FROM product;


-- Insertar datos en la tabla sale
INSERT INTO sale (date, type_pay, type_delivery, status, person_id, seller_id)
VALUES
('2022-11-09 18:11', 'E', 'D', 'A', 105, 100),
('2022-11-09 18:11', 'T', 'T', 'A', 107, 103),
('2022-11-09 18:11', 'Y', 'D', 'A', 110, 101),
('2022-11-09 18:11', 'Y', 'T', 'A', 106, 100),
('2022-11-09 18:11', 'E', 'T', 'A', 105, 103),
('2022-11-09 18:11', 'P', 'T', 'A', 109, 100),
('2022-11-09 18:11', 'T', 'T', 'A', 108, 100);

-- Crear vista para mostrar los datos de sale

SELECT
s.id AS 'VENTA',
FORMAT(s.date, 'dd-MMM-yy - HH:mm') AS 'FEC. VENTA',
CONCAT(UPPER(vendedor.last_name), ' ', vendedor.names) AS 'VENDEDOR',
CONCAT(UPPER(cliente.last_name), ' ', cliente.names) AS 'CLIENTE',
CASE s.type_pay
WHEN 'E' THEN 'EFECTIVO'
WHEN 'T' THEN 'TARJETA'
WHEN 'Y' THEN 'YAPE'
WHEN 'P' THEN 'PLIN'
END AS 'TIPO PAGO',
CASE s.type_delivery
WHEN 'D' THEN 'Delivery'
WHEN 'T' THEN 'Tienda'
END AS 'TIPO ENTREGA',
CASE s.status
WHEN 'A' THEN 'Activo'
WHEN 'I' THEN 'Inactivo'
END AS 'EST. VENTA'
FROM sale AS s
INNER JOIN persons AS vendedor ON s.seller_id = vendedor.id
INNER JOIN persons AS cliente ON s.person_id = cliente.id;


-- Insertar datos en la tabla sale_detail
INSERT INTO sale_detail (amount, sale_id, product_code)
VALUES
(5, 1, 'P01'),
(2, 1, 'P06'),
(2, 2, 'P01'),
(6, 3, 'P05'),
(18, 3, 'P02'),
(15, 3, 'P03'),
(1, 3, 'P04'),
(6, 4, 'P07'),
(12, 4, 'P01'),
(8, 4, 'P03'),
(7, 4, 'P06'),
(6, 5, 'P08'),
(12, 5, 'P10'),
(1, 5, 'P04'),
(4, 6, 'P02'),
(10, 6, 'P11'),
(2, 6, 'P03'),
(6, 7, 'P04'),
(3, 7, 'P02'),
(1, 7, 'P06');

-- Mostrar datos de sale_detail
SELECT
sd.id AS 'ID DETALLE',
sd.sale_id AS 'ID VENTA',
p.names AS 'PRODUCTO',
sd.amount AS 'CANTIDAD'
FROM sale_detail AS sd
JOIN product AS p ON sd.product_code = p.code;