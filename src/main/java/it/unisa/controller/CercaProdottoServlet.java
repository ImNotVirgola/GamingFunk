package it.unisa.controller;

import it.unisa.model.Prodotto;
import it.unisa.model.ProdottoDAOImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.google.gson.Gson;

import java.io.IOException;
import java.util.List;

@WebServlet("/cerca")
public class CercaProdottoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String term = request.getParameter("term");

        // Controllo che il termine di ricerca non sia vuoto
        if (term == null || term.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Termine di ricerca mancante");
            return;
        }

        // Effettua la ricerca tramite il DAO
        ProdottoDAOImpl dao = new ProdottoDAOImpl();
        List<Prodotto> risultati = dao.cercaProdotti(term);

        // Configura la risposta JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Serializza i risultati in formato JSON e inviali al client
        new Gson().toJson(risultati, response.getWriter());
    }
}