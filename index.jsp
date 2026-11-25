<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp" %>

<main>
    <!-- Banner Principal (Hero) -->
    <section class="hero">
        <div class="container hero-grid">
            <div class="hero-image-box">
                <img src="img/hero-banner.jpg" alt="Trabalho Macario Beauty"
                     onerror="this.src='https://images.unsplash.com/photo-1604654894610-df63bc536371?auto=format&fit=crop&w=800&q=80'">
            </div>
            <div class="hero-content">
                <span class="badge">Bem-vinda ao nosso espaço</span>
                <h1>Cuidado e Beleza para Você</h1>
                <p>Realce sua autoestima com atendimento personalizado em manicure, alongamento em gel, extensão de cílios e design de sobrancelhas.</p>
                <div class="hero-actions">
                    <a href="agendar.jsp" class="btn btn-primary">Agendar Agora</a>
                    <a href="servicos.jsp" class="btn btn-outline">Ver Catálogo</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Seção Nossos Destaques (3 Serviços) -->
    <section class="section">
        <div class="container">
            <div class="section-header">
                <h2>Nossos Destaques</h2>
                <p>Procedimentos realizados com materiais esterilizados e técnicas modernas.</p>
            </div>

            <div class="cards-grid">
                <article class="card">
                    <div class="card-img">
                        <img src="img/unhas-gel.jpg" alt="Manicure e Alongamento"
                             onerror="this.src='https://images.unsplash.com/photo-1632345031435-8727f6897d53?auto=format&fit=crop&w=600&q=80'">
                    </div>
                    <div class="card-body">
                        <h3>Manicure e Alongamento</h3>
                        <p>Cutilagem precisa, esmaltação tradicional ou em gel e alongamentos com acabamento natural.</p>
                        <a href="servicos.jsp?categoria=Unhas" class="card-link">Explorar Unhas &rarr;</a>
                    </div>
                </article>

                <article class="card">
                    <div class="card-img">
                        <img src="img/cilios-extensao.jpg" alt="Alongamento de Cílios"
                             onerror="this.src='https://images.unsplash.com/photo-1583001931096-959e9a1a6223?auto=format&fit=crop&w=600&q=80'">
                    </div>
                    <div class="card-body">
                        <h3>Alongamento de Cílios</h3>
                        <p>Técnicas de extensão e lash lifting que valorizam o seu olhar com conforto e leveza.</p>
                        <a href="servicos.jsp?categoria=Cílios" class="card-link">Explorar Cílios &rarr;</a>
                    </div>
                </article>

                <article class="card">
                    <div class="card-img">
                        <img src="img/sobrancelhas.jpg" alt="Design de Sobrancelhas"
                             onerror="this.src='https://images.unsplash.com/photo-1522337660859-02fbefca4702?auto=format&fit=crop&w=600&q=80'">
                    </div>
                    <div class="card-body">
                        <h3>Design de Sobrancelhas</h3>
                        <p>Simetria facial planejada para harmonizar sua expressão com naturalidade e elegância.</p>
                        <a href="servicos.jsp?categoria=Sobrancelhas" class="card-link">Explorar Sobrancelhas &rarr;</a>
                    </div>
                </article>
            </div>
        </div>
    </section>

    <!-- Seção Sobre Nós -->
    <section class="section bg-soft">
        <div class="container about-grid">
            <div class="about-image">
                <img src="img/sobre-studio.jpg" alt="Sobre o Estúdio Macario Beauty"
                     onerror="this.src='https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=800&q=80'">
            </div>
            <div class="about-content">
                <span class="badge">Sobre Nós</span>
                <h2>Sobre o Estúdio Macario Beauty</h2>
                <p>A <strong>Macario Beauty</strong> nasceu com o propósito de oferecer um ambiente acolhedor, seguro e dedicado ao bem-estar feminino. Cada atendimento é pensado individualmente para respeitar o estilo e a saúde das suas unhas e cílios.</p>
                <p>Acompanhe nossos resultados reais e novidades diárias pelo Instagram oficial <strong>@_macariobeauty</strong> e garanta seu horário online de forma rápida.</p>
                <div class="hero-actions">
                    <a href="contato.jsp" class="btn btn-primary">Saiba Mais e Localização</a>
                    <a href="https://www.instagram.com/_macariobeauty/" target="_blank" rel="noopener noreferrer" class="btn btn-outline">Ver Instagram</a>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="includes/footer.jsp" %>
