CREATE DATABASE IF NOT EXISTS macario_beauty
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE macario_beauty;

-- Tabela 1: CLIENTES
CREATE TABLE IF NOT EXISTS CLIENTES (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Tabela 2: SERVICOS
CREATE TABLE IF NOT EXISTS SERVICOS (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome_servico VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    duracao_min INT NOT NULL,
    imagem VARCHAR(120) DEFAULT 'img/unhas-simples.jpg'
);

-- Tabela 3: AGENDAMENTOS
CREATE TABLE IF NOT EXISTS AGENDAMENTOS (
    id_agendamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_servico INT NOT NULL,
    data_agendamento DATE NOT NULL,
    hora_agendamento TIME NOT NULL,
    status VARCHAR(30) DEFAULT 'Pendente',
    observacoes TEXT,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTES(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_servico) REFERENCES SERVICOS(id_servico) ON DELETE CASCADE
);

-- Tabela 4: CONTATOS
CREATE TABLE IF NOT EXISTS CONTATOS (
    id_contato INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    mensagem TEXT NOT NULL,
    data_envio DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Inserção inicial dos serviços da Macario Beauty
INSERT INTO SERVICOS (nome_servico, categoria, descricao, preco, duracao_min, imagem) VALUES
('Manicure Simples', 'Unhas', 'Cutilagem detalhada, hidratação e esmaltação tradicional com acabamento impecável.', 35.00, 45, 'img/unhas-simples.jpg'),
('Alongamento em Gel', 'Unhas', 'Alongamento resistente com naturalidade, curvatura perfeita e esmaltação em gel.', 130.00, 120, 'img/unhas-gel.jpg'),
('Pedicure & Spa dos Pés', 'Unhas', 'Esfoliação relaxante, hidratação profunda, cutilagem e esmaltação.', 45.00, 50, 'img/pedicure.jpg'),
('Extensão de Cílios', 'Cílios', 'Aplicação fio a fio ou volume brasileiro para realçar o olhar com leveza e durabilidade.', 140.00, 110, 'img/cilios-extensao.jpg'),
('Lash Lifting', 'Cílios', 'Curvatura, alinhamento e nutrição dos cílios naturais sem necessidade de manutenção.', 95.00, 60, 'img/lash-lifting.jpg'),
('Design de Sobrancelhas', 'Sobrancelhas', 'Mapeamento facial personalizado com alinhamento estratégico e aplicação opcional de henna.', 50.00, 40, 'img/sobrancelhas.jpg');

-- Clientes e agendamentos iniciais para demonstração no Painel Administrativo
INSERT INTO CLIENTES (nome, telefone, email) VALUES
('Mariana Souza', '(11) 99999-0001', 'mariana.souza@email.com'),
('Beatriz Lima', '(11) 99999-0002', 'beatriz.lima@email.com'),
('Camila Rocha', '(11) 99999-0003', 'camila.rocha@email.com');

INSERT INTO AGENDAMENTOS (id_cliente, id_servico, data_agendamento, hora_agendamento, status, observacoes) VALUES
(1, 1, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '14:00:00', 'Pendente', 'Preferência por esmalte nude rosado.'),
(2, 4, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '15:30:00', 'Confirmado', 'Primeira vez fazendo extensão.'),
(3, 6, DATE_ADD(CURDATE(), INTERVAL 2 DAY), '10:00:00', 'Pendente', 'Design com henna castanho médio.');
