package it.unisa.controller;

import it.unisa.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/acquista")
public class Acquista extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        List<Map<String, Object>> carrello = (List<Map<String, Object>>) session.getAttribute("carrello");

        if (utente == null || carrello == null || carrello.isEmpty()) {
            response.sendRedirect("carrello.jsp");
            return;
        }

        ProdottoDAOImpl prodottoDAO = new ProdottoDAOImpl();
        List<String> prodottiNonDisponibili = new ArrayList<>();

        // 🔍 Primo controllo: verifica disponibilità
        for (Map<String, Object> item : carrello) {
            int idProdotto = (int) item.get("id");
            int quantita = (int) item.get("quantità");

            Prodotto prodotto = prodottoDAO.getById(idProdotto);

            if (prodotto == null || quantita > prodotto.getQuantitaDisponibile()) {
                String nome = (prodotto != null ? prodotto.getNome() : "Prodotto sconosciuto");
                int disponibili = (prodotto != null ? prodotto.getQuantitaDisponibile() : 0);
                prodottiNonDisponibili.add(nome + " (disponibili: " + disponibili + ")");
            }
        }

        // ❌ Se ci sono errori di disponibilità, torna al carrello con messaggio
        if (!prodottiNonDisponibili.isEmpty()) {
            request.setAttribute("errorMessage", "Alcuni prodotti non sono disponibili nella quantità richiesta.");
            request.setAttribute("dettagliErrori", prodottiNonDisponibili);
            request.getRequestDispatcher("/carrello.jsp").forward(request, response);
            return;
        }

        // ✅ Nessun problema, crea l'ordine
        OrdineDAOImpl ordineDAO = new OrdineDAOImpl();
        int idOrdine = ordineDAO.creaOrdine(utente.getIdUtente(), carrello);

        if (idOrdine > 0) {
            // 🔄 Aggiorna quantità e venduto
            for (Map<String, Object> item : carrello) {
                int idProdotto = (int) item.get("id");
                int quantita = (int) item.get("quantità");

                Prodotto prodotto = prodottoDAO.getById(idProdotto);
                prodotto.setQuantitaDisponibile(prodotto.getQuantitaDisponibile() - quantita);
                prodotto.setQuantitaVenduta(prodotto.getQuantitaVenduta() + quantita);
                prodottoDAO.update(prodotto);
            }

            session.removeAttribute("carrello");
            response.sendRedirect("ordine-confermato.jsp?id=" + idOrdine);
        } else {
            request.setAttribute("errorMessage", "Errore durante l'acquisto.");
            request.getRequestDispatcher("/carrello.jsp").forward(request, response);
        }
    }
}
