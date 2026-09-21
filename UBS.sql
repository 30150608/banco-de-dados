CREATE DATABASE UBS;
USE UBS;

-- TABELA: TELEFONE

CREATE TABLE Telefone (
Telefone_PK INT NOT NULL AUTO_INCREMENT,
Telefone VARCHAR(20) NOT NULL,
fk_Paciente_CPF VARCHAR(14) NOT NULL,

PRIMARY KEY (Telefone_PK),

CONSTRAINT FK_Telefone_Paciente
    FOREIGN KEY (fk_Paciente_CPF)
    REFERENCES Paciente(CPF)
);

-- TABELA: PACIENTE

CREATE TABLE Paciente (
CPF VARCHAR(14) NOT NULL,
Nome VARCHAR(100),
Sexo ENUM('Feminino', 'Masculino'),
Dt_nascimento DATE,
Endereco VARCHAR(150),F
CEP VARCHAR(9),

PRIMARY KEY (CPF),

CONSTRAINT FK_Paciente_Telefone
    FOREIGN KEY (Telefone_FK)
    REFERENCES Telefone(Telefone_PK)

);


-- TABELA: PRONTUARIO

CREATE TABLE Prontuario (
Nr_prontuario INT NOT NULL AUTO_INCREMENT,
Dt_abertura DATE,
Descricao VARCHAR(255),
fk_Paciente_CPF VARCHAR(14) NOT NULL,

PRIMARY KEY (Nr_prontuario),
UNIQUE (fk_Paciente_CPF),

CONSTRAINT FK_Prontuario_Paciente
    FOREIGN KEY (fk_Paciente_CPF)
    REFERENCES Paciente(CPF)

);

-- TABELA: CONTATO DE EMERGENCIA

CREATE TABLE Contato_de_Emergencia (
fk_Paciente_CPF VARCHAR(14) NOT NULL,
Nr_ordem INT NOT NULL,
Nome VARCHAR(100) NOT NULL,
Telefone VARCHAR(20) NOT NULL,
Parentesco VARCHAR(50) NOT NULL,

PRIMARY KEY (fk_Paciente_CPF, Nr_ordem),

CONSTRAINT FK_Contato_Paciente
    FOREIGN KEY (fk_Paciente_CPF)
    REFERENCES Paciente(CPF)
);

-- TABELA: PCD

CREATE TABLE PCD (
Nome_adversidade VARCHAR(150),
Acompanhante VARCHAR(100),
fk_Paciente_CPF VARCHAR(14) NOT NULL,

PRIMARY KEY (fk_Paciente_CPF),

CONSTRAINT FK_PCD_Paciente
    FOREIGN KEY (fk_Paciente_CPF)
    REFERENCES Paciente(CPF)

);

-- TABELA: GESTANTE

CREATE TABLE Gestante (
Dt_do_parto DATE,
Semanas_de_gestacao INT,
fk_Paciente_CPF VARCHAR(14) NOT NULL,

PRIMARY KEY (fk_Paciente_CPF),

CONSTRAINT FK_Gestante_Paciente
    FOREIGN KEY (fk_Paciente_CPF)
    REFERENCES Paciente(CPF)

);

-- TABELA: LISTA DE ESPERA

CREATE TABLE Lista_de_Espera (
Nr_Lista INT NOT NULL AUTO_INCREMENT,
Dt_hr_entrada DATETIME NOT NULL,
Posicao_lista INT NOT NULL,
Preferencial ENUM('PCD', 'Gestante', 'Idoso 60+'),
Status ENUM(
'Atendido',
'Em espera',
'Aguardando avaliacao'
) NOT NULL,

PRIMARY KEY (Nr_Lista)

);

-- TABELA: TRIAGEM

CREATE TABLE Triagem (
Gravidade VARCHAR(50) NOT NULL,
Tempo TIME NOT NULL,
fk_Lista_Nr_Lista INT NOT NULL,

PRIMARY KEY (fk_Lista_Nr_Lista),

CONSTRAINT FK_Triagem_Lista
    FOREIGN KEY (fk_Lista_Nr_Lista)
    REFERENCES Lista_de_Espera(Nr_Lista)
);

-- TABELA: SINTOMA

CREATE TABLE Sintoma (
Id_sintoma INT NOT NULL AUTO_INCREMENT,
Sintoma VARCHAR(100),
Descricao VARCHAR(255),

PRIMARY KEY (Id_sintoma)

);

-- TABELA: CLASSIFICACAO DE RISCO

CREATE TABLE Classificacao_de_Risco (
Id_risco INT NOT NULL AUTO_INCREMENT,
Prioridade ENUM('alta', 'media', 'baixa'),
Cor ENUM('Vermelho', 'Amarelo', 'Verde'),

PRIMARY KEY (Id_risco)

);

-- RELACIONAMENTO: ENTRA_NA

CREATE TABLE Entra_na (
fk_Lista_Nr_Lista INT NOT NULL,
fk_Paciente_CPF VARCHAR(14) NOT NULL,

PRIMARY KEY (fk_Lista_Nr_Lista),

CONSTRAINT FK_Entra_Lista
    FOREIGN KEY (fk_Lista_Nr_Lista)
    REFERENCES Lista_de_Espera(Nr_Lista),
    
CONSTRAINT FK_Entra_Paciente
    FOREIGN KEY (fk_Paciente_CPF)
    REFERENCES Paciente(CPF)

);

-- RELACIONAMENTO: CONTEM

CREATE TABLE Contem (
fk_Triagem_Lista_Nr_Lista INT NOT NULL,
fk_Sintoma_Id_sintoma INT NOT NULL,

PRIMARY KEY (fk_Triagem_Lista_Nr_Lista, fk_Sintoma_Id_sintoma),

CONSTRAINT FK_Contem_Triagem
    FOREIGN KEY (fk_Triagem_Lista_Nr_Lista)
    REFERENCES Triagem(fk_Lista_Nr_Lista),

CONSTRAINT FK_Contem_Sintoma
    FOREIGN KEY (fk_Sintoma_Id_sintoma)
    REFERENCES Sintoma(Id_sintoma)
);
-- RELACIONAMENTO: DETERMINA

CREATE TABLE Determina (
fk_Triagem_Lista_Nr_Lista INT NOT NULL,
fk_Classificacao_Id_risco INT NOT NULL,

PRIMARY KEY (fk_Triagem_Lista_Nr_Lista),

CONSTRAINT FK_Determina_Triagem
    FOREIGN KEY (fk_Triagem_Lista_Nr_Lista)
    REFERENCES Triagem(fk_Lista_Nr_Lista),

CONSTRAINT FK_Determina_Risco
    FOREIGN KEY (fk_Classificacao_Id_risco)
    REFERENCES Classificacao_de_Risco(Id_risco)
);

USE UBS;

INSERT INTO Telefone (Telefone) VALUES
('(61) 99111-0001'),
('(61) 99111-0002'),
('(61) 99111-0003'),
('(61) 99111-0004'),
('(61) 99111-0005'),
('(61) 99111-0006'),
('(61) 99111-0007'),
('(61) 99111-0008'),
('(61) 99111-0009'),
('(61) 99111-0010');

INSERT INTO Paciente (CPF, Nome, Sexo, Dt_nascimento, Endereco, CEP, Telefone_FK) VALUES
('111.111.111-11', 'Mariana Souza Lima',       'Feminino',  '1995-03-12', 'Rua das Flores, 120',      '70000-001', 1),
('222.222.222-22', 'Carlos Eduardo Pereira',   'Masculino', '1988-07-22', 'Avenida Central, 450',     '70000-002', 2),
('333.333.333-33', 'Juliana Ferreira Costa',   'Feminino',  '1992-11-05', 'Rua do Comércio, 89',      '70000-003', 3),
('444.444.444-44', 'José Antônio Ribeiro',     'Masculino', '1950-02-18', 'Rua das Palmeiras, 32',    '70000-004', 4),
('555.555.555-55', 'Maria das Graças Oliveira','Feminino',  '1958-09-30', 'Travessa da Paz, 15',      '70000-005', 5),
('666.666.666-66', 'Lucas Almeida Santos',     'Masculino', '2001-01-25', 'Rua dos Ipês, 210',        '70000-006', 6),
('777.777.777-77', 'Fernanda Rocha Martins',   'Feminino',  '1999-06-14', 'Avenida Brasil, 780',      '70000-007', 7),
('888.888.888-88', 'Pedro Henrique Nunes',     'Masculino', '1985-12-03', 'Rua Sete de Setembro, 66', '70000-008', 8),
('999.999.999-99', 'Camila Barbosa Dias',      'Feminino',  '1994-04-19', 'Rua das Acácias, 301',     '70000-009', 9),
('101.010.101-01', 'Rafael Mendes Carvalho',   'Masculino', '1979-08-08', 'Alameda dos Anjos, 54',    '70000-010', 10);

INSERT INTO Prontuario (Dt_abertura, Descricao, fk_Paciente_CPF) VALUES
('2026-01-10', 'Acompanhamento pré-natal',               '111.111.111-11'),
('2026-02-05', 'Paciente cadeirante em acompanhamento',  '222.222.222-22'),
('2026-02-18', 'Paciente com deficiência visual',        '333.333.333-33'),
('2026-03-02', 'Idoso com hipertensão',                  '444.444.444-44'),
('2026-03-15', 'Idosa com diabetes',                     '555.555.555-55'),
('2026-04-01', 'Consulta de rotina',                     '666.666.666-66'),
('2026-04-20', 'Queixa de dor de garganta',              '777.777.777-77'),
('2026-05-08', 'Consulta de rotina',                     '888.888.888-88'),
('2026-06-12', 'Queixa de dor de cabeça frequente',      '999.999.999-99'),
('2026-07-07', 'Consulta de rotina',                     '101.010.101-01');

INSERT INTO Contato_de_Emergencia (Telefone, Nome, Parentesco, Nr_ordem, fk_Paciente_CPF) VALUES
('(61)97468-3986', 'Ricardo Lima',      'Esposo', 1, '111.111.111-11'),
('(61)90084-3675', 'Ana Pereira',       'Mãe',    1, '222.222.222-22'),
('(61)93573-6674', 'Roberto Costa',     'Pai',    1, '333.333.333-33'),
('(61)99466-7530', 'Helena Ribeiro',    'Filha',  1, '444.444.444-44'),
('(61)98049-9736', 'Paulo Oliveira',    'Filho',  1, '555.555.555-55');

INSERT INTO PCD (Nome_adversidade, Acompanhante, fk_Paciente_CPF) VALUES
('Deficiência física (cadeirante)', 'Ana Pereira',   '222.222.222-22'),
('Deficiência visual',              'Roberto Costa', '333.333.333-33');

INSERT INTO Gestante (Dt_do_parto, Semanas_de_gestacao, fk_Paciente_CPF) VALUES
('2026-11-20', 32, '111.111.111-11');

INSERT INTO Lista_de_Espera (Dt_hr_entrada, Posicao_lista, Preferencial, Status) VALUES
('2026-09-20 08:00:00', 1,  'Gestante',  'Em espera'),
('2026-09-20 08:10:00', 2,  'PCD',       'Em espera'),
('2026-09-20 08:15:00', 3,  'PCD',       'Atendido'),
('2026-09-20 08:20:00', 4,  'Idoso 60+', 'Em espera'),
('2026-09-20 08:30:00', 5,  'Idoso 60+', 'Aguardando avaliacao'),
('2026-09-20 08:05:00', 6,  NULL,        'Atendido'),
('2026-09-20 08:25:00', 7,  NULL,        'Em espera'),
('2026-09-20 08:35:00', 8,  NULL,        'Aguardando avaliacao'),
('2026-09-20 08:40:00', 9,  NULL,        'Em espera'),
('2026-09-20 08:45:00', 10, NULL,        'Aguardando avaliacao');

INSERT INTO Triagem (Gravidade, Tempo, fk_Lista_Nr_Lista) VALUES
('Media', '00:05:00', 1),
('Baixa', '00:04:00', 2),
('Baixa', '00:06:00', 3),
('Alta',  '00:03:00', 4),
('Baixa', '00:05:00', 6),
('Media', '00:07:00', 7),
('Baixa', '00:04:00', 9);

INSERT INTO Sintoma (Sintoma, Descricao) VALUES
('Febre',          'Temperatura corporal acima de 37,8 °C'),
('Dor de cabeça',  'Dor na região da cabeça'),
('Falta de ar',    'Dificuldade para respirar'),
('Dor abdominal',  'Dor na região do abdômen'),
('Tosse',          'Tosse seca ou com secreção'),
('Tontura',        'Sensação de desequilíbrio'),
('Dor no peito',   'Dor ou pressão na região do tórax'),
('Náusea',         'Enjoo com ou sem vômito');

INSERT INTO Classificacao_de_Risco (Prioridade, Cor) VALUES
('alta',  'Vermelho'),
('media', 'Amarelo'),
('baixa', 'Verde');

INSERT INTO Entra_na (fk_Lista_Nr_Lista, fk_Paciente_CPF) VALUES
(1,  '111.111.111-11'),
(2,  '222.222.222-22'),
(3,  '333.333.333-33'),
(4,  '444.444.444-44'),
(5,  '555.555.555-55'),
(6,  '666.666.666-66'),
(7,  '777.777.777-77'),
(8,  '888.888.888-88'),
(9,  '999.999.999-99'),
(10, '101.010.101-01');

INSERT INTO Contem (fk_Lista_Nr_Lista, fk_Sintoma_Id_sintoma) VALUES
(1, 4),
(1, 8),
(2, 2),
(3, 6),
(4, 7),
(4, 3),
(5, 6),
(6, 5),
(7, 1),
(7, 5),
(8, 4),
(9, 2),
(10, 8);

INSERT INTO Determina (fk_Lista_Nr_Lista, fk_Classificacao_Id_risco) VALUES
(1, 2),
(2, 3),
(3, 3),
(4, 1),
(6, 3),
(7, 2),
(9, 3);

SELECT * FROM Telefone;

SELECT * FROM Paciente;

SELECT * FROM Paciente WHERE Sexo = 'Feminino';

SELECT * FROM Paciente WHERE Dt_nascimento <= '1966-09-20';

SELECT * FROM Prontuario;

SELECT * FROM Prontuario WHERE fk_Paciente_CPF = '111.111.111-11';

SELECT * FROM Contato_de_Emergencia;

SELECT * FROM PCD;

SELECT * FROM Gestante;

SELECT * FROM Lista_de_Espera;

SELECT * FROM Lista_de_Espera WHERE Status = 'Em espera';

SELECT * FROM Lista_de_Espera WHERE Preferencial IS NOT NULL;

SELECT * FROM Triagem;

SELECT * FROM Triagem WHERE Gravidade = 'Alta';

SELECT * FROM Sintoma;

SELECT * FROM Classificacao_de_Risco;

SELECT * FROM Classificacao_de_Risco WHERE Prioridade = 'alta';

SELECT * FROM Entra_na;

SELECT * FROM Contem;

SELECT * FROM Determina;

UPDATE Paciente
SET Endereco = 'Rua Nova, 500'
WHERE CPF = '666.666.666-66';

UPDATE Telefone
SET Telefone = '(61) 99999-0000'
WHERE Telefone_PK = 6;

UPDATE Prontuario
SET Descricao = 'Retorno para consulta de acompanhamento'
WHERE Nr_prontuario = 6;

UPDATE Gestante
SET Semanas_de_gestacao = 33
WHERE fk_Paciente_CPF = '111.111.111-11';

UPDATE PCD
SET Acompanhante = 'Marcos Pereira'
WHERE fk_Paciente_CPF = '222.222.222-22';

UPDATE Lista_de_Espera
SET Status = 'Atendido'
WHERE Nr_Lista = 1;

UPDATE Lista_de_Espera
SET Status = 'Em espera'
WHERE Nr_Lista = 5;

UPDATE Triagem
SET Gravidade = 'Media'
WHERE fk_Lista_Nr_Lista = 2;

UPDATE Sintoma
SET Descricao = 'Dor de cabeça leve ou intensa'
WHERE Id_sintoma = 2;

UPDATE Classificacao_de_Risco
SET Cor = 'Amarelo'
WHERE Id_risco = 2;
