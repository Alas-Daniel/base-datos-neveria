CREATE DATABASE LANEVERIA;
GO
USE LANEVERIA;
GO

-- BLOQUE 1: Información de la empresa --

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

CREATE TABLE DEPTO (
    DeptoId tinyint primary key identity(1,1),
    Depto varchar(20) unique not null
);

CREATE TABLE MUNICIPIO (
    MunicipioId smallint primary key identity(1,1),
    DeptoId tinyint not null,
    Zona varchar(10) check (Zona in ('CENTRO', 'ESTE', 'NORTE', 'SUR', 'OESTE')) not null,
    foreign key (DeptoId) references DEPTO(DeptoId)
);

CREATE TABLE DISTRITO (
    DistritoId smallint primary key identity(1,1), 
    Distrito varchar(50) not null,
    MunicipioId smallint not null,
    foreign key (MunicipioId) references MUNICIPIO(MunicipioId)
);

CREATE TABLE SUCURSAL (
    SucursalId smallint primary key identity(1,1),
    NombreSucursal varchar(50) unique not null,
    Direccion varchar(255) not null,
    DistritoId smallint not null,
    foreign key (DistritoId) references DISTRITO(DistritoId)
);

-- BLOQUE 2: Gestión de usuarios y empleados --

CREATE TABLE CARGO (
    CargoId smallint primary key identity(1,1),
    Cargo varchar(30) unique not null
);

CREATE TABLE TIPOUSUARIO (
    TipoUsuarioId tinyint primary key identity(1,1),
    TipoUsuario varchar(25) unique not null
);

CREATE TABLE ESTADOUSUARIO (
    EstadoId tinyint primary key identity(1,1),
    Estado varchar(20) unique not null
);

CREATE TABLE EMPLEADO (
    EmpleadoId int primary key identity(1,1),
    Nombre varchar(50) not null,
    Apellido varchar(50) not null,
    Telefono varchar(15) unique not null,
    Email varchar(100) unique not null,
    TipoDocumento varchar(15) check (TipoDocumento in ('DUI','NIT','Pasaporte')) not null,
    NumeroDocumento varchar(20) unique not null,
    FechaNac date not null,
    Direccion varchar(255) not null,
    Sexo char(1) check(Sexo in ('H','M')) not null,
    Edad as (DATEDIFF(year, FechaNac, GETDATE())),
    Cargoid smallint not null,
    SucursalId smallint not null,
    foreign key (Cargoid) references CARGO(Cargoid),
    foreign key (SucursalId) references SUCURSAL(SucursalId)
);

CREATE TABLE USUARIO (
    UsuarioId int primary key identity(1,1),
    Usuario varchar(60) unique not null,
    Clave varchar(100) not null,
    TipoUsuarioId tinyint not null,
    EmpleadoId int not null,
    EstadoId tinyint not null,
    foreign key (TipoUsuarioId) references TIPOUSUARIO(TipoUsuarioId),
    foreign key (EmpleadoId) references EMPLEADO(EmpleadoId),
    foreign key (EstadoId) references ESTADOUSUARIO(EstadoId)
);

-- BLOQUE 3: Clientes y Proveedores --

CREATE TABLE CLIENTE (
    ClienteId int primary key identity(1,1),
    Cliente varchar(50) not null,
    TipoCliente varchar(2) check (TipoCliente in ('PN', 'PJ', 'CF')) not null,
    DUI varchar(15) unique null,
    NIT varchar(50) unique null,
    NRC varchar(20) unique null,
    Telefono varchar(15) null,
    Correo varchar(100) null,
    Direccion varchar(255) null,
    CHECK (
        (TipoCliente='CF') OR -- Consumidor Final
        (TipoCliente='PN' AND DUI IS NOT NULL) OR -- Persona Natural con DUI
        (TipoCliente='PJ' AND NIT IS NOT NULL AND NRC IS NOT NULL) -- Empresa completa
    )  
);

CREATE TABLE TIPOPRODUCTO (
    TipoProductoId tinyint primary key identity(1,1),
    TipoProducto varchar(50) unique not null
);

CREATE TABLE PROVEEDOR (
    ProveedorId int primary key identity(1,1),
    Proveedor varchar(50) not null,
    TipoProveedor varchar(50) check (TipoProveedor in ('PN', 'PJ')) not null,
    TipoProductoId tinyint not null,
    Telefono varchar(15) not null,
    Email varchar(100) unique not null,
    Direccion varchar(255) not null,
    DUI varchar(20) unique null,
    NIT varchar(50) unique null,
    NRC varchar(20) unique null,
    foreign key (TipoProductoId) references TIPOPRODUCTO(TipoProductoId)
);

-- BLOQUE 4: Catálogo de productos --

CREATE TABLE CATEGORIAPRODUCTO (
    CategoriaId tinyint primary key identity(1,1),
    Categoria varchar(50) unique not null
);

CREATE TABLE PRODUCTO (
    ProductoId int primary key identity(1,1),
    Producto varchar(75) unique not null,
    CategoriaId tinyint not null,
    Precio money not null,
    TipoProducto char(1) check (TipoProducto in ('P', 'I', 'R')) not null,
    foreign key (CategoriaId) references CATEGORIAPRODUCTO(CategoriaId)
);

-- BLOQUE 5: Facturación / Ventas --

CREATE TABLE FACTURA (
    FacturaId int primary key identity(1,1),
    ClienteId int not null,
    SucursalId smallint not null,
    UsuarioId int not null,
    Fecha datetime not null default GETDATE(),
    Descuento money null,
    Subtotal money not null,
    IVA money not null,
    TotalPagar AS (Subtotal + IVA - ISNULL(Descuento, 0)) PERSISTED,
    foreign key (ClienteId) references CLIENTE(ClienteId),
    foreign key (SucursalId) references SUCURSAL(SucursalId),
    foreign key (UsuarioId) references USUARIO(UsuarioId)
);

CREATE TABLE DETALLEFACTURA (
    DetalleFacturaId int primary key identity(1,1),
    FacturaId int not null,
    ProductoId int not null,
    Cantidad int not null,
    PrecioUnitario money not null,
    Subtotal as (Cantidad * PrecioUnitario),
    -- CHECK (ProductoId in (SELECT ProductoId FROM PRODUCTO WHERE TipoProducto IN ('P', 'R'))),
    foreign key (FacturaId) references FACTURA(FacturaId),
    foreign key (ProductoId) references PRODUCTO(ProductoId)
);

-- BLOQUE 6: Gestión de Inventario --

CREATE TABLE INVENTARIO (
    InventarioId int primary key identity(1,1),
    ProductoId int not null,
    SucursalId smallint not null,
    CantidadDisponible decimal(10, 2) not null default 0,
    UnidadMedida varchar(20) not null,
    CONSTRAINT UQ_Inventario_Producto_Sucursal UNIQUE (ProductoId, SucursalId),
    -- CHECK (ProductoId in (SELECT ProductoId FROM PRODUCTO WHERE TipoProducto IN ('I', 'R'))),
    foreign key (ProductoId) references PRODUCTO(ProductoId),
    foreign key (SucursalId) references SUCURSAL(SucursalId)
);

CREATE TABLE MOVIMIENTOINVENTARIO (
    MovimientoId int primary key identity(1,1),
    UsuarioId int not null,
    SucursalId smallint not null,
    ProveedorId int null,
    Fecha datetime not null default GETDATE(),
    Tipo char(1) check(Tipo in ('E','S')), -- E=Entrada, S=Salida
    Observaciones varchar(255) null,
    -- CHECK (
    --     (Tipo='E' AND ProveedorId IS NOT NULL) OR
    --     (Tipo='S' AND ProveedorId IS NULL)
    -- ),
    foreign key (UsuarioId) references USUARIO(UsuarioId),
    foreign key (SucursalId) references SUCURSAL(SucursalId),
    foreign key (ProveedorId) references PROVEEDOR(ProveedorId)
);

CREATE TABLE DETALLEMOVIMIENTOINVENTARIO(
    DetalleMovimientoId int primary key identity(1,1),
    MovimientoId int not null,
    Cantidad decimal(10,2) not null,
    ProductoId int not null,
    -- CHECK (ProductoId FROM PRODUCTO WHERE TipoProducto IN ('I', 'R'))
    foreign key (MovimientoId) references MOVIMIENTOINVENTARIO(MovimientoId),
    foreign key (ProductoId) references PRODUCTO(ProductoId)
);

-- TRIGGERS PARA CONTROL DE INVENTARIO --
CREATE TRIGGER trg_ActualizarInventarioDespuesMovimiento
ON DETALLEMOVIMIENTOINVENTARIO
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualiza el inventario sumando o restando según el tipo del movimiento
    UPDATE i
    SET i.CantidadDisponible = 
        CASE m.Tipo
            WHEN 'E' THEN i.CantidadDisponible + d.Cantidad  -- Entrada: sumar
            WHEN 'S' THEN i.CantidadDisponible - d.Cantidad  -- Salida: restar
            ELSE i.CantidadDisponible
        END
    FROM INVENTARIO i
    INNER JOIN inserted d ON i.ProductoId = d.ProductoId
    INNER JOIN MOVIMIENTOINVENTARIO m ON d.MovimientoId = m.MovimientoId
    WHERE i.SucursalId = m.SucursalId;

    -- Insertar nuevos registros si no existían en inventario
    INSERT INTO INVENTARIO (ProductoId, SucursalId, CantidadDisponible, UnidadMedida)
    SELECT d.ProductoId, m.SucursalId,
           CASE m.Tipo WHEN 'E' THEN d.Cantidad ELSE 0 END,
           'Unidades'  -- valor genérico de unidad
    FROM inserted d
    INNER JOIN MOVIMIENTOINVENTARIO m ON d.MovimientoId = m.MovimientoId
    WHERE NOT EXISTS (
        SELECT 1 
        FROM INVENTARIO i
        WHERE i.ProductoId = d.ProductoId
          AND i.SucursalId = m.SucursalId
    );
END;

CREATE TRIGGER trg_ActualizarFacturaDespuesDetalle
ON DETALLEFACTURA
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar Subtotal e IVA de todas las facturas afectadas
    UPDATE f
    SET 
        f.Subtotal = ISNULL(df.TotalDetalle, 0),
        f.IVA = ISNULL(df.TotalDetalle, 0) * 0.13  -- ejemplo: IVA 13%
    FROM FACTURA f
    LEFT JOIN (
        SELECT Detalle.FacturaId, SUM(Detalle.Cantidad * Detalle.PrecioUnitario) AS TotalDetalle
        FROM DETALLEFACTURA Detalle
        GROUP BY Detalle.FacturaId
    ) df ON f.FacturaId = df.FacturaId;
END;

