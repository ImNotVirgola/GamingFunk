package it.unisa.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/aggiungi-al-carrello")
public class AggiungiAlCarrello extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nomeProdotto = request.getParameter("nome");
        String prezzoProdottoStr = request.getParameter("prezzo");
        String idProdottoStr = request.getParameter("id");

        // ✅ Recupera quantità dal form
        int quantita = 1;
        String quantitaParam = request.getParameter("quantita");
        if (quantitaParam != null && !quantitaParam.isEmpty()) {
            try {
                quantita = Integer.parseInt(quantitaParam);
            } catch (NumberFormatException e) {
                quantita = 1; // fallback
            }
        }

        // ✅ Validazione parametri
        if (nomeProdotto == null || prezzoProdottoStr == null || idProdottoStr == null ||
            nomeProdotto.isEmpty() || prezzoProdottoStr.isEmpty() || idProdottoStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/catalogo.jsp?errore=Parametri%20mancanti");
            return;
        }

        double prezzoProdotto;
        int idProdotto;

        try {
            prezzoProdotto = Double.parseDouble(prezzoProdottoStr);
            idProdotto = Integer.parseInt(idProdottoStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/catalogo.jsp?errore=Parametri%20non%20validi");
            return;
        }

        // ✅ Recupera o inizializza carrello
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> carrello = (List<Map<String, Object>>) session.getAttribute("carrello");

        if (carrello == null) {
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }

        // ✅ Cerca il prodotto nel carrello
        boolean prodottoEsistente = false;
        for (Map<String, Object> item : carrello) {
            if (((Integer) item.get("id")).equals(idProdotto)) {
                int qtaAttuale = 0;
                Object quantitaObj = item.get("quantità");

                if (quantitaObj instanceof Integer) {
                    qtaAttuale = (Integer) quantitaObj;
                } else if (quantitaObj != null) {
                    try {
                        qtaAttuale = Integer.parseInt(quantitaObj.toString());
                    } catch (NumberFormatException e) {
                        qtaAttuale = 0;
                    }
                }

                item.put("quantità", qtaAttuale + quantita);
                prodottoEsistente = true;
                break;
            }
        }

        // ✅ Se non esiste, aggiungilo
        if (!prodottoEsistente) {
            Map<String, Object> nuovoProdotto = new HashMap<>();
            nuovoProdotto.put("id", idProdotto);
            nuovoProdotto.put("nome", nomeProdotto);
            nuovoProdotto.put("prezzo", prezzoProdotto);
            nuovoProdotto.put("quantità", quantita);
            carrello.add(nuovoProdotto);
        }

        // ✅ Reindirizza
        response.sendRedirect(request.getContextPath() + "/catalogo.jsp?messaggio=Prodotto%20aggiunto%20al%20carrello");
    }
}
