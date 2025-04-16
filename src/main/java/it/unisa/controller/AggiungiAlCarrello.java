package it.unisa.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/aggiungi-al-carrello")
public class AggiungiAlCarrello extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Recupera i parametri dal form
        String nomeProdotto = request.getParameter("nome");
        String prezzoProdottoStr = request.getParameter("prezzo");

        // Validazione dei parametri
        if (nomeProdotto == null || prezzoProdottoStr == null || nomeProdotto.isEmpty() || prezzoProdottoStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/catalogo.jsp?errore=Parametri%20mancanti");
            return;
        }

        double prezzoProdotto;
        try {
            prezzoProdotto = Double.parseDouble(prezzoProdottoStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/catalogo.jsp?errore=Prezzo%20non%20valido");
            return;
        }

        // Recupera la sessione
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> carrello = (List<Map<String, Object>>) session.getAttribute("carrello");

        // Inizializza il carrello se non esiste
        if (carrello == null) {
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }

        // Controlla se il prodotto è già nel carrello
        boolean prodottoEsistente = false;
        for (Map<String, Object> item : carrello) {
            if (item.get("nome").equals(nomeProdotto)) {
                int quantita = (int) item.get("quantità");
                item.put("quantità", quantita + 1);
                prodottoEsistente = true;
                break;
            }
        }

        // Se il prodotto non è nel carrello, aggiungilo
        if (!prodottoEsistente) {
            Map<String, Object> nuovoProdotto = new HashMap<>();
            nuovoProdotto.put("nome", nomeProdotto);
            nuovoProdotto.put("prezzo", prezzoProdotto);
            nuovoProdotto.put("quantità", 1);
            carrello.add(nuovoProdotto);
        }

        // Reindirizza l'utente alla pagina del catalogo
        response.sendRedirect(request.getContextPath() + "/catalogo.jsp?messaggio=Prodotto%20aggiunto%20al%20carrello");
    }
}