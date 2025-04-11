package it.unisa.controller;

import it.unisa.model.Prodotto;
import it.unisa.model.ProdottoDAOImpl;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/catalogo")
public class Catalogo extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProdottoDAOImpl prodottoDAO;

    @Override
    public void init() throws ServletException {
        prodottoDAO = new ProdottoDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setAttribute("fromServlet", true);
    	
        // Recupera tutti i prodotti dal database
        List<Prodotto> prodotti = prodottoDAO.getAll();

        // Passa i prodotti alla View
        request.setAttribute("prodotti", prodotti);

        // Inoltra la richiesta alla View JSP
        request.getRequestDispatcher("catalogo.jsp").forward(request, response);
    }
}