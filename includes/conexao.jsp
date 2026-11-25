<%@ page import="java.sql.*" %>
<%!
    public Connection getConexao() throws Exception {
        String url = "jdbc:mysql://localhost:3306/macario_beauty?useTimezone=true&serverTimezone=America/Sao_Paulo&useUnicode=true&characterEncoding=UTF-8";
        String usuario = "root";
        String senha = ""; // Padrão do XAMPP é vazio
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, usuario, senha);
    }
%>
