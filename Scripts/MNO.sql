-- Criação da tabela Usuario
CREATE TABLE Usuario (
    CPF CHAR(11) PRIMARY KEY,
    Email VARCHAR(255) NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Senha VARCHAR(255) NOT NULL,
    Telefone VARCHAR(15) NOT NULL
);

-- Criação da tabela Atividade (com Nome e Descricao)
CREATE TABLE Atividade (
    ID_Atividade INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Descricao TEXT NOT NULL,
    Horario TIME NOT NULL,
    Local VARCHAR(255) NOT NULL
);

-- Criação da tabela Participa (relacionamento)
CREATE TABLE Participa (
    CPF CHAR(11),
    ID_Atividade INT,
    PRIMARY KEY (CPF, ID_Atividade),
    FOREIGN KEY (CPF) REFERENCES Usuario(CPF),
    FOREIGN KEY (ID_Atividade) REFERENCES Atividade(ID_Atividade)
);

-- Inserção de dados na tabela Usuario
INSERT INTO Usuario (CPF, Email, Nome, Data_Nascimento, Senha, Telefone) VALUES
('12345678901', 'ana.silva@email.com', 'Ana Silva', '1990-05-20', 'senha123', '11999999999'),
('98765432100', 'joao.pereira@email.com', 'João Pereira', '1985-08-15', 'senha456', '11888888888'),
('45678912300', 'maria.souza@email.com', 'Maria Souza', '1992-12-10', 'senha789', '11777777777');

-- Inserção de dados na tabela Atividade
INSERT INTO Atividade (Nome, Descricao, Horario, Local) VALUES
('Plantio de Árvores', 'Evento de plantio de mudas nativas para recuperação ambiental.', '10:00:00', 'Praça Central'),
('Palestra sobre Sustentabilidade', 'Palestra sobre práticas sustentáveis no ambiente corporativo.', '14:00:00', 'Auditório Empresa'),
('Limpeza de Parque', 'Mutirão para limpeza e revitalização do parque municipal.', '09:00:00', 'Parque Municipal');

-- Inserção de dados na tabela Participa
INSERT INTO Participa (CPF, ID_Atividade) VALUES
('12345678901', 1),
('98765432100', 2),
('45678912300', 3),
('12345678901', 2);

-- 1. Filtrar registros com WHERE: Usuários nascidos após 1990
SELECT * FROM Usuario 
WHERE Data_Nascimento > '1990-01-01';

-- 2. Ordenar resultados com ORDER BY: Atividades por horário
SELECT Nome, Horario FROM Atividade 
ORDER BY Horario DESC;

-- 3. Agrupar registros com GROUP BY: Contar participantes por atividade
SELECT ID_Atividade, COUNT(CPF) AS Total_Participantes 
FROM Participa 
GROUP BY ID_Atividade;

-- 4. Usar JOIN: Listar usuários e atividades nas quais participam
SELECT Usuario.Nome, Atividade.Nome AS Atividade 
FROM Participa
JOIN Usuario ON Participa.CPF = Usuario.CPF
JOIN Atividade ON Participa.ID_Atividade = Atividade.ID_Atividade;

-- 5. Usar IN: Encontrar usuários que participam de atividades específicas
SELECT Nome FROM Usuario 
WHERE CPF IN (SELECT CPF FROM Participa WHERE ID_Atividade IN (1, 2));

-- 6. Usar LIKE: Encontrar atividades que contenham "Sustentabilidade"
SELECT * FROM Atividade 
WHERE Nome LIKE '%Sustentabilidade%';

-- 7. Usar BETWEEN: Filtrar atividades entre 09:00 e 12:00
SELECT * FROM Atividade 
WHERE Horario BETWEEN '09:00:00' AND '12:00:00';

-- 8. Funções de agregação: Contar o número total de usuários
SELECT COUNT(*) AS Total_Usuarios FROM Usuario;

-- 9. Inserir usando SELECT: Ana Silva participando de outra atividade
INSERT INTO Participa (CPF, ID_Atividade)
SELECT CPF, 3 FROM Usuario WHERE Nome = 'Ana Silva';
