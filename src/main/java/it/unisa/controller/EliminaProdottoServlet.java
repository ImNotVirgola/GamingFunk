package it.unisa.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.OrdineProdottoDAOImpl;
import it.unisa.model.Prodotto;
import it.unisa.model.ProdottoDAOImpl;

/**
 * Servlet implementation class EliminaProdottoServlet
 */
@WebServlet("/eliminaProdotto")
public class EliminaProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public EliminaProdottoServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID prodotto mancante.");
            return;
        }

        try {
            int idProdotto = Integer.parseInt(idParam);
            ProdottoDAOImpl prodottoDAO = new ProdottoDAOImpl();
            Prodotto prod = prodottoDAO.getById(idProdotto);

            if (prod != null) {
                prod.setAttivo(0); // "Eliminazione logica"
                prodottoDAO.update(prod); // << Salva le modifiche nel database

                // Eventuale supporto per storico ordini
                OrdineProdottoDAOImpl opDao = new OrdineProdottoDAOImpl();
                opDao.aggiungiNomeProdotto(); // <-- assicurati che questo abbia senso qui

                response.sendRedirect(request.getContextPath() + "/catalogo.jsp");
            } else {
                request.setAttribute("errorMessage", "Prodotto non trovato.");
                request.getRequestDispatcher("errore.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID prodotto non valido.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

