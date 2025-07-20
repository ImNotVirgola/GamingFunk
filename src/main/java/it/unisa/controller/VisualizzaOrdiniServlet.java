package it.unisa.controller;

import it.unisa.model.Ordine;
import it.unisa.model.OrdineDAOImpl;
import it.unisa.model.Utente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;


@WebServlet("/visualizzaOrdini")
public class VisualizzaOrdiniServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        OrdineDAOImpl ordineDAO = new OrdineDAOImpl();
        List<Ordine> ordini = ordineDAO.getOrdiniByUtente(utente.getIdUtente());

        request.setAttribute("ordini", ordini);

        // CORRETTO: usa la pagina JSP dell’utente
        request.getRequestDispatcher("/ordiniUtente.jsp").forward(request, response);
    }
}

