<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="it.unisa.model.*, java.util.*, java.text.DecimalFormat, java.math.RoundingMode" %>
<%
    int idOrdine = Integer.parseInt(request.getParameter("idOrdine"));
    OrdineDAOImpl ordineDAO = new OrdineDAOImpl();
    OrdineProdottoDAOImpl ordineProdottoDAO = new OrdineProdottoDAOImpl();
    UtenteDAOImpl utenteDAO = new UtenteDAOImpl();

    Ordine ordine = ordineDAO.getById(idOrdine);
    List<Map<String, Object>> prodotti = ordineProdottoDAO.getProdottiDettagliatiByOrdineId(idOrdine);
    Utente utente = utenteDAO.getById(ordine.getIdUtente());

    DecimalFormat df = new DecimalFormat("#,##0.00");
    df.setRoundingMode(RoundingMode.HALF_UP);

    double totaleNetto = 0.0;
    double totaleIVA = 0.0;
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Fattura #<%= ordine.getIdOrdine() %></title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/fattura.css">
</head>
<body>

<div class="section azienda">
    <h3>[Intestazione Ditta]</h3>
    <p><strong>GamingFunk S.r.l.</strong><br>
    Via dei Videogiochi, 101<br>
    80100 Napoli (NA) – Italia<br>
    P.IVA: 12345678901<br>
    Tel: +39 0812345678 – Email: <a href="mailto:info@gamingfunk.it">info@gamingfunk.it</a></p>
</div>

<div class="section fattura">
    <h2>FATTURA N° <%= ordine.getIdOrdine() %></h2>
    <p><strong>Data:</strong> <%= ordine.getDataOrdine() %></p>
</div>

<div class="section cliente">
    <h3>Cliente:</h3>
    <p><strong><%= utente.getNome() %> <%= utente.getCognome() %></strong><br>
       <%= utente.getIndirizzo() %><br>
       <%= utente.getCap() %> <%= utente.getCitta() %> (<%= utente.getProvincia() %>)<br>
       P.IVA: N/D</p>
</div>

<table>
    <thead>
        <tr>
            <th>#</th>
            <th>Descrizione</th>
            <th>Prezzo Unitario (€)</th>
            <th>Quantità</th>
            <th>IVA %</th>
            <th>Totale Netto (€)</th>
            <th>IVA (€)</th>
            <th>Totale IVA Inclusa (€)</th>
        </tr>
    </thead>
    <tbody>
    <%
        int i = 1;
        for (Map<String, Object> p : prodotti) {
            String nome = (String) p.get("nome");
            int quantita = (int) p.get("quantita");
            double prezzoIvato = ((Number) p.get("prezzo_unitario")).doubleValue();
            double totaleIvato = prezzoIvato * quantita;

            double ivaUnitaria = prezzoIvato * 0.22;
            double totaleIVAProdotto = ivaUnitaria * quantita;
            double totaleNettoProdotto = totaleIvato - totaleIVAProdotto;

            totaleNetto += totaleNettoProdotto;
            totaleIVA += totaleIVAProdotto;
    %>
        <tr>
            <td><%= i++ %></td>
            <td><%= nome %></td>
            <td><%= df.format(prezzoIvato) %></td>
            <td><%= quantita %></td>
            <td>22%</td>
            <td><%= df.format(totaleNettoProdotto) %></td>
            <td><%= df.format(totaleIVAProdotto) %></td>
            <td><%= df.format(totaleIvato) %></td>
        </tr>
    <%
        }
    %>
    </tbody>
</table>

<div class="totali">
    <h3>Riepilogo Totale:</h3>
    <ul>
        <li><strong>Totale imponibile (IVA esclusa):</strong> <%= df.format(totaleNetto) %> €</li>
        <li><strong>Totale IVA:</strong> <%= df.format(totaleIVA) %> €</li>
        <li><strong>Totale fattura (IVA inclusa):</strong> <%= df.format(ordine.getTotale()) %> €</li>
    </ul>
</div>

<a href="visualizzaOrdini" class="btn no-print">🔙 Torna ai tuoi ordini</a>

<script>
    window.onload = () => window.print();
</script>
</body>
</html>
