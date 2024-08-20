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
