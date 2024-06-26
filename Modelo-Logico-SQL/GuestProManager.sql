#SISTEMA DE GERENCIAMENTO DE HOTÉIS
#Adilson Junior, Thiago Lima e Maria Clara

Create database GuestProManager;

Use GuestProManager;

CREATE TABLE Quarto (
    Numero INT PRIMARY KEY,
    Capacidade INT
);

INSERT INTO Quarto (Numero, Capacidade) VALUES (101, 2);
INSERT INTO Quarto (Numero, Capacidade) VALUES (102, 4);
INSERT INTO Quarto (Numero, Capacidade) VALUES (103, 3);

CREATE TABLE Hospede (
    CPF VARCHAR(11) PRIMARY KEY,
    Nome VARCHAR(64),
    Email VARCHAR(128),
    Telefone VARCHAR(15)
);

INSERT INTO Hospede (CPF, Nome, Email, Telefone) VALUES ('15090344411', 'Flávio Costa', 'flavio.costa@gmail.com', '992345465');
INSERT INTO Hospede (CPF, Nome, Email, Telefone) VALUES ('17123423455', 'Ana Paula Silva', 'ana.silva@gmail.com', '999163424');
INSERT INTO Hospede (CPF, Nome, Email, Telefone) VALUES ('19987680212', 'Carlos Oliveira', 'carlos.oliveira@gmail.com', '992522131');

CREATE TABLE Comentario (
    ID INT PRIMARY KEY,
    Nota INT,
    Descricao VARCHAR(500),
    CPF_Hospede VARCHAR(11),
    FOREIGN KEY (CPF_Hospede)
        REFERENCES Hospede (CPF)
);

INSERT INTO Comentario (ID, Nota, Descricao, CPF_Hospede) VALUES (1, 5, 'Excelente serviço!', '15090344411');
INSERT INTO Comentario (ID, Nota, Descricao, CPF_Hospede) VALUES (2, 4, 'Muito bom, mas poderia melhorar.', '17123423455');
INSERT INTO Comentario (ID, Nota, Descricao, CPF_Hospede) VALUES (3, 3, 'Razoável, mas com alguns problemas.', '19987680212');

CREATE TABLE Reserva (
    ID INT PRIMARY KEY,
    Horario TIME,
    DataR DATETIME,
    Avaliacao INT,
    Valor DECIMAL(12 , 2 ),
    NumeroQuarto INT,
    Pagamento ENUM('0%', '50%', '100%'),
    CPFHospede VARCHAR(11),
    FOREIGN KEY (NumeroQuarto)
        REFERENCES Quarto (Numero),
	FOREIGN KEY (CPFHospede)
        REFERENCES Hospede (CPF)
);

INSERT INTO Reserva (ID, Horario, DataR, Avaliacao, Valor, NumeroQuarto, Pagamento, CPFHospede) VALUES (1, '15:00:00', '2024-05-20 15:00:00', 5, 300.00, 101, '0%','15090344411');
INSERT INTO Reserva (ID, Horario, DataR, Avaliacao, Valor, NumeroQuarto, Pagamento, CPFHospede) VALUES (2, '16:00:00', '2024-05-21 16:00:00', 4, 450.00, 102, '100%','17123423455');
INSERT INTO Reserva (ID, Horario, DataR, Avaliacao, Valor, NumeroQuarto, Pagamento, CPFHospede) VALUES (3, '17:00:00', '2024-05-22 17:00:00', 3, 200.00, 103, '50%','19987680212');

CREATE TABLE Servico (
    ID INT PRIMARY KEY,
    Tipo VARCHAR(128)
);

INSERT INTO Servico (ID, Tipo) VALUES (1, 'Café da Manhã');
INSERT INTO Servico (ID, Tipo) VALUES (2, 'Lavanderia');
INSERT INTO Servico (ID, Tipo) VALUES (3, 'Transporte');

CREATE TABLE Contem (
    IDReserva INT,
    IDServico INT,
    FOREIGN KEY (IDReserva)
        REFERENCES Reserva (ID),
    FOREIGN KEY (IDServico)
        REFERENCES Servico (ID),
    PRIMARY KEY (IDReserva , IDServico)
);

INSERT INTO Contem (IDReserva, IDServico) VALUES (1, 1);
INSERT INTO Contem (IDReserva, IDServico) VALUES (1, 2);
INSERT INTO Contem (IDReserva, IDServico) VALUES (2, 1);

CREATE TABLE Departamento (
    ID INT PRIMARY KEY,
    Nome VARCHAR(64),
    DataAdmissao DATETIME
);

INSERT INTO Departamento (ID, Nome, DataAdmissao) VALUES (1, 'Limpeza', '2024-01-15');
INSERT INTO Departamento (ID, Nome, DataAdmissao) VALUES (2, 'Recepção', '2024-02-20');
INSERT INTO Departamento (ID, Nome, DataAdmissao) VALUES (3, 'Cozinha', '2024-03-25');

CREATE TABLE Funcionario (
    Registro INT PRIMARY KEY,
    Nome VARCHAR(64),
    Email VARCHAR(128),
    Telefone VARCHAR(15),
    ID_Departamento INT,
    Foreign key (ID_Departamento) references Departamento(ID)
);

INSERT INTO Funcionario (Registro, Nome, Email, Telefone, ID_Departamento) VALUES (1, 'Pedro Alvares', 'pedro.alvares@example.com', '992567383', 1);
INSERT INTO Funcionario (Registro, Nome, Email, Telefone, ID_Departamento) VALUES (2, 'Maria Pereira', 'maria.pereira@example.com', '984236171', 2);
INSERT INTO Funcionario (Registro, Nome, Email, Telefone, ID_Departamento) VALUES (3, 'João Almeida', 'joao.almeida@example.com', '999435262', 3);

CREATE TABLE Realiza (
    IDServico INT,
    IDRegistro INT,
    DataS DATE,
    FOREIGN KEY (IDServico)
        REFERENCES Servico (ID),
    FOREIGN KEY (IDRegistro)
        REFERENCES Funcionario (Registro),
    PRIMARY KEY (IDServico , IDRegistro)
);

INSERT INTO Realiza (IDServico, IDRegistro, Datas) VALUES (1, 1, '2024-10-09');
INSERT INTO Realiza (IDServico, IDRegistro, Datas) VALUES (2, 2, '2024-09-11');
INSERT INTO Realiza (IDServico, IDRegistro, Datas) VALUES (3, 3, '2024-06-12');

CREATE TABLE Camareira (
    RegistroFuncionario INT,
    QuartosAtribuidos VARCHAR(10),
    FOREIGN KEY (RegistroFuncionario)
        REFERENCES Funcionario (Registro),
    PRIMARY KEY (RegistroFuncionario)
);

INSERT INTO Camareira (RegistroFuncionario, QuartosAtribuidos) VALUES (1, '101, 102');

CREATE TABLE Cozinheiro (
    RegistroFuncionario INT,
    Especialidade VARCHAR(128),
    FOREIGN KEY (RegistroFuncionario)
        REFERENCES Funcionario (Registro),
    PRIMARY KEY (RegistroFuncionario)
);

INSERT INTO Cozinheiro (RegistroFuncionario, Especialidade) VALUES (2, 'Culinária Italiana');

CREATE TABLE Recepcionista (
    RegistroFuncionario INT,
    Turno ENUM('Dia', 'Noite'),
    FOREIGN KEY (RegistroFuncionario)
        REFERENCES Funcionario (Registro),
    PRIMARY KEY (RegistroFuncionario)
);

INSERT INTO Recepcionista (RegistroFuncionario, Turno) VALUES (3, 'Dia');
