package it.unisa.controller;

import it.unisa.model.ProdottoDAOImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/eliminaProdotto")
public class EliminaProdotto extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProdottoDAOImpl prodottoDAO = new ProdottoDAOImpl();
        // TODO: gestire vincolo d'integrità referenziale (es: non eliminare se ci sono ordini associati)
        prodottoDAO.deleteById(id);
        response.sendRedirect("gestioneProdotti.jsp");
    }
}
