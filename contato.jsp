<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/conexao.jsp" %>
<%@ include file="includes/header.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    String msgContatoOk = null;
    String msgContatoErro = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String mensagem = request.getParameter("mensagem");

        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConexao();
            ps = conn.prepareStatement("INSERT INTO CONTATOS (nome, email, mensagem) VALUES (?, ?, ?)");
            ps.setString(1, nome);
            ps.setString(2, email);
            ps.setString(3, mensagem);
            ps.executeUpdate();
            msgContatoOk = "Mensagem enviada com sucesso! Em breve a equipe Macario Beauty responderá no seu e-mail.";
        } catch (Exception e) {
            msgContatoErro = "Erro ao enviar mensagem: " + e.getMessage();
        } finally {
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }
%>

<main>
    <section class="page-banner">
        <div class="container">
            <h1>Fale Conosco</h1>
            <p>Tire suas dúvidas sobre procedimentos, pacotes ou horários especiais.</p>
        </div>
    </section>

    <section class="section">
        <div class="container booking-grid">
            <div class="form-card">
                <h2>Envie uma Mensagem</h2>
                <% if (msgContatoOk != null) { %>
                    <div class="alert alert-success"><%= msgContatoOk %></div>
                <% } %>
                <% if (msgContatoErro != null) { %>
                    <div class="alert alert-error"><%= msgContatoErro %></div>
                <% } %>

                <form id="formContato" method="POST" action="contato.jsp">
                    <div class="form-group">
                        <label for="nomeContato">Seu Nome *</label>
                        <input type="text" id="nomeContato" name="nome" required placeholder="Como podemos te chamar?">
                    </div>
                    <div class="form-group">
                        <label for="emailContato">Seu E-mail *</label>
                        <input type="email" id="emailContato" name="email" required placeholder="seuemail@exemplo.com">
                    </div>
                    <div class="form-group">
                        <label for="mensagemContato">Mensagem *</label>
                        <textarea id="mensagemContato" name="mensagem" rows="4" required placeholder="Escreva sua dúvida ou solicitação..."></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Enviar Mensagem</button>
                </form>
            </div>

            <aside class="summary-card">
                <h3>Informações do Estúdio</h3>
                <div class="summary-divider"></div>
                <p><strong>Endereço:</strong><br>Guarulhos - São Paulo, SP</p>
                <p style="margin-top: 12px;"><strong>Horário de Funcionamento:</strong><br>Segunda a Sábado: 09h00 às 19h00</p>
                <p style="margin-top: 12px;"><strong>WhatsApp:</strong><br>(11) 99999-9999</p>
                <p style="margin-top: 12px;"><strong>Instagram:</strong><br>
                    <a href="https://www.instagram.com/_macariobeauty/" target="_blank" rel="noopener noreferrer" class="card-link">@_macariobeauty</a>
                </p>
            </aside>
        </div>
    </section>
</main>

<%@ include file="includes/footer.jsp" %>
