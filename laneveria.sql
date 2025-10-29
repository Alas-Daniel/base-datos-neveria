CREATE DATABASE LANEVERIA;
GO
USE LANEVERIA;
GO

--Tabla de informacion--

CREATE TABLE EMPRESA (
    NombreComercial varchar(100) not null,
    NombreLegal varchar(100) not null,
    Logo varchar(255) not null,
    Rubro varchar(50) not null,
    Direccion varchar(255) not null,
    CallCenter varchar(20) not null,
    Correo varchar(100) not null,
    NIT varchar(50) not null,
    NRC varchar(50) not null
);

--Creación de tablas madre---

CREATE TABLE CLIENTE (
    ClienteId int primary key identity(1,1),
    Cliente varchar(50) not null
); --

CREATE TABLE TIPOUSUARIO (
    TipoUsuarioId tinyint primary key identity(1,1),
    TipoUsuario varchar(25) unique not null
); --

CREATE TABLE CARGO (
    CargoId smallint primary key identity(1,1),
    Cargo varchar(30) unique not null 
); --

CREATE TABLE DEPTO (
    DeptoId tinyint primary key identity(1,1),
    Depto varchar(20) unique not null
); --

CREATE TABLE TIPOPRODUCTO (
    TipoProductoId tinyint primary key identity(1,1),
    TipoProducto varchar(50) unique not null
); --

CREATE TABLE CATEGORIAPRODUCTO (
    CategoriaId tinyint PRIMARY KEY IDENTITY(1,1),
    Categoria varchar(50) unique not null
); --

CREATE TABLE ESTADOUSUARIO (
    EstadoId tinyint primary key identity(1,1),
    Estado varchar(20) unique not null
);

--Creacion de tablas hijas--

CREATE TABLE PROVEEDOR (
    ProveedorId int primary key identity(1,1),
    Proveedor varchar(50) not null,
    TipoProveedor varchar(50) check (TipoProveedor in ('PN', 'RS')) not null,
    TipoProductoId tinyint not null,
    Telefono varchar(15) not null,
    Email varchar(100) unique not null,
    Direccion varchar(255) not null,
    DUI varchar(20) unique null,
    NIT varchar(50) unique null,
    NRC varchar(20) unique null,
    foreign key (TipoProductoId) references TIPOPRODUCTO(TipoProductoId)
); --

CREATE TABLE MUNICIPIO (
    MunicipioId smallint primary key identity(1,1),
    DeptoId tinyint not null,
    Zona varchar(10) check (Zona in ('CENTRO', 'ESTE', 'NORTE', 'SUR')) not null,
    foreign key (DeptoId) references DEPTO(DeptoId)
); --

CREATE TABLE DISTRITO (
    DistritoId smallint primary key identity(1,1),
    Distrito varchar(75) not null,
    MunicipioId smallint not null,
    foreign key (MunicipioId) references MUNICIPIO(MunicipioId)
); --

CREATE TABLE PRODUCTO (
    ProductoId int primary key identity(1,1),
    Producto varchar(75) unique not null,
    CategoriaId tinyint not null,
    Precio money not null,
    foreign key (CategoriaId) references CATEGORIAPRODUCTO(CategoriaId)
); --

CREATE TABLE INVENTARIO (
    InventarioId int primary key identity(1,1),
    ProductoId int not null,
    SucursalId int not null,
    CantidadDisponible int not null default 0,
    foreign key (ProductoId) references PRODUCTO(ProductoId),
    foreign key (SucursalId) references SUCURSAL(SucursalId)
); --

CREATE TABLE SUCURSAL (
    SucursalId smallint primary key identity(1,1),
    NombreSucursal varchar(50) unique not null,
    Direccion varchar(255) not null,
    DistritoId smallint not null,
    foreign key (DistritoId) references DISTRITO(DistritoId)
); --

CREATE TABLE EMPLEADO (
    EmpleadoId int primary key identity(1,1),
    Nombre varchar(50) not null,
    Apellido varchar(50) not null,
    Telefono varchar(15) unique not null,
    Email varchar(100) unique not null,
    TipoDocumento varchar(15) check (TipoDocumento in ('DUI','NIT','Pasaporte')) not null,
    NumeroDoc varchar(20) unique not null,
    FechaNac date not null,
    Direccion varchar(255) not null,
    Sexo char(1) check(Sexo in ('H','M')),
    Edad as (DATEDIFF(year, FechaNac, GETDATE())),
    Cargoid smallint not null,
    SucursalId smallint not null,
    foreign key (Cargoid) references CARGO(Cargoid),
    foreign key (SucursalId) references SUCURSAL(SucursalId)
); --

CREATE TABLE USUARIO (
    UsuarioId int primary key identity(1,1),
    Usuario varchar(60) unique not null,
    Clave varchar(100) not null,
    TipodeUsuarioId tinyint not null,
    EmpleadoId int not null,
    EstadoId tinyint not null,
    foreign key (TipodeUsuarioId) references TIPOUSUARIO(TipodeUsuarioId),
    foreign key (EmpleadoId) references EMPLEADO(EmpleadoId),
    foreign key (EstadoId) references ESTADOUSUARIO(EstadoId)
); --

CREATE TABLE FACTURA (
    FacturaId int primary key identity(1,1),
    ClienteId int not null,
    SucursalId smallint not null,
    UsuarioId int not null,
    Fecha datetime not null default GETDATE(),
    Total money not null,
    Descuento money null,
    TotalPagar AS (Total - ISNULL(Descuento, 0)),
    foreign key (ClienteId) references CLIENTE(ClienteId),
    foreign key (SucursalId) references SUCURSAL(SucursalId),
    foreign key (UsuarioId) references USUARIO(UsuarioId)
); --

CREATE TABLE DETALLEFACTURA (
    DetalleFacturaId int primary key identity(1,1),
    FacturaId int not null,
    ProductoId int not null,
    Cantidad int not null,
    PrecioUnitario money not null,
    Subtotal as (Cantidad * PrecioUnitario),
    foreign key (FacturaId) references FACTURA(FacturaId),
    foreign key (ProductoId) references PRODUCTO(ProductoId)
); --

CREATE TABLE MOVIMIENTOINVENTARIO (
    MovimientoId int primary key identity(1,1),
    ProductoId int not null,
    EmpleadoId int not null,
    ProveedorId int null,
    FacturaId int null,   -- se usa solo si es salida de stock
    SucursalId int not null,
    Fecha datetime not null default GETDATE(),
    Cantidad int not null,
    Tipo char(1) check(Tipo in ('E','S')), -- E=Entrada, S=Salida
    CHECK (
        (Tipo='E' AND ProveedorId IS NOT NULL AND FacturaId IS NULL) OR
        (Tipo='S' AND FacturaId IS NOT NULL AND ProveedorId IS NULL)
    ),
    foreign key (ProductoId) references PRODUCTO(ProductoId),
    foreign key (EmpleadoId) references EMPLEADO(EmpleadoId),
    foreign key (FacturaId) references FACTURA(FacturaId),
    foreign key (ProveedorId) references PROVEEDOR(ProveedorId),
    foreign key (SucursalId) references SUCURSAL(SucursalId)
);
