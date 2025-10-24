CREATE DATABASE LANEVERIA;
USE LANEVERIA;

--Creación de tablas madre---

CREATE TABLE CLIENTE (
    idCliente int primary key identity(1,1),
    Nombre varchar(50) not null
);

CREATE TABLE TIPOUSUARIO (
    idTipoUsuario int primary key identity(1,1),
    Tipo varchar(25) not null
);

CREATE TABLE CARGO (
    idCargo int primary key identity(1,1),
    Cargo varchar(30) not null 
);

CREATE TABLE DEPTO (
    idDepto int primary key identity(1,1),
    Depto varchar(15) not null
);

CREATE TABLE PROVEEDOR (
    idProveedor int primary key identity(1,1),
    Nombre varchar(50) not null,
    Telefono varchar(15) not null,
    Email varchar(100) unique not null,
    Direccion varchar(259) not null
);

CREATE TABLE CATEGORIA_STOCK (
    idCategoria int primary key identity(1,1),
    Categoria varchar(15) not null
);

CREATE TABLE ESTADO (
    idEstado tinyint primary key identity(1,1),
    Estado varchar(20) not null
);


--Creacion de tablas hijas--

CREATE TABLE MUNICIPIO (
    idMunicipio int primary key identity(1,1),
    Municipio varchar(40) not null,
    idDepto int not null,
    foreign key (idDepto) references DEPTO(idDepto)
);

CREATE TABLE DISTRITO (
    idDistrito int primary key identity(1,1),
    Distrito varchar(40) not null,
    idMunicipio int not null,
    foreign key (idMunicipio) references MUNICIPIO(idMunicipio)
);

CREATE TABLE STOCK (
    idProducto int primary key identity(1,1),
    Producto varchar(30) not null,
    idCategoria int not null,
    Precio money not null,
    foreign key (idCategoria) references CATEGORIA_STOCK(idCategoria)
);

CREATE TABLE SUCURSAL (
    idSucursal int primary key identity(1,1),
    NombreSucursal varchar(25) not null,
    Direccion varchar(259) not null,
    idDepto int not null,
    foreign key (idDepto) references DEPTO(idDepto)
);

CREATE TABLE EMPLEADO (
    idEmpleado int primary key identity(1,1),
    NombreCompleto varchar(75) not null,
    Telefono varchar(15) not null,
    NumeroIdentificacion varchar(15) unique not null,
    FechaNac date not null,
    Direccion varchar(259) not null,
    Sexo char(1) check(Sexo in ('H','M')),
    Edad as (DATEDIFF(year, FechaNac, GETDATE())),
    idCargo int not null,
    idSucursal int not null,
    foreign key (idCargo) references CARGO(idCargo),
    foreign key (idSucursal) references SUCURSAL(idSucursal)
);

CREATE TABLE USUARIO (
    idUsuario int primary key identity(1,1),
    Nombre varchar(60) not null,
    Clave varchar(100) not null,
    idTipodeUsuario int not null,
    idEmpleado int not null,
    idEstado tinyint not null,
    foreign key (idTipodeUsuario) references TIPOUSUARIO(idTipoUsuario),
    foreign key (idEmpleado) references EMPLEADO(idEmpleado),
    foreign key (idEstado) references ESTADO(idEstado)
);

CREATE TABLE FACTURA (
    idFactura int primary key identity(1,1),
    idCliente int not null,
    Fecha datetime not null,
    TotalDescuento money not null,
    TotalPagar money not null,
    foreign key (idCliente) references CLIENTE(idCliente)
);

CREATE TABLE DETALLE_FACTURA (
    idDetalle int primary key identity(1,1),
    idFactura int not null,
    idProducto int not null,
    Cantidad int not null,
    PrecioUnitario money not null,
    Descuento money not null default 0,
    Subtotal as ((Cantidad * PrecioUnitario) - Descuento),
    foreign key (idFactura) references FACTURA(idFactura),
    foreign key (idProducto) references STOCK(idProducto)
);

CREATE TABLE MENOSSTOCK (
    idMenosStock int primary key identity(1,1),
    idProducto int not null,
    idEmpleado int not null,
    Fecha date not null,
    StockVendido int not null,
    foreign key (idProducto) references STOCK(idProducto),
    foreign key (idEmpleado) references EMPLEADO(idEmpleado)
);

CREATE TABLE MASSTOCK (
    idMasStock int primary key identity(1,1),
    idProducto int not null,
    StockAdquirido int not null,
    idProveedor int not null,
    Fecha date not null,
    foreign key (idProducto) references STOCK(idProducto),
    foreign key (idProveedor) references PROVEEDOR(idProveedor)
);


-- CREATE TABLE CONDICIONESPAGO(

-- )