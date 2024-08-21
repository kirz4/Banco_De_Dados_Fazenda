CREATE DATABASE fazenda;
USE fazenda;

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    ID_Fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Contato VARCHAR(100),
    Tipo_Insumo VARCHAR(100)
);

-- Tabela Estufa
CREATE TABLE Estufa (
    ID_Estufa INT AUTO_INCREMENT PRIMARY KEY,
    Localizacao VARCHAR(100) NOT NULL,
    Temperatura DECIMAL(5,2),
    Umidade DECIMAL(5,2),
    Tamanho DECIMAL(5,2)
);

-- Tabela Lote
CREATE TABLE Lote (
    ID_Lote INT AUTO_INCREMENT PRIMARY KEY,
    Data_Criacao DATE,
    Numero_Plantas INT
);

-- Tabela Planta
CREATE TABLE Planta (
    ID_Planta INT AUTO_INCREMENT PRIMARY KEY,
    Variedade VARCHAR(100),
    Data_Plantio DATE,
    Estagio_Crescimento VARCHAR(100),
    ID_Lote INT,
    ID_Estufa INT,
    FOREIGN KEY (ID_Lote) REFERENCES Lote(ID_Lote),
    FOREIGN KEY (ID_Estufa) REFERENCES Estufa(ID_Estufa)
);

-- Tabela Colheita
CREATE TABLE Colheita (
    ID_Colheita INT AUTO_INCREMENT PRIMARY KEY,
    Data_Colheita DATE,
    Quantidade_Colhida DECIMAL(10,2),
    Qualidade VARCHAR(100),
    ID_Planta INT,
    FOREIGN KEY (ID_Planta) REFERENCES Planta(ID_Planta)
);

-- Tabela Equipamento
CREATE TABLE Equipamento (
    ID_Equipamento INT AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(100) NOT NULL,
    Estado_Conservacao VARCHAR(100),
    Data_Ultima_Manutencao DATE,
    ID_Estufa INT,
    FOREIGN KEY (ID_Estufa) REFERENCES Estufa(ID_Estufa)
);

-- Tabela Funcionario
CREATE TABLE Funcionario (
    ID_Funcionario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cargo VARCHAR(100),
    Horario_Trabalho VARCHAR(100),
    ID_Estufa INT,
    FOREIGN KEY (ID_Estufa) REFERENCES Estufa(ID_Estufa)
);

-- Tabela Insumos
CREATE TABLE Insumos (
    ID_Insumo INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade DECIMAL(10,2),
    Tipo VARCHAR(100),
    Data_Aplicacao DATE,
    ID_Fornecedor INT,
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor)
);

-- Tabela Comprador
CREATE TABLE Comprador (
    ID_Comprador INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Contato VARCHAR(100),
    ID_Lote INT,
    FOREIGN KEY (ID_Lote) REFERENCES Lote(ID_Lote)
);

-- Tabela Venda
CREATE TABLE Venda (
    ID_Venda INT AUTO_INCREMENT PRIMARY KEY,
    Data_Venda DATE,
    Quantidade DECIMAL(10,2),
    Preco DECIMAL(10,2),
    ID_Lote INT,
    ID_Comprador INT,
    FOREIGN KEY (ID_Lote) REFERENCES Lote(ID_Lote),
    FOREIGN KEY (ID_Comprador) REFERENCES Comprador(ID_Comprador)
);

-- Criação da View para combinar informações de Planta e Estufa
CREATE VIEW vw_PlantaEstufa AS
SELECT 
    p.ID_Planta, 
    p.Variedade, 
    e.Localizacao, 
    e.Temperatura
FROM 
    Planta p
JOIN 
    Estufa e ON p.ID_Estufa = e.ID_Estufa;

-- Criação da View para combinar informações de Planta e Lote
CREATE VIEW vw_PlantaLote AS
SELECT 
    p.ID_Planta, 
    p.Variedade, 
    l.ID_Lote, 
    l.Data_Criacao
FROM 
    Planta p
JOIN 
    Lote l ON p.ID_Lote = l.ID_Lote;

-- Procedure para Atualizar a Temperatura da Estufa
DELIMITER //

CREATE PROCEDURE sp_AtualizarTemperaturaEstufa(
    IN estufaID INT, 
    IN novaTemperatura DECIMAL(5,2)
)
BEGIN
    DECLARE estufaExiste INT;

    -- Verifica se a estufa com o ID fornecido existe
    SELECT COUNT(*) INTO estufaExiste FROM Estufa WHERE ID_Estufa = estufaID;

    IF estufaExiste = 0 THEN
        -- Se a estufa não existir, retorna uma mensagem de erro
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A estufa com o ID fornecido não existe.';
    ELSE
        -- Atualiza a temperatura da estufa se ela existir
        UPDATE Estufa
        SET Temperatura = novaTemperatura
        WHERE ID_Estufa = estufaID;

        -- Retorna uma mensagem confirmando a atualização
        SELECT CONCAT('A temperatura da estufa com ID ', estufaID, ' foi atualizada para ', novaTemperatura, '°C') AS Mensagem;
    END IF;
END //

DELIMITER ;


-- Procedure para Atualizar o Estágio de Crescimento da Planta

DELIMITER //

CREATE PROCEDURE sp_AtualizarEstagioCrescimento(
    IN plantaID INT, 
    IN novoEstagio VARCHAR(50)
)
BEGIN
    DECLARE plantaExiste INT;

    -- Verifica se a planta com o ID fornecido existe
    SELECT COUNT(*) INTO plantaExiste FROM Planta WHERE ID_Planta = plantaID;

    IF plantaExiste = 0 THEN
        -- Se a planta não existir, retorna uma mensagem de erro
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A planta com o ID fornecido não existe.';
    ELSE
        -- Atualiza o estágio de crescimento da planta se ela existir
        UPDATE Planta
        SET Estagio_Crescimento = novoEstagio
        WHERE ID_Planta = plantaID;

        -- Retorna uma mensagem confirmando a atualização
        SELECT CONCAT('O estágio de crescimento da planta com ID ', plantaID, ' foi atualizado para ', novoEstagio) AS Mensagem;
    END IF;
END //

DELIMITER ;
