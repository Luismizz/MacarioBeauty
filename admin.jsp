<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="includes/conexao.jsp" %>
<%@ include file="includes/header.jsp" %>

<%
    String acao = request.getParameter("acao");
    String idParam = request.getParameter("id");
    String feedbackAdmin = null;

    if (acao != null && idParam != null) {
        Connection connAcao = null;
        PreparedStatement psAcao = null;
        try {
            connAcao = getConexao();
            int idAg = Integer.parseInt(idParam);
            if ("confirmar".equals(acao)) {
                psAcao = connAcao.prepareStatement("UPDATE AGENDAMENTOS SET status = 'Confirmado' WHERE id_agendamento = ?");
                psAcao.setInt(1, idAg);
                psAcao.executeUpdate();
                feedbackAdmin = "Agendamento #" + idAg + " confirmado com sucesso!";
            } else if ("cancelar".equals(acao)) {
                psAcao = connAcao.prepareStatement("UPDATE AGENDAMENTOS SET status = 'Cancelado' WHERE id_agendamento = ?");
                psAcao.setInt(1, idAg);
                psAcao.executeUpdate();
                feedbackAdmin = "Agendamento #" + idAg + " marcado como cancelado.";
            }
        } catch (Exception e) {
            feedbackAdmin = "Erro ao atualizar status: " + e.getMessage();
        } finally {
            if (psAcao != null) try { psAcao.close(); } catch (Exception ignored) {}
            if (connAcao != null) try { connAcao.close(); } catch (Exception ignored) {}
        }
    }
%>

<main>
    <section class="page-banner">
        <div class="container">
            <h1>Painel Administrativo</h1>
            <p>Gerenciamento de Agendamentos e Mensagens — Macario Beauty</p>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <% if (feedbackAdmin != null) { %>
                <div class="alert alert-success"><%= feedbackAdmin %></div>
            <% } %>

            <div class="admin-header-bar">
                <h2>Agendamentos Recebidos</h2>
                <a href="agendar.jsp" class="btn btn-primary">+ Novo Agendamento</a>
            </div>

            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Cliente</th>
                            <th>Serviço</th>
                            <th>Data / Hora</th>
                            <th>Telefone</th>
                            <th>Observações</th>
                            <th>Status</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            SimpleDateFormat sdfData = new SimpleDateFormat("dd/MM/yyyy");
                            try {
                                conn = getConexao();
                                String sql = "SELECT a.id_agendamento, c.nome AS cliente_nome, c.telefone, " +
                                             "s.nome_servico, a.data_agendamento, a.hora_agendamento, a.status, a.observacoes " +
                                             "FROM AGENDAMENTOS a " +
                                             "INNER JOIN CLIENTES c ON a.id_cliente = c.id_cliente " +
                                             "INNER JOIN SERVICOS s ON a.id_servico = s.id_servico " +
                                             "ORDER BY a.data_agendamento ASC, a.hora_agendamento ASC";
                                ps = conn.prepareStatement(sql);
                                rs = ps.executeQuery();

                                boolean temRegistros = false;
                                while (rs.next()) {
                                    temRegistros = true;
                                    int idAg = rs.getInt("id_agendamento");
                                    String cliente = rs.getString("cliente_nome");
                                    String servico = rs.getString("nome_servico");
                                    Date dataAg = rs.getDate("data_agendamento");
                                    String horaAg = rs.getString("hora_agendamento").substring(0, 5);
                                    String telefone = rs.getString("telefone");
                                    String status = rs.getString("status");
                                    String obs = rs.getString("observacoes");
                                    if (obs == null || obs.trim().isEmpty()) obs = "-";

                                    String statusClass = "status-pendente";
                                    if ("Confirmado".equalsIgnoreCase(status)) statusClass = "status-confirmado";
                                    if ("Cancelado".equalsIgnoreCase(status)) statusClass = "status-cancelado";
                        %>
                        <tr>
                            <td><strong><%= cliente %></strong></td>
                            <td><%= servico %></td>
                            <td><%= sdfData.format(dataAg) %> às <%= horaAg %>h</td>
                            <td><%= telefone %></td>
                            <td><%= obs %></td>
                            <td><span class="status-badge <%= statusClass %>"><%= status %></span></td>
                            <td class="action-buttons">
                                <a href="admin.jsp?acao=confirmar&id=<%= idAg %>" class="btn-sm btn-confirm">Confirmar</a>
                                <a href="admin.jsp?acao=cancelar&id=<%= idAg %>" class="btn-sm btn-cancel">Cancelar</a>
                            </td>
                        </tr>
                        <%
                                }
                                if (!temRegistros) {
                        %>
                        <tr>
                            <td colspan="7" style="text-align:center; padding: 24px;">Nenhum agendamento registrado até o momento.</td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                        %>
                        <tr>
                            <td colspan="7" class="alert-error">Erro ao consultar banco de dados: <%= e.getMessage() %></td>
                        </tr>
                        <%
                            } finally {
                                if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                                if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                                if (conn != null) try { conn.close(); } catch (Exception ignored) {}
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div style="margin-top: 48px;">
                <h2 style="margin-bottom: 16px;">Mensagens de Contato Recebidas</h2>
                <div class="table-responsive">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>E-mail</th>
                                <th>Mensagem</th>
                                <th>Data de Envio</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection connC = null;
                                PreparedStatement psC = null;
                                ResultSet rsC = null;
                                try {
                                    connC = getConexao();
                                    psC = connC.prepareStatement("SELECT * FROM CONTATOS ORDER BY data_envio DESC");
                                    rsC = psC.executeQuery();
                                    boolean temContato = false;
                                    while (rsC.next()) {
                                        temContato = true;
                            %>
                            <tr>
                                <td><strong><%= rsC.getString("nome") %></strong></td>
                                <td><%= rsC.getString("email") %></td>
                                <td><%= rsC.getString("mensagem") %></td>
                                <td><%= rsC.getTimestamp("data_envio") %></td>
                            </tr>
                            <%
                                    }
                                    if (!temContato) {
                            %>
                            <tr>
                                <td colspan="4" style="text-align:center; padding: 20px;">Nenhuma mensagem de contato recebida ainda.</td>
                            </tr>
                            <%
                                    }
                                } catch (Exception ignored) {
                                } finally {
                                    if (rsC != null) try { rsC.close(); } catch (Exception ignored) {}
                                    if (psC != null) try { psC.close(); } catch (Exception ignored) {}
                                    if (connC != null) try { connC.close(); } catch (Exception ignored) {}
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="includes/footer.jsp" %>
