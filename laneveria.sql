CREATE DATABASE LANEVERIA;
USE LANEVERIA;

--Creación de tablas madre---
CREATE TABLE CLIENTES (
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
    Direccion varchar(270) not null
);

CREATE TABLE CATEGORIASSTOCK (
    idCategoria int primary key identity(1,1),
    Categoria varchar(15) not null
);



