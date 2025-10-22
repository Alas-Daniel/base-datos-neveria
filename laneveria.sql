CREATE DATABASE LANEVERIA;
USE LANEVERIA;

--Creación de tablas madre---
CREATE TABLE CLIENTE (
    idCliente int primary key identity(1,1),
    Nombre varchar(30) null
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

CREATE TABLE PROVEEDORES (
    idProveedores int primary key identity(1,1),
    Nombre varchar(30) not null,
    Telefono varchar(15) not null,
    CorreoElectronico varchar(40) not null,
    Direccion varchar(259) not null
);

CREATE TABLE CATEGORIASSTOCK (
    idCategoria int primary key identity(1,1),
    Categoria varchar(15) not null
);

--Creacion de tablas hijas--

CREATE TABLE MUNICIPIO (
    idMunicipio int primary key identity(1,1),
    NombreMunicipio varchar(40) not null,
    idDepto int unique not null
    foreign key references DEPTO(idDepto)
);

CREATE TABLE DISTRITO (
    idDistrito int primary key identity(1,1),
    NombreDistrito varchar(40) not null,
    idDistrito unique not null
    foreign key references MUNICIPIO(idMunicipio)
);

CREATE TABLE STOCK (
    idProducto int primary key identity(1,1),
    NombreProducto varchar(30) not null,
    idCategoria int unique not null,
    Precio money not null,
    
    foreign  key (idCategoria) references CATEGORIASSTOCK(idCategoria)
);

CREATE TABLE USUARIO(
    idUsuario int primary key indentity(1,1),
    nombre varchar (60) not null,
    clave varchar(100) not null,
    idTipodeUsuario int not null
    foreign key references TIPOUSUARIO(idTipoUsuario) 
);

CREATE TABLE FACTURA (
    idFactura int primary key indentity(1,1),
    idCliente int unique not null,
    Fecha datetime not null,
    idProducto int unique not null,
    TotalDescuento float not null,
    TotalPagar float not null,
    foreign key (idCliente) references CLIENTE(idCliente),
    foreign key (idProducto) references STOCK(idProducto)
    
);

CREATE TABLE SUCURSAL(
    idDistrito int primary key identity(1,1),
    NombreSucursal varchar(25) not null,
    Direccion varchar(259) not null,
    foreign key references DEPTO(idDEPTO) 
);

CREATE TABLE EMPLEADOS (
    idEmpleado int primary key identity(1,1),
    NombreCompleto varchar(75) not null,
    Telefono varchar(15) not null,
    NumeroIdentificacion varchar(15) unique not null,
    FechaNac DATE not null,
    Direccion varchar(259) not null,
    Sexo char(1) check(Sexo in ('H','M')),
    Edad AS (DATEDIFF(MONTH, FechaNac, GETDATE()) / 12)
    
);

CREATE TABLE MENOSSTOCK(
    idMenosStock int primary key identity(1,1),
    idProducto int unique not null,
    idEmpleado int unique not null,
    Fecha DATE not null,
    StockVendido int not null,
    foreign key (idProducto) references STOCK(idProducto),
    foreign key (idEmpleado) references EMPLEADOS(idEmpleado)
);

CREATE TABLE MASSTOCK (
    idMasStock int primary key identity(1,1);
    StockAdquirido varchar(159) not null,
    StockTipo varchar(29) not null,
    idProveedor int unique not null,
    Fecha DATE not null,
    foreign key (idProveedor) references PROVEEDORES(idProveedor)
);

-- CREATE TABLE CONDICIONESPAGO(

-- )