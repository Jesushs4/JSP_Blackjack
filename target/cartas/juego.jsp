<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelos.Mazo" %>
<%@ page import="modelos.Carta" %>
<%@ page import="modelos.CartaTemplate" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/styles.css" type="text/css">
    </head>
<body>
    <%
    boolean newGame = Boolean.parseBoolean(request.getParameter("newGame")); // Booleano que resetea partida
    Integer result = 0;
    // Inicializo el mazo 1 vez por sesión para que se mantenga durante la partida
    Mazo mazo = (Mazo) session.getAttribute("mazo"); 
    if (mazo == null) {
        mazo = new Mazo();
        session.setAttribute("mazo", mazo);
    }

    // Inicializo los puntos del jugador para que se guarden durante la partida
    Integer playerValue = (Integer) session.getAttribute("playerValue");
    if (playerValue == null || newGame) {
        playerValue = 0;
        session.setAttribute("playerValue", playerValue);
    }


    int crupierValue = 0;

    boolean plantarse = Boolean.parseBoolean(request.getParameter("plantarse"));

    // Inicializo las cartas del jugador para que se mantengan durante la partida
    ArrayList<Carta> playerCards = (ArrayList<Carta>) session.getAttribute("playerCards");
    if (playerCards == null || newGame) {
        playerCards = new ArrayList<Carta>();
        session.setAttribute("playerCards", playerCards);
    }

    // Si se ha seleccionado apuesta, se creará una nueva partida
    if (newGame) {
        session.removeAttribute("mazo");
        session.removeAttribute("playerCards");
        session.removeAttribute("playerValue");
        session.removeAttribute("playerBet");
        }

        // Inicializa la apuesta del jugador y la guarda durante la partida para así retornar dependiendo si gana o pierde
        Integer playerBet = (Integer) session.getAttribute("playerBet"); 
        if (playerBet==null) { // Si es la primera partida que se juega, se coloca esta apuesta
            playerBet = Integer.parseInt(request.getParameter("bet"));
            session.setAttribute("playerBet", playerBet);
        } else if (playerBet!=null && newGame) { // Si hay nueva partida y previamente ya había una apuesta, se sustituye por la nueva
            playerBet = Integer.parseInt(request.getParameter("bet"));
            session.setAttribute("playerBet", playerBet);
        }

    //Se encarga de colocar las cartas al pedirlas
    boolean pedir = Boolean.parseBoolean(request.getParameter("pedir")); 
    if (pedir) {
        if (playerValue==0) {
            for (int i=0; i<2; i++) { // En el primer turno, se extraen dos cartas de golpe
                playerValue+=(Integer)((mazo.getCarta()).getNumeroAsInt())+1;
                playerCards.add(mazo.extrae());
                session.setAttribute("playerValue", playerValue);
                session.setAttribute("playerCards", playerCards);
                }
            } else { // En el resto de turnos, se saca una única carta
            playerValue+=(Integer)((mazo.getCarta()).getNumeroAsInt())+1;
                playerCards.add(mazo.extrae());
                session.setAttribute("playerValue", playerValue);
                session.setAttribute("playerCards", playerCards);
            }
        }
            
    %>

    
    
    <%
    // Si te plantas, el crupier saca sus cartas (mínimo tiene que sacar 17, parará si le gana al jugador o se pasa de 21) 
    if (plantarse) { 
    %>
                <div class="cartas">
                <% do {
                    crupierValue+=(int)((mazo.getCarta()).getNumeroAsInt())+1;
                    out.print(new CartaTemplate(mazo.extrae()));
                } while (crupierValue<17 || crupierValue<playerValue); %>
                </div>
            <%} else {%>
                <div class="cartaReverso">
                <img src="assets/img/reverso.png">
                </div>
            <%}%>
    
    <div class="valor">
    <%out.print((crupierValue==21)?"Blackjack":crupierValue);%>
    </div>

    <div class="cartaReverso">
        <img src="assets/img/reverso.png">
    </div>

    <div class="valor">
    <%out.print((playerValue==21)?"Blackjack":playerValue);%>
    </div>


<% if (playerCards.isEmpty()) { %>
    <div class="cartaReverso">
        <img src="assets/img/reverso.png">
        <img src="assets/img/reverso.png">
    </div>
<%} else {%>
    <div class="cartas">
        <%
            for(Carta cartas : playerCards) {
                out.print(new CartaTemplate(cartas));
            }
        %>
    </div>
    <%} %>
        <!--Los botones que servirán para jugar -->
        <div class="buttons">
        <%if (!plantarse && playerValue<=21) { %>
        <form method="POST" action="juego.jsp">
            <input type="hidden" name="pedir" value="true">
            <button type="submit">Pedir carta</button>
        </form>
        <%if (playerValue!=0) { %>
        <form method="POST" action="juego.jsp">
            <input type="hidden" name="plantarse" value="true">    
            <button type="submit">Plantarse</button>
        </form>
        <% } }%> 
        <!--El botón de reiniciar retornará a la página de la apuesta -->
        <form method="POST" action="index.jsp">
            <input type="hidden" name="reiniciar" value="true">   
            <input type="hidden" name="result" value="%= result %>"> 
            <button type="submit">Reiniciar</button>
        </form>
    </div>

    <% if (plantarse || playerValue>21) { /* Las formas de ganar o perder */%>
    <div class="valor">
            <% if ((playerValue<=21 && playerValue>crupierValue) || crupierValue>21)  {
                
                result = playerBet;
                session.setAttribute("result", result);
                out.print((playerBet!=0)?"Has ganado "+(result*2)+" fichas":"Has ganado");

            } else if (playerValue==crupierValue) {
                
                result = 0;
                session.setAttribute("result", result);
                out.print((playerBet!=0)?"Empate: se te devuelven las fichas":"Empate");
    
              } else {
                
                result = -playerBet;
                session.setAttribute("result", result);
                out.print((playerBet!=0)?"Has perdido "+(-result)+" fichas":"Has perdido");
    
              } 
              %>
        </div>
    <% } %> 

    <div class="valor">
    <% out.print((playerBet!=0)?"Has apostado "+playerBet+" fichas":"Partida sin apuesta"); %>
    </div>

    
</body>
</html>