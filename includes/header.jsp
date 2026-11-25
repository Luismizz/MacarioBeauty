<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String paginaAtual = request.getRequestURI();
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Macario Beauty | Estúdio de Unhas, Cílios e Sobrancelhas</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;0,700;1,500&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<header class="navbar">
    <div class="container navbar-content">
        <a href="index.jsp" class="brand">
            <img src="img/logo.png" alt="Logo Macario Beauty" class="brand-logo"
                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
            <span class="brand-monogram" style="display:none;">MB</span>
            <div class="brand-text">
                <strong>Macario Beauty</strong>
                <span>Estúdio de Beleza</span>
            </div>
        </a>

        <button class="menu-toggle" id="menuToggle" aria-label="Abrir Menu">&#9776;</button>

        <nav class="nav-links" id="navLinks">
            <a href="index.jsp" class="<%= paginaAtual.endsWith("index.jsp") || paginaAtual.endsWith("/") ? "active" : "" %>">Início</a>
            <a href="servicos.jsp" class="<%= paginaAtual.endsWith("servicos.jsp") ? "active" : "" %>">Serviços</a>
            <a href="agendar.jsp" class="<%= paginaAtual.endsWith("agendar.jsp") ? "active" : "" %>">Agendar</a>
            <a href="contato.jsp" class="<%= paginaAtual.endsWith("contato.jsp") ? "active" : "" %>">Contato</a>
            <a href="admin.jsp" class="btn-acessar <%= paginaAtual.endsWith("admin.jsp") ? "active" : "" %>">Acessar</a>
        </nav>
    </div>
</header>
