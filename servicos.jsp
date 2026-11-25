<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/conexao.jsp" %>
<%@ include file="includes/header.jsp" %>

<%
    String categoriaFiltro = request.getParameter("categoria");
    if (categoriaFiltro == null || categoriaFiltro.trim().isEmpty()) {
        categoriaFiltro = "Todos";
    }
%>

<main>
    <section class="page-banner">
        <div class="container">
            <h1>Nossos Serviços</h1>
            <p>Escolha os procedimentos ideais para realçar sua beleza e agende seu horário.</p>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <!-- Filtros por Categoria conforme Wireframe -->
            <div class="filter-bar">
                <a href="servicos.jsp?categoria=Todos" class="filter-btn <%= "Todos".equalsIgnoreCase(categoriaFiltro) ? "active" : "" %>">Todos</a>
                <a href="servicos.jsp?categoria=Unhas" class="filter-btn <%= "Unhas".equalsIgnoreCase(categoriaFiltro) ? "active" : "" %>">Unhas</a>
                <a href="servicos.jsp?categoria=Cílios" class="filter-btn <%= "Cílios".equalsIgnoreCase(categoriaFiltro) ? "active" : "" %>">Cílios</a>
                <a href="servicos.jsp?categoria=Sobrancelhas" class="filter-btn <%= "Sobrancelhas".equalsIgnoreCase(categoriaFiltro) ? "active" : "" %>">Sobrancelhas</a>
            </div>

            <!-- Grade de Cards Dinâmica vinda do Banco de Dados -->
            <div class="cards-grid">
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        conn = getConexao();
                        String sql = "SELECT * FROM SERVICOS";
                        if (!"Todos".equalsIgnoreCase(categoriaFiltro)) {
                            sql += " WHERE categoria = ?";
                        }
                        ps = conn.prepareStatement(sql);
                        if (!"Todos".equalsIgnoreCase(categoriaFiltro)) {
                            ps.setString(1, categoriaFiltro);
                        }
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int idServico = rs.getInt("id_servico");
                            String nome = rs.getString("nome_servico");
                            String cat = rs.getString("categoria");
                            String desc = rs.getString("descricao");
                            double preco = rs.getDouble("preco");
                            int duracao = rs.getInt("duracao_min");
                            String imagem = rs.getString("imagem");
                %>
                <article class="card service-card">
                    <div class="card-img">
                        <span class="category-tag"><%= cat %></span>
                        <img src="<%= imagem %>" alt="<%= nome %>"
                             onerror="this.src='https://images.unsplash.com/photo-1604654894610-df63bc536371?auto=format&fit=crop&w=600&q=80'">
                    </div>
                    <div class="card-body">
                        <h3><%= nome %></h3>
                        <p><%= desc %></p>
                        <div class="service-meta">
                            <span class="price">R$ <%= String.format("%.2f", preco).replace(".", ",") %></span>
                            <span class="duration">Duração: <%= duracao %> min</span>
                        </div>
                        <a href="agendar.jsp?id_servico=<%= idServico %>" class="btn btn-primary btn-block">Selecionar</a>
                    </div>
                </article>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <div class="alert alert-error">
                        Erro ao carregar serviços do banco de dados: <%= e.getMessage() %>
                    </div>
                <%
                    } finally {
                        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                        if (ps != null) try { ps.close(); } catch (Exception ignored) {}
                        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
                    }
                %>
            </div>
        </div>
    </section>
</main>

<%@ include file="includes/footer.jsp" %>
