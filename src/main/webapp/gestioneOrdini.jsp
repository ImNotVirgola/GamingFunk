<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, it.unisa.model.Ordine" %>
<html>
<head>
    <title>Ordini Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gestioneOrdini.css">
</head>
	<body>
	<%@ include file="/fragments/header.jspf" %>
	<main>
		<div class="container">
		    <h1>📦 Ordini effettuati</h1>
		
		    <form action="gestioneOrdini" method="get">
			    <label>ID Utente:</label>
			    <input type="number" name="idUtente" placeholder="ID">
			
			    <label>Data inizio:</label>
			    <input type="date" name="dataInizio">
			
			    <label>Data fine:</label>
			    <input type="date" name="dataFine">
				<br>
			    <button type="submit">Filtra</button>
			</form>
		
		
		    <table>
		        <thead>
		            <tr>
		                <th>ID Ordine</th>
		                <th>ID Utente</th>
		                <th>Data Ordine</th>
		                <th>Totale</th>
		            </tr>
		        </thead>
		        <tbody>
		        <%
		            List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
		            if (ordini != null && !ordini.isEmpty()) {
		                for (Ordine o : ordini) {
		        %>
		            <tr>
		                <td><%= o.getIdOrdine() %></td>
		                <td><%= o.getIdUtente() %></td>
		                <td><%= o.getDataOrdine() %></td>
		                <td>€<%= String.format("%.2f", o.getTotale()) %></td>
		            </tr>
		        <%
		                }
		            } else {
		        %>
		            <tr><td colspan="4">Nessun ordine trovato</td></tr>
		        <%
		            }
		        %>
		        </tbody>
		    </table>
		</div>
	</main>
	<%@ include file="/fragments/footer.jspf" %>
	</body>
</html>