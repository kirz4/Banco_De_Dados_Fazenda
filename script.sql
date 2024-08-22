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

-- Procedure para atualizar Estufa
DELIMITER //

CREATE PROCEDURE sp_AtualizarEstufa(
    IN estufaID INT,
    IN novaLocalizacao VARCHAR(100),
    IN novaTemperatura DECIMAL(5,2),
    IN novaUmidade DECIMAL(5,2),
    IN novoTamanho DECIMAL(5,2)
)
BEGIN
    DECLARE estufaExiste INT;

    -- Verifica se a estufa com o ID fornecido existe
    SELECT COUNT(*) INTO estufaExiste FROM Estufa WHERE ID_Estufa = estufaID;

    IF estufaExiste = 0 THEN
        -- Se a estufa não existir, retorna uma mensagem de erro
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A estufa com o ID fornecido não existe.';
    ELSE
        -- Atualiza as informações da estufa se ela existir
        UPDATE Estufa
        SET Localizacao = novaLocalizacao, 
            Temperatura = novaTemperatura, 
            Umidade = novaUmidade, 
            Tamanho = novoTamanho
        WHERE ID_Estufa = estufaID;

        -- Retorna uma mensagem confirmando a atualização
        SELECT CONCAT('A estufa com ID ', estufaID, ' foi atualizada com sucesso.') AS Mensagem;
    END IF;
END //

DELIMITER ;

-- Procedure para atualizar Lote
DELIMITER //

CREATE PROCEDURE sp_AtualizarLote(
    IN loteID INT,
    IN novaDataCriacao DATE,
    IN novoNumeroPlantas INT
)
BEGIN
    DECLARE loteExiste INT;

    -- Verifica se o lote com o ID fornecido existe
    SELECT COUNT(*) INTO loteExiste FROM Lote WHERE ID_Lote = loteID;

    IF loteExiste = 0 THEN
        -- Se o lote não existir, retorna uma mensagem de erro
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O lote com o ID fornecido não existe.';
    ELSE
        -- Atualiza as informações do lote se ele existir
        UPDATE Lote
        SET Data_Criacao = novaDataCriacao, 
            Numero_Plantas = novoNumeroPlantas
        WHERE ID_Lote = loteID;

        -- Retorna uma mensagem confirmando a atualização
        SELECT CONCAT('O lote com ID ', loteID, ' foi atualizado com sucesso.') AS Mensagem;
    END IF;
END //

DELIMITER ;

-- Procedure para atualizar Planta
DELIMITER //

CREATE PROCEDURE sp_AtualizarPlanta(
    IN plantaID INT,
    IN novaVariedade VARCHAR(100),
    IN novaDataPlantio DATE,
    IN novoEstagioCrescimento VARCHAR(100),
    IN novoIDLote INT,
    IN novoIDEstufa INT
)
BEGIN
    DECLARE plantaExiste INT;

    -- Verifica se a planta com o ID fornecido existe
    SELECT COUNT(*) INTO plantaExiste FROM Planta WHERE ID_Planta = plantaID;

    IF plantaExiste = 0 THEN
        -- Se a planta não existir, retorna uma mensagem de erro
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A planta com o ID fornecido não existe.';
    ELSE
        -- Atualiza as informações da planta se ela existir
        UPDATE Planta
        SET Variedade = novaVariedade, 
            Data_Plantio = novaDataPlantio, 
            Estagio_Crescimento = novoEstagioCrescimento, 
            ID_Lote = novoIDLote, 
            ID_Estufa = novoIDEstufa
        WHERE ID_Planta = plantaID;

        -- Retorna uma mensagem confirmando a atualização
        SELECT CONCAT('A planta com ID ', plantaID, ' foi atualizada com sucesso.') AS Mensagem;
    END IF;
END //

DELIMITER ;

-- Procedure para atualizar Colheita
DELIMITER //

CREATE PROCEDURE sp_AtualizarColheita(
    IN colheitaID INT,
    IN novaDataColheita DATE,
    IN novaQuantidadeColhida DECIMAL(10,2),
    IN novaQualidade VARCHAR(100),
    IN novoIDPlanta INT
)
BEGIN
    DECLARE colheitaExiste INT;

    -- Verifica se a colheita com o ID fornecido existe
    SELECT COUNT(*) INTO colheitaExiste FROM Colheita WHERE ID_Colheita = colheitaID;

    IF colheitaExiste = 0 THEN
        -- Se a colheita não existir, retorna uma mensagem de erro
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A colheita com o ID fornecido não existe.';
    ELSE
        -- Atualiza as informações da colheita se ela existir
        UPDATE Colheita
        SET Data_Colheita = novaDataColheita, 
            Quantidade_Colhida = novaQuantidadeColhida, 
            Qualidade = novaQualidade, 
            ID_Planta = novoIDPlanta
        WHERE ID_Colheita = colheitaID;

        -- Retorna uma mensagem confirmando a atualização
        SELECT CONCAT('A colheita com ID ', colheitaID, ' foi atualizada com sucesso.') AS Mensagem;
    END IF;
END //

DELIMITER ;