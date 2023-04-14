<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelos.Mazo" %>
<%@ page import="modelos.CartaTemplate" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/styles.css" type="text/css">
    </head>
<body>
    <%
    Mazo mazo = new Mazo();
    %>
    <div class="cartaReverso">
        <img src="assets/img/reverso.png">
    </div>

    <div class="buttons">
        <form method="POST" action="#">
            <input type="submit" value="Draw" formaction="draw.jsp">
            <input type="submit" value="Stop" formaction="stop.jsp">
        </form>
    </div>
    <div class="cartas">
        <%
            out.print(new CartaTemplate(mazo.extrae()));
            out.print(new CartaTemplate(mazo.extrae()));
            out.print(new CartaTemplate(mazo.extrae()));
            
        %>
    </div>
    
</body>
</html>