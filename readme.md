<div align="center">

# ✨ Macario Beauty — Estúdio de Beleza
### Plataforma Web de Catálogo e Agendamento Online

[![Status](https://img.shields.io/badge/Status-Conclu%C3%ADdo-brightgreen?style=for-the-badge)]()
[![Java JSP](https://img.shields.io/badge/Java-JSP-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)]()
[![MySQL](https://img.shields.io/badge/MySQL-XAMPP-4479A1?style=for-the-badge&logo=mysql&logoColor=white)]()
[![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)]()
[![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)]()
[![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)]()

<p align="center">
  <a href="#-sobre-o-projeto">Sobre</a> •
  <a href="#-funcionalidades">Funcionalidades</a> •
  <a href="#-banco-de-dados">Banco de Dados</a> •
  <a href="#-estrutura-do-projeto">Estrutura</a> •
  <a href="#-como-executar">Como Executar</a> •
  <a href="#-autor">Autor</a>
</p>

</div>

---

## 💡 Sobre o Projeto

O **Macario Beauty** é uma aplicação web desenvolvida para atender uma demanda real de uma microempreendedora autônoma do setor de estética em **Guarulhos - SP** ([@_macariobeauty](https://www.instagram.com/_macariobeauty/)). 

Antes do sistema, todo o atendimento e agendamento dependiam exclusivamente de mensagens manuais em redes sociais, o que dificultava a organização da agenda em horários de pico e a consulta rápida de preços e durações pelos clientes. A plataforma centraliza o catálogo de serviços, automatiza o pré-agendamento online e oferece um painel administrativo para gestão dos horários.

> 🎓 **Contexto Acadêmico:** Projeto desenvolvido para a disciplina **Projeto de Extensão Web Standards** (2º Semestre) do curso de **Engenharia de Software** do **Centro Universitário ENIAC**.

---

## 🚀 Funcionalidades

- [x] **Página Inicial (`index.jsp`):** Apresentação institucional do estúdio, banner principal, destaques dos serviços e seção *Sobre Nós*.
- [x] **Catálogo Dinâmico (`servicos.jsp`):** Listagem de procedimentos carregada diretamente do MySQL com filtros interativos por categoria (*Todos, Unhas, Cílios e Sobrancelhas*).
- [x] **Agendamento Online (`agendar.jsp`):**
  - Validação completa dos campos no front-end com **JavaScript**;
  - Máscara automática para telefone/WhatsApp e bloqueio de datas passadas;
  - **Resumo Lateral Dinâmico** que atualiza valor, duração estimada, data e horário em tempo real conforme o usuário preenche o formulário;
  - Cadastro automático do cliente e gravação do agendamento no banco de dados.
- [x] **Fale Conosco (`contato.jsp`):** Canal de dúvidas com armazenamento das mensagens no banco de dados.
- [x] **Painel da Profissional (`admin.jsp`):** Área de gerenciamento onde a profissional visualiza todos os agendamentos e mensagens recebidas, podendo **Confirmar** ou **Cancelar** horários com atualização imediata no MySQL.

---

## 🗄️ Banco de Dados

O sistema utiliza o **MySQL** (via XAMPP / phpMyAdmin) com o banco de dados `macario_beauty`, estruturado em 4 tabelas relacionais:

<details>
<summary><b>Clique para expandir as tabelas do banco de dados</b></summary>
<br>

| Tabela | Descrição | Principais Campos |
| :--- | :--- | :--- |
| **`CLIENTES`** | Dados cadastrais das clientes | `id_cliente (PK)`, `nome`, `telefone`, `email` |
| **`SERVICOS`** | Catálogo de procedimentos | `id_servico (PK)`, `nome_servico`, `categoria`, `descricao`, `preco`, `duracao_min`, `imagem` |
| **`AGENDAMENTOS`** | Horários marcados e status | `id_agendamento (PK)`, `id_cliente (FK)`, `id_servico (FK)`, `data_agendamento`, `hora_agendamento`, `status`, `observacoes` |
| **`CONTATOS`** | Mensagens enviadas pelo site | `id_contato (PK)`, `nome`, `email`, `mensagem`, `data_envio` |

</details>

---

## 📂 Estrutura do Projeto

<details>
<summary><b>Clique para visualizar a árvore de arquivos</b></summary>
<br>

```text
MacarioBeauty/
├── database/
│   └── macario_beauty.sql          # Script de criação do banco e dados iniciais
├── WEB-INF/
│   ├── lib/
│   │   └── mysql-connector-j.jar   # Driver JDBC de conexão com o MySQL
│   └── web.xml                     # Configuração da aplicação Java Web
├── css/
│   └── style.css                   # Folha de estilos responsiva
├── js/
│   └── script.js                   # Validação de formulários e resumo dinâmico
├── img/                            # Imagens do estúdio e procedimentos
├── includes/
│   ├── conexao.jsp                 # Classe/método de conexão JDBC com o MySQL
│   ├── header.jsp                  # Cabeçalho e menu de navegação
│   └── footer.jsp                  # Rodapé institucional
├── index.jsp                       # Tela Home
├── servicos.jsp                    # Tela de Catálogo de Serviços
├── agendar.jsp                     # Tela de Agendamento
├── contato.jsp                     # Tela de Contato
└── admin.jsp                       # Tela do Painel Administrativo
```

</details>

---

## ⚙️ Como Executar o Projeto

### Pré-requisitos
- **XAMPP** (com **Apache**, **MySQL** e **Tomcat** instalados)
- **JDK (Java Development Kit)**
- **MySQL Connector/J** (`.jar`)

### Passo a Passo
1. **Clone ou baixe este repositório:**
   ```bash
   git clone https://github.com/SEU-USUARIO/MacarioBeauty.git
   ```
2. **Configure o Banco de Dados:**
   - Inicie os módulos **Apache** e **MySQL** no painel do XAMPP.
   - Acesse `http://localhost/phpmyadmin`, clique em **Importar** e execute o arquivo `database/macario_beauty.sql`.
3. **Configure o Servidor Tomcat:**
   - Certifique-se de que o arquivo `mysql-connector-j.jar` esteja dentro de `MacarioBeauty/WEB-INF/lib/`.
   - Coloque a pasta `MacarioBeauty` dentro de `C:\xampp\tomcat\webapps\`.
   - Inicie o módulo **Tomcat** no painel do XAMPP.
4. **Acesse no Navegador:**
   - Abra `http://localhost:8080/MacarioBeauty/`

---

## 👨‍💻 Autor

<div align="center">

**Luís Miguel dos Santos Morais**  
- Engenharia de Software -  
Centro Universitário ENIAC • Guarulhos - SP  
**Professor Orientador:** Prof. Lucio Luzetti

</div>