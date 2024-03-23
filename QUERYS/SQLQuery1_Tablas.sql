use Cajero
CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    nombreCliente VARCHAR(30) NOT NULL,
    rol VARCHAR(10) NOT NULL,
    apellido VARCHAR(30) NOT NULL, 
    pin VARCHAR(10) NOT NULL,
    telefono VARCHAR(8) NOT NULL
);

CREATE TABLE Cuentas (
    noCuenta INT PRIMARY KEY,
    idCliente INT NOT NULL,
    saldo DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);

CREATE TABLE Transacciones (
    idTransaccion INT PRIMARY KEY,
    monto DECIMAL(12,2) NOT NULL,
    tipoTransaccion VARCHAR(2) NOT NULL,
    fechaHora DATETIME,
	NumeroCuentaOrigen INT NOT NULL,
	NumeroCuentaDestino INT
);

CREATE TABLE Cajero (
    id INT PRIMARY KEY,
    cantidad INT NOT NULL,
    billetesDe100 INT NOT NULL,
    billetesDe50 INT NOT NULL,
    fecha DATE
);

CREATE TABLE RegistroCajero (
    id INT PRIMARY KEY IDENTITY,
    fechahora DATETIME NOT NULL, 
	billetesDe100 int,
	billetesDe50 int,
    total DECIMAL(12, 2) NOT NULL,
    administradorId INT,
	accion varchar(2) not NULL
);

