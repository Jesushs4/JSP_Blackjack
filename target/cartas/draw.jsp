<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelos.Mazo" %>
<%@ page import="modelos.Carta" %>
<%@ page import="modelos.CartaTemplate" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/styles.css" type="text/css">
    </head>
<body>

<%
    Mazo mazo = (Mazo) session.getAttribute("mazo");
    Carta carta = (Carta) mazo.getCarta();
    int valorCarta = (int)carta.getNumeroAsInt();
    if (valorCarta<7) {
        valorCarta = valorCarta+1;
    } else {
        valorCarta = valorCarta+3;
    }
    out.print(new CartaTemplate(mazo.extrae()));
    out.print(valorCarta);
%>
    
</body>
</html>