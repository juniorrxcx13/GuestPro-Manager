#SISTEMA DE GERENCIAMENTO DE HOTÉIS
#Adilson Junior, Thiago Lima e Maria Clara

Create database GuestProManager;

Use GuestProManager;

CREATE TABLE Quarto (
    Numero INT PRIMARY KEY,
    Capacidade INT
);

CREATE TABLE Reserva (
    ID INT PRIMARY KEY,
    Horario TIME,
    Data DATETIME,
    Avaliacao INT,
    Valor DECIMAL(12 , 2 ),
    NumeroQuarto INT,
    CPFHospede VARCHAR(11),
    FOREIGN KEY (NumeroQuarto)
        REFERENCES Quarto (Numero)
);

CREATE TABLE Comentario (
    ID INT PRIMARY KEY,
    Nota INT,
    Descricao VARCHAR(500)
);

CREATE TABLE Hospede (
    CPF VARCHAR(11) PRIMARY KEY,
    Nome VARCHAR(64),
    Email VARCHAR(128),
    Telefone VARCHAR(15),
    IDComentario INT,
    FOREIGN KEY (IDComentario)
        REFERENCES Comentario (ID)
);



CREATE TABLE Servico (
    ID INT PRIMARY KEY,
    Tipo VARCHAR(128)
);

CREATE TABLE Contem (
    IDReserva INT,
    IDServico INT,
    FOREIGN KEY (IDReserva)
        REFERENCES Reserva (ID),
    FOREIGN KEY (IDServico)
        REFERENCES Servico (ID),
    PRIMARY KEY (IDReserva , IDServico)
);

CREATE TABLE Funcionario (
    Registro INT PRIMARY KEY,
    Nome VARCHAR(64),
    Email VARCHAR(128),
    Telefone VARCHAR(15)
);

CREATE TABLE Realiza (
    IDServico INT,
    IDRegistro INT,
    FOREIGN KEY (IDServico)
        REFERENCES Servico (ID),
    FOREIGN KEY (IDRegistro)
        REFERENCES Funcionario (Registro),
    PRIMARY KEY (IDServico , IDRegistro)
);

CREATE TABLE Departamento (
    ID INT PRIMARY KEY,
    Nome VARCHAR(64),
    DataAdmissao DATETIME
);

CREATE TABLE Camareira (
    RegistroFuncionario INT,
    QuartosAtribuidos VARCHAR(10),
    FOREIGN KEY (RegistroFuncionario)
        REFERENCES Funcionario (Registro),
    PRIMARY KEY (RegistroFuncionario)
);

CREATE TABLE Cozinheiro (
    RegistroFuncionario INT,
    Especialidade VARCHAR(128),
    FOREIGN KEY (RegistroFuncionario)
        REFERENCES Funcionario (Registro),
    PRIMARY KEY (RegistroFuncionario)
);

CREATE TABLE Recepcionista (
    RegistroFuncionario INT,
    Turno ENUM('Dia', 'Noite'),
    FOREIGN KEY (RegistroFuncionario)
        REFERENCES Funcionario (Registro),
    PRIMARY KEY (RegistroFuncionario)
);