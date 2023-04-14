<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/index.css" type="text/css">
    </head>
<body>
    <%
    Integer tokens = (Integer) session.getAttribute("tokens"); // Inicializacion de los tokens por defecto
    if (tokens == null) {
        tokens = 1000;
        session.setAttribute("tokens", tokens);
    } else {
        Integer result = (Integer) session.getAttribute("result"); // Resultado de la partida
        if (result == null) {
            result = 0;
        } else {
        tokens += result;
        session.setAttribute("tokens", tokens);
        session.setAttribute("result", 0);
        }
    }
    %>
	<div class="valor">Introduzca su apuesta</div>
    <div class="buttons">
        <form method="post" action="juego.jsp" onsubmit="return comprobacionTokens();">
            <label for="number">Apuesta:</label>
            <input type="hidden" id="newGame" name="newGame" value="true">
            <input type="number" id="bet" name="bet" required>
            <button type="submit">Jugar</button>
        </form>
    </div>

    <div class="valor">
        <% out.print("Fichas: "+tokens); %>
    </div>

    <script>
    function comprobacionTokens() {
        var bet = document.getElementById("bet").value;
        var tokens = <%= tokens %>

        if (bet > tokens) {
            alert("La apuesta es mayor que las fichas que tienes");
            return false;
        } else {
            return true;
        }
    }
    </script>
</body>