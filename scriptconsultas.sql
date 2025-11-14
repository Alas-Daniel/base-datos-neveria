USE LANEVERIA;
GO

-- BLOQUE 1: TABLAS PADRE
-- EMPRESA, DEPTO, CARGO, TIPOUSUARIO, ESTADOUSUARIO, TIPOPRODUCTO, CATEGORIAPRODUCTO

INSERT INTO EMPRESA 
(NombreComercial, NombreLegal, Logo, Rubro, Direccion, CallCenter, Correo, NIT, NRC)
VALUES
('La Nevería', 
 'La Nevería S.A. de C.V.', 
 'logo_neveria.png', 
 'Heladería', 
 'Av. Principal #123, Sonsonate, El Salvador', 
 '503-7000-1234', 
 'info@laneveria.com', 
 '0614-010101-101-2', 
 '12345');

INSERT INTO DEPTO (Depto) VALUES
('Sonsonate'),('Santa Ana'),('San Salvador'),('La Libertad'),
('Chalatenango'),('Cuscatlán'),('La Paz');

INSERT INTO CARGO (Cargo) VALUES
('Gerente'),('Administrador'),('Vendedor'),('Almacenista'),
('Contador'),('Tecnico'),('Conserje');

INSERT INTO TIPOUSUARIO (TipoUsuario) VALUES
('Administrador'),('Vendedor'),('Contable'),('Gerente');

INSERT INTO ESTADOUSUARIO (Estado) VALUES
('Activo'),('Inactivo'),('Suspendido'),('Retirado'),('Vacaciones');

INSERT INTO TIPOPRODUCTO (TipoProducto) VALUES
('Insumo'),('Reventa'),('Bebida'),('Fruta'),('Snack'),('Otros');

INSERT INTO CATEGORIAPRODUCTO (Categoria) VALUES
('Helados'),('Jugos'),('Snacks'),('Bebidas'),('Repostería'),('Otros');
GO

-- BLOQUE 2: MUNICIPIO Y DISTRITO

INSERT INTO MUNICIPIO (DeptoId, Zona) VALUES
(1,'CENTRO'),(2,'CENTRO'),(3,'CENTRO'),(4,'CENTRO'),
(5,'CENTRO'),(6,'CENTRO'),(7,'CENTRO');

INSERT INTO DISTRITO (Distrito, MunicipioId) VALUES
('Sonsonate Centro', 1),('Santa Ana Centro', 2),('San Salvador Centro', 3),
('La Libertad Centro', 4),('Chalatenango Centro', 5),('Cuscatlán Centro', 6),
('La Paz Centro', 7);
GO

-- BLOQUE 3: SUCURSAL

INSERT INTO SUCURSAL (NombreSucursal, Direccion, DistritoId) VALUES
('Sucursal Sonsonate', 'Av. Principal #123', 1),
('Sucursal Santa Ana', 'Calle Central #45', 2),
('Sucursal San Salvador', 'Blvd. Las Palmas #12', 3),
('Sucursal La Libertad', 'Calle Libertad #34', 4),
('Sucursal Chalatenango', 'Av. Central #78', 5),
('Sucursal Cuscatlán', 'Calle Reforma #56', 6),
('Sucursal La Paz', 'Av. Los Pinos #22', 7);
GO

-- BLOQUE 4: EMPLEADO

INSERT INTO EMPLEADO 
(Nombre, Apellido, Telefono, Email, TipoDocumento, NumeroDocumento, FechaNac, Direccion, Sexo, CargoId, SucursalId)
VALUES
('Daniel','Alas','50370000001','daniel.alas@email.com','DUI','00000001','2005-01-01','Col. Centro','H',1,1),
('Iverson','Zepeda','50370000002','iverson.zepeda@email.com','DUI','00000002','2004-02-02','Col. Norte','H',2,2),
('Carlos','Cuerno','50370000003','carlos.cuerno@email.com','NIT','00000003','2003-03-03','Col. Sur','H',3,3),
('Edwin','Gonzalez','50370000004','edwin.gonzalez@email.com','DUI','00000004','2005-04-04','Col. Este','H',4,4),
('Luis','Ramirez','50370000005','luis.ramirez@email.com','Pasaporte','00000005','2004-05-05','Col. Oeste','H',5,5),
('Maria','Hernandez','50370000006','maria.hernandez@email.com','DUI','00000006','2003-06-06','Col. Centro','M',6,6),
('Jose','Flores','50370000007','jose.flores@email.com','NIT','00000007','2005-07-07','Col. Norte','H',7,7),
('Sofia','Vasquez','50370000008','sofia.vasquez@email.com','DUI','00000008','2004-08-08','Col. Sur','M',1,1),
('Pedro','Ruiz','50370000009','pedro.ruiz@email.com','DUI','00000009','2003-09-09','Col. Este','H',2,2),
('Carla','Mejia','50370000010','carla.mejia@email.com','Pasaporte','00000010','2005-10-10','Col. Oeste','M',3,3),
('Miguel','Castillo','50370000011','miguel.castillo@email.com','DUI','00000011','2004-11-11','Col. Centro','H',4,4),
('Elena','Mendez','50370000012','elena.mendez@email.com','NIT','00000012','2003-12-12','Col. Norte','M',5,5),
('Ricardo','Ortega','50370000013','ricardo.ortega@email.com','DUI','00000013','2005-01-13','Col. Sur','H',6,6),
('Valeria','Torres','50370000014','valeria.torres@email.com','Pasaporte','00000014','2004-02-14','Col. Este','M',7,7),
('Andres','Salazar','50370000015','andres.salazar@email.com','DUI','00000015','2003-03-15','Col. Oeste','H',1,1);
GO

-- BLOQUE 5: USUARIO

INSERT INTO USUARIO (Usuario, Clave, TipoUsuarioId, EmpleadoId, EstadoId)
VALUES
('danielA','1234',4,1,1),
('iverZ','1234',1,2,1),
('carlosC','1234',2,3,1),
('edwinM','1234',3,4,1),
('sofiaV','1234',4,8,1),
('pedroR','1234',1,9,1),
('carlaM','1234',2,10,1),
('miguelC','1234',3,11,1),
('andresS','1234',4,15,1);
GO

-- BLOQUE 6: CLIENTE

INSERT INTO CLIENTE (Cliente, TipoCliente, DUI, NIT, NRC, Telefono, Correo, Direccion)
VALUES
('Pedro Pérez','PN','00000001',NULL,NULL,'5037010001','pedro.perez@email.com','Col. Centro'),
('Empresa ABC','PJ',NULL,'123456-7','NRC001','5037010002','contacto@abc.com','Av. Principal 123'),
('Consumidor Final','CF',NULL,NULL,NULL,'5037010003','','Col. Norte'),
('Luis Gomez','PN','00000002',NULL,NULL,'5037010004','luis.gomez@email.com','Col. Sur'),
('Frutas SA','PJ',NULL,'123456-8','NRC002','5037010005','ventas@frutas.com','Av. Central 45'),
('Maria Lopez','PN','00000003',NULL,NULL,'5037010006','maria.lopez@email.com','Col. Este'),
('Juventud CF','CF',NULL,NULL,NULL,'5037010007','','Col. Oeste'),
('Carlos Perez','PN','00000004',NULL,NULL,'5037010008','carlos.perez@email.com','Col. Centro'),
('Empresa XYZ','PJ',NULL,'123456-9','NRC003','5037010009','ventas@xyz.com','Av. Libertad 12'),
('Ana Torres','PN','00000005',NULL,NULL,'5037010010','ana.torres@email.com','Col. Norte'),
('Consumidor Final 2','CF',NULL,NULL,NULL,'5037010011','','Col. Sur'),
('Luis Ramirez','PN','00000006',NULL,NULL,'5037010012','luis.ramirez@email.com','Col. Este'),
('Sorbeteria SA','PJ',NULL,'123456-10','NRC004','5037010013','ventas@sorbeteria.com','Av. Centro 34'),
('Sofia Jimenez','PN','00000007',NULL,NULL,'5037010014','sofia.jimenez@email.com','Col. Oeste'),
('Consumidor Final 3','CF',NULL,NULL,NULL,'5037010015','','Col. Norte');
GO

-- BLOQUE 7: PROVEEDOR

INSERT INTO PROVEEDOR (Proveedor, TipoProveedor, TipoProductoId, Telefono, Email, Direccion, DUI, NIT, NRC)
VALUES
('Boquitas Diana','PN',1,'5037020001','contacto@boquitasdiana.com','Col. Centro, Sonsonate','00000001',NULL,NULL),
('Cooperativa Ganadera de Sonsonate','PJ',3,'5037020002','info@cgs.com','Av. Principal 12, Sonsonate',NULL,'06123456-7','NRC001'),
('LivSmart','PJ',5,'5037020003','ventas@livsmart.com','Calle Central 45, Santa Ana',NULL,'06123457-8','NRC002'),
('Industrias La Constancia','PJ',2,'5037020004','contacto@laconstancia.com','Blvd. Las Palmas 12, San Salvador',NULL,'06123458-9','NRC003'),
('Distribuidora El Cafetal','PN',3,'5037020005','ventas@elcafetal.com','Col. Norte, Santa Ana','00000002',NULL,NULL),
('Proveedora de Limpieza El Salvador','PJ',6,'5037020006','info@limpiezasv.com','Av. Libertad 34, San Salvador',NULL,'06123459-0','NRC004'),
('Frutas y Verduras La Huerta','PN',4,'5037020007','contacto@lahuerta.com','Col. Este, La Libertad','00000003',NULL,NULL),
('Bebidas Tropicales SA','PJ',3,'5037020008','ventas@tropicales.com','Calle Norte 56, Santa Ana',NULL,'06123460-1','NRC005'),
('SnackDelight','PN',5,'5037020009','snacks@delight.com','Col. Oeste, San Salvador','00000004',NULL,NULL),
('Dairy Farm Sonsonate','PJ',1,'5037020010','contacto@dairyson.com','Av. Sur 67, Sonsonate',NULL,'06123461-2','NRC006'),
('Panadería El Trigo','PN',1,'5037020011','ventas@eltrigo.com','Col. Centro, San Salvador','00000005',NULL,NULL),
('Agroindustria El Sol','PJ',2,'5037020012','info@agrosol.com','Av. Este 78, La Libertad',NULL,'06123462-3','NRC007'),
('Productos Naturales La Montaña','PN',4,'5037020013','ventas@lamontana.com','Col. Norte, Chalatenango','00000006',NULL,NULL),
('Bebidas y Jugos La Frutal','PJ',3,'5037020014','contacto@lajfrutal.com','Av. Oeste 89, San Salvador',NULL,'06123463-4','NRC008'),
('Sorbetería El Helado','PN',1,'5037020015','ventas@elhelado.com','Col. Sur, La Paz','00000007',NULL,NULL);
GO

-- BLOQUE 8: PRODUCTO

-- PRODUCTOS FINALES TIPO 'P'
INSERT INTO PRODUCTO (Producto, CategoriaId, Precio, TipoProducto)
VALUES
('Paleta Chocolate Blanco Cookies and creme', 1, 1.50, 'P'),
('Paleta Chocolate Capuchino', 1, 1.50, 'P'),
('Paleta Chocolate Choco Avellana', 1, 1.50, 'P'),
('Paleta Chocolate Choco Lover', 1, 1.50, 'P'),
('Paleta Chocolate Nevechoc', 1, 1.50, 'P'),
('Paleta Cremosa Cream Pop', 1, 1.50, 'P'),
('Paleta Cremosa Mango Fresa', 1, 1.50, 'P'),
('Pastel Helado Cardenal de Fresa', 5, 12.00, 'P'),
('Pastel Helado Cheesecake de Frambuesa', 5, 12.00, 'P'),
('Pastel Helado Choco Brownie', 5, 12.00, 'P'),
('Pastel Helado Choco Caramelo', 5, 12.00, 'P'),
('Pastel Helado Cookies and creme', 5, 12.00, 'P'),
('Pastel Helado Multisabor', 5, 12.00, 'P'),
('Pastel Helado Unicornio', 5, 12.00, 'P'),
('Banana Fresa', 6, 5.00, 'P'),
('Banana Split', 6, 6.00, 'P'),
('Banana Topper', 6, 5.50, 'P'),
('Choco Banana', 6, 5.50, 'P'),
('Ice Cream Soda', 6, 4.00, 'P'),
('Mega Sundae', 6, 6.50, 'P'),
('Milk Shake', 6, 4.50, 'P'),
('Nevi Sundae', 6, 6.50, 'P'),
('Party Cup', 6, 3.50, 'P'),
('Sundae', 6, 4.00, 'P'),
('Sundae Dinosaurio', 6, 4.50, 'P'),
('Sundae Unicornio', 6, 4.50, 'P'),
('Café Caliente Americano', 4, 2.50, 'P'),
('Café Caliente Capuchino', 4, 3.00, 'P'),
('Café Caliente Caramel Macchiato', 4, 3.50, 'P'),
('Café Caliente Mocachino', 4, 3.50, 'P'),
('Café Helado Caramelo', 4, 3.50, 'P'),
('Café Helado Chocolate', 4, 3.50, 'P'),
('Café Helado Chocolate Galleta', 4, 3.50, 'P'),
('Café Helado Cookie and Creme', 4, 3.50, 'P'),
('Café Helado Mocca', 4, 3.50, 'P');

-- INSUMOS TIPO 'I' 
INSERT INTO PRODUCTO (Producto, CategoriaId, Precio, TipoProducto)
VALUES
('Leche Entera', 6, 0.00, 'I'),
('Crema de Leche', 6, 0.00, 'I'),
('Azúcar', 6, 0.00, 'I'),
('Chocolate en Polvo', 6, 0.00, 'I'),
('Vainilla Líquida', 6, 0.00, 'I'),
('Fresas Frescas', 6, 0.00, 'I'),
('Bananos', 6, 0.00, 'I'),
('Café Molido', 6, 0.00, 'I'),
('Galletas Oreo', 6, 0.00, 'I'),
('Jarabe de Caramelo', 6, 0.00, 'I'),
('Chispas de Chocolate', 6, 0.00, 'I'),
('Nueces Picadas', 6, 0.00, 'I'),
('Cacao en Polvo', 6, 0.00, 'I'),
('Avellanas', 6, 0.00, 'I'),
('Frambuesas', 6, 0.00, 'I');

-- PRODUCTOS DE REVENTA TIPO 'R'
INSERT INTO PRODUCTO (Producto, CategoriaId, Precio, TipoProducto)
VALUES
('Jugo Cascada Naranja', 4, 1.00, 'R'),
('Jugo Petit Piña', 4, 1.00, 'R'),
('Coca Cola', 4, 1.20, 'R'),
('Agua Embotellada', 4, 0.75, 'R');
GO

-- BLOQUE 9: INVENTARIO

INSERT INTO INVENTARIO (ProductoId, SucursalId, CantidadDisponible, UnidadMedida)
VALUES
-- Insumos (ProductoId 36-50)
(36, 1, 50.00, 'Litros'),
(37, 1, 20.00, 'Litros'), 
(38, 1, 100.00, 'Kg'),
(39, 1, 30.00, 'Kg'),
(40, 1, 15.00, 'Litros'),
(41, 1, 25.00, 'Kg'),
(42, 1, 40.00, 'Kg'),
(43, 1, 10.00, 'Kg'),
(44, 1, 50.00, 'Unidades'),
(45, 1, 15.00, 'Litros'),
(46, 1, 20.00, 'Kg'),
(47, 1, 10.00, 'Kg'),
(48, 1, 25.00, 'Kg'),
(49, 1, 12.00, 'Kg'),
(50, 1, 18.00, 'Kg'),
-- Productos de reventa 
(51, 1, 200, 'Unidades'),
(52, 1, 200, 'Unidades'),
(53, 1, 150, 'Unidades'),
(54, 1, 150, 'Unidades');
GO

-- BLOQUE 10: FACTURA

INSERT INTO FACTURA (ClienteId, SucursalId, UsuarioId, Descuento, Subtotal, IVA)
VALUES
(1,1,1,0,10,1.3),
(2,2,2,0,20,2.6),
(3,3,3,0,15,1.95),
(4,4,4,0,25,3.25),
(5,5,5,0,18,2.34),
(6,6,6,0,30,3.9),
(7,7,7,0,22,2.86),
(8,1,1,0,12,1.56),
(9,2,2,0,16,2.08),
(10,3,3,0,14,1.82),
(11,4,4,0,19,2.47),
(12,5,5,0,17,2.21),
(13,6,6,0,23,2.99),
(14,7,7,0,20,2.6),
(15,1,1,0,21,2.73);
GO

-- BLOQUE 11: DETALLEFACTURA

INSERT INTO DETALLEFACTURA (FacturaId, ProductoId, Cantidad, PrecioUnitario)
VALUES
-- Facturas con productos finales (tipo P)
(1,1,2,1.50),(1,3,1,1.50),
(2,4,3,1.50),(2,2,2,1.50),
(3,5,5,1.50),(3,6,2,1.50),
(4,7,1,1.50),(4,8,2,12.00),
(5,9,3,12.00),(5,10,1,12.00),
(6,11,4,12.00),(6,12,2,12.00),
(7,13,2,12.00),(7,14,1,12.00),
(8,15,1,5.00),(8,16,2,6.00),
(9,17,3,5.50),(9,18,2,5.50),
(10,19,1,4.00),(10,20,3,6.50),
(11,21,2,4.50),(11,22,2,6.50),
(12,23,1,3.50),(12,24,3,4.00),
(13,25,2,4.50),(13,26,1,4.50),
(14,27,1,2.50),(14,28,2,3.00),
-- Facturas con productos de reventa (tipo R)
(15,51,3,1.00),(15,53,2,1.20);
GO

-- BLOQUE 12: MOVIMIENTOINVENTARIO

INSERT INTO MOVIMIENTOINVENTARIO (UsuarioId, SucursalId, ProveedorId, Tipo, Observaciones)
VALUES
(1,1,1,'E','Entrada de insumos - Leche y crema'),
(2,2,2,'E','Entrada de insumos - Chocolate y azúcar'),
(3,3,3,'E','Entrada de bebidas para reventa'),
(4,4,4,'E','Entrada de insumos - Café y vainilla'),
(5,5,5,'E','Entrada de frutas frescas'),
(6,6,6,'E','Entrada de productos de reventa'),
(7,7,7,'E','Entrada de galletas y chispas'),
(8,1,8,'E','Entrada de jarabe y cacao'),
(9,2,9,'E','Entrada de nueces y avellanas');
GO

-- BLOQUE 13: DETALLEMOVIMIENTOINVENTARIO 

INSERT INTO DETALLEMOVIMIENTOINVENTARIO (MovimientoId, Cantidad, ProductoId)
VALUES
(1, 50.00, 36), (1, 20.00, 37),
(2, 30.00, 39), (2, 100.00, 38),
(3, 200, 51), (3, 150, 53),
(4, 10.00, 43), (4, 15.00, 40),
(5, 25.00, 41), (5, 40.00, 42),
(6, 200, 52), (6, 150, 54),
(7, 50, 44), (7, 20.00, 46),
(8, 15.00, 45), (8, 25.00, 48),
(9, 10.00, 47), (9, 12.00, 49);
GO