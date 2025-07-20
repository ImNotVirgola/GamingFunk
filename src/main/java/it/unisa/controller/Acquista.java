package it.unisa.controller;

import it.unisa.model.OrdineDAOImpl;
import it.unisa.model.Utente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
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

        OrdineDAOImpl ordineDAO = new OrdineDAOImpl();
        int idOrdine = ordineDAO.creaOrdine(utente.getIdUtente(), carrello);

        if (idOrdine > 0) {
            session.removeAttribute("carrello");
            response.sendRedirect("ordine-confermato.jsp?id=" + idOrdine);
        } else {
            request.setAttribute("errorMessage", "Errore durante l'acquisto.");
            request.getRequestDispatcher("/carrello.jsp").forward(request, response);
        }
    }
}