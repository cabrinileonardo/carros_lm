-- Criando o banco de dados
create database if not exists carros_lm; 

-- Usando banco de dados
use carros_lm;

-- Criando as tabelas

-- 1. Clientes
create table clientes (
	id_cliente int auto_increment primary key,
    nome_cliente varchar(50) not null,
    cpf_cnpj varchar(14) not null,
    telefone varchar(11),
    cep varchar(8),
    email varchar(50),
    status boolean
);

-- 2. Cargos
create table cargos (
	id_cargo int auto_increment primary key,
    texto varchar(30)
);

-- 3. funcionarios
create table funcionarios (
	id_funcionario	int auto_increment primary key,
    nome_func varchar(50) not null,
    id_cargo int not null,
    cpf varchar(11) not null,
    telefone varchar(11),
    admissao date,
    foreign key(id_cargo) references cargos(id_cargo)
    );

-- 4. marcas
create table marcas (
	id_marca int auto_increment primary key,
    nome_marca varchar(30)
);

-- 5. modelos
create table modelos (
	id_modelo int auto_increment primary key,
    id_marca int not null,
    nome_modelo varchar(40),
    ano_modelo year,
    foreign key(id_marca) references marcas(id_marca)
);

-- 6. veículos
CREATE TABLE veiculos (
    id_veiculo INT NOT NULL AUTO_INCREMENT,
    id_modelo INT NOT NULL,
    placa VARCHAR(10) NOT NULL UNIQUE,
    chassi VARCHAR(17) NOT NULL UNIQUE,
    cor VARCHAR(30) NOT NULL,
    quilometragem INT NOT NULL,
    preco_custo DECIMAL(10,2) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Disponivel', -- Disponivel, Reservado, Vendido
    PRIMARY KEY (id_veiculo),
    FOREIGN KEY (id_modelo) REFERENCES modelos(id_modelo)
);

-- 7.vendas
CREATE TABLE vendas (
    id_venda INT NOT NULL AUTO_INCREMENT,
    id_veiculo INT NOT NULL UNIQUE, -- Garante que um veículo específico só seja vendido uma vez
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_venda),
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

-- 8. pagamentos
CREATE TABLE pagamentos (
    id_pagamento INT NOT NULL AUTO_INCREMENT,
    id_venda INT NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL, 
    valor_pago DECIMAL(10,2) NOT NULL,
    status_pagamento VARCHAR(20) DEFAULT 'Pendente', 
    PRIMARY KEY (id_clientesclientespagamento),
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda)
);

-- insert nas tabelas

-- 1. Clientes
INSERT INTO clientes (nome_cliente, cpf_cnpj, telefone, cep, email, ativo) VALUES
('Carlos Silva', '12345678901', '11999998888', '01001000', 'carlos.silva@email.com', true),
('Ana Beatriz Souza', '98765432100', '21988887777', '20040000', 'ana.souza@email.com', true),
('Marcos Rocha', '45678912344', '31977776666', '30110002', 'marcos.rocha@email.com', true);

-- 2. Cargos
INSERT INTO cargos (texto) VALUES
('Vendedor'),
('Gerente de Vendas'),
('Diretor');

-- 3. Funcionários
INSERT INTO funcionarios (nome_func, id_cargo, cpf, telefone, admissao) VALUES
('Roberto Oliveira', 1, '11122233344', '11966665555', '2024-01-15'),
('Juliana Costa', 2, '55566677788', '11955554444', '2022-06-10'),
('Lucas Mendes', 1, '99988877766', '21944443333', '2025-03-01');

-- 4. Marcas
INSERT INTO marcas (nome_marca) VALUES
('Toyota'),
('Chevrolet'),
('Volkswagen'),
('Ford');

-- 5. Modelos
INSERT INTO modelos (id_marca, nome_modelo, ano_modelo) VALUES
(1, 'Corolla XEI', 2023),
(2, 'Onix Premier', 2022),
(3, 'Gol GTI', 1994),
(4, 'Mustang GT', 2024);

-- 6. Veículos (Estoque)
INSERT INTO veiculos (id_modelo, placa, chassi, cor, quilometragem, preco_custo, preco_venda, status) VALUES
(1, 'ABC1D23', '9BW123456789ABCDE', 'Prata', 15000, 110000.00, 125000.00, 'Vendido'),
(2, 'XYZ9H87', '9BW987654321XYZAB', 'Preto', 28000, 70000.00, 79900.00, 'Disponivel'),
(3, 'AAA0A00', '9BW11111111111111', 'Vermelho', 120000, 45000.00, 65000.00, 'Reservado'),
(4, 'MUS1G24', '9BW44444444444444', 'Azul', 2000, 420000.00, 485000.00, 'Vendido');

-- 7. Vendas
-- Nota: O id_veiculo precisa ser ÚNICO por venda conforme sua regra.
INSERT INTO vendas (id_veiculo, id_cliente, id_funcionario, data_venda, valor_total) VALUES
(1, 1, 1, '2026-08-10 14:30:00', 125000.00), -- Carlos comprou o Corolla com o Roberto
(4, 2, 3, '2026-09-15 10:15:00', 485000.00); -- Ana comprou o Mustang com o Lucas

-- 8. Pagamentos
INSERT INTO pagamentos (id_venda, forma_pagamento, valor_pago, status_pagamento) VALUES
(1, 'Pix', 50000.00, 'Aprovado'),          -- Entrada do Corolla via Pix
(1, 'Financiamento', 75000.00, 'Aprovado'), -- Restante do Corolla financiado
(2, 'A vista', 485000.00, 'Aprovado');      -- Pagamento integral do Mustang
