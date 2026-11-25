<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/conexao.jsp" %>
<%@ include file="includes/header.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    String mensagemSucesso = null;
    String mensagemErro = null;

    String servicoPreSelecionado = request.getParameter("id_servico");
    if (servicoPreSelecionado == null) servicoPreSelecionado = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nome = request.getParameter("nome");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");
        String idServicoStr = request.getParameter("id_servico");
        String dataAgendamento = request.getParameter("data_agendamento");
        String horaAgendamento = request.getParameter("hora_agendamento");
        String observacoes = request.getParameter("observacoes");

        Connection connPost = null;
        try {
            connPost = getConexao();
            connPost.setAutoCommit(false);

            int idCliente = 0;
            PreparedStatement psBusca = connPost.prepareStatement("SELECT id_cliente FROM CLIENTES WHERE email = ? OR telefone = ? LIMIT 1");
            psBusca.setString(1, email);
            psBusca.setString(2, telefone);
            ResultSet rsBusca = psBusca.executeQuery();

            if (rsBusca.next()) {
                idCliente = rsBusca.getInt("id_cliente");
            } else {
                PreparedStatement psCli = connPost.prepareStatement(
                    "INSERT INTO CLIENTES (nome, telefone, email) VALUES (?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
                );
                psCli.setString(1, nome);
                psCli.setString(2, telefone);
                psCli.setString(3, email);
                psCli.executeUpdate();
                ResultSet rsKeys = psCli.getGeneratedKeys();
                if (rsKeys.next()) {
                    idCliente = rsKeys.getInt(1);
                }
                rsKeys.close();
                psCli.close();
            }
            rsBusca.close();
            psBusca.close();

            PreparedStatement psAg = connPost.prepareStatement(
                "INSERT INTO AGENDAMENTOS (id_cliente, id_servico, data_agendamento, hora_agendamento, status, observacoes) VALUES (?, ?, ?, ?, 'Pendente', ?)"
            );
            psAg.setInt(1, idCliente);
            psAg.setInt(2, Integer.parseInt(idServicoStr));
            psAg.setString(3, dataAgendamento);
            psAg.setString(4, horaAgendamento);
            psAg.setString(5, observacoes);
            psAg.executeUpdate();
            psAg.close();

            connPost.commit();
            mensagemSucesso = "Agendamento realizado com sucesso, " + nome + "! Seu horário foi registrado e está aguardando confirmação da profissional.";
        } catch (Exception e) {
            if (connPost != null) try { connPost.rollback(); } catch (Exception ignored) {}
            mensagemErro = "Não foi possível concluir o agendamento: " + e.getMessage();
        } finally {
            if (connPost != null) try { connPost.close(); } catch (Exception ignored) {}
        }
    }
%>

<main>
    <section class="page-banner">
        <div class="container">
            <h1>Agende seu Horário</h1>
            <p>Escolha o serviço desejado, data e horário para atendimento na Macario Beauty.</p>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <% if (mensagemSucesso != null) { %>
                <div class="alert alert-success">
                    <strong>Sucesso!</strong> <%= mensagemSucesso %>
                    <br><a href="admin.jsp" style="text-decoration:underline; font-weight:600;">Visualizar no Painel da Profissional &rarr;</a>
                </div>
            <% } %>

            <% if (mensagemErro != null) { %>
                <div class="alert alert-error">
                    <strong>Atenção:</strong> <%= mensagemErro %>
                </div>
            <% } %>

            <div class="booking-grid">
                <div class="form-card">
                    <form id="formAgendamento" method="POST" action="agendar.jsp" novalidate>
                        <div class="form-group">
                            <label for="nome">Nome Completo *</label>
                            <input type="text" id="nome" name="nome" placeholder="Digite seu nome completo" required>
                            <small class="error-msg" id="erroNome"></small>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="telefone">Telefone / WhatsApp *</label>
                                <input type="tel" id="telefone" name="telefone" placeholder="(11) 99999-9999" maxlength="15" required>
                                <small class="error-msg" id="erroTelefone"></small>
                            </div>
                            <div class="form-group">
                                <label for="email">E-mail *</label>
                                <input type="email" id="email" name="email" placeholder="seuemail@exemplo.com" required>
                                <small class="error-msg" id="erroEmail"></small>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="id_servico">Selecionar Serviço *</label>
                            <select id="id_servico" name="id_servico" required>
                                <option value="" data-preco="--,--" data-duracao="--">-- Selecione um procedimento --</option>
                                <%
                                    Connection connServ = null;
                                    PreparedStatement psServ = null;
                                    ResultSet rsServ = null;
                                    try {
                                        connServ = getConexao();
                                        psServ = connServ.prepareStatement("SELECT id_servico, nome_servico, preco, duracao_min FROM SERVICOS ORDER BY categoria, nome_servico");
                                        rsServ = psServ.executeQuery();
                                        while (rsServ.next()) {
                                            String idS = String.valueOf(rsServ.getInt("id_servico"));
                                            String nomeS = rsServ.getString("nome_servico");
                                            String precoS = String.format("%.2f", rsServ.getDouble("preco")).replace(".", ",");
                                            int durS = rsServ.getInt("duracao_min");
                                            String selected = idS.equals(servicoPreSelecionado) ? "selected" : "";
                                %>
                                <option value="<%= idS %>" data-preco="<%= precoS %>" data-duracao="<%= durS %>" <%= selected %>>
                                    <%= nomeS %> (R$ <%= precoS %>)
                                </option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        out.println("<option disabled>Erro ao carregar serviços</option>");
                                    } finally {
                                        if (rsServ != null) try { rsServ.close(); } catch (Exception ignored) {}
                                        if (psServ != null) try { psServ.close(); } catch (Exception ignored) {}
                                        if (connServ != null) try { connServ.close(); } catch (Exception ignored) {}
                                    }
                                %>
                            </select>
                            <small class="error-msg" id="erroServico"></small>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="data_agendamento">Data *</label>
                                <input type="date" id="data_agendamento" name="data_agendamento" required>
                                <small class="error-msg" id="erroData"></small>
                            </div>
                            <div class="form-group">
                                <label for="hora_agendamento">Horário *</label>
                                <select id="hora_agendamento" name="hora_agendamento" required>
                                    <option value="">-- Selecione --</option>
                                    <option value="09:00">09:00</option>
                                    <option value="10:00">10:00</option>
                                    <option value="11:30">11:30</option>
                                    <option value="13:30">13:30</option>
                                    <option value="14:00">14:00</option>
                                    <option value="15:30">15:30</option>
                                    <option value="17:00">17:00</option>
                                    <option value="18:30">18:30</option>
                                </select>
                                <small class="error-msg" id="erroHora"></small>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="observacoes">Observações (opcional)</label>
                            <textarea id="observacoes" name="observacoes" rows="3" placeholder="Ex: Alergia a algum produto, preferência de cor ou formato..."></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">Confirmar Agendamento</button>
                    </form>
                </div>

                <aside class="summary-card">
                    <h3>Resumo do Agendamento</h3>
                    <div class="summary-divider"></div>
                    <div class="summary-item">
                        <span>Serviço:</span>
                        <strong id="resumoServico">Não selecionado</strong>
                    </div>
                    <div class="summary-item">
                        <span>Preço:</span>
                        <strong>R$ <span id="resumoPreco">--,--</span></strong>
                    </div>
                    <div class="summary-item">
                        <span>Duração est.:</span>
                        <strong><span id="resumoDuracao">--</span> min</strong>
                    </div>
                    <div class="summary-divider"></div>
                    <div class="summary-item">
                        <span>Profissional:</span>
                        <strong>Estúdio Macario Beauty</strong>
                    </div>
                    <div class="summary-item">
                        <span>Data:</span>
                        <strong id="resumoData">--/--/----</strong>
                    </div>
                    <div class="summary-item">
                        <span>Horário:</span>
                        <strong id="resumoHora">--:--</strong>
                    </div>
                    <div class="summary-note">
                        <p>O pagamento é realizado presencialmente no estúdio após a conclusão do procedimento.</p>
                    </div>
                </aside>
            </div>
        </div>
    </section>
</main>

<%@ include file="includes/footer.jsp" %>
