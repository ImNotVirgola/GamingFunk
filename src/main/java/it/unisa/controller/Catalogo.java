package it.unisa.controller;

import it.unisa.model.Categoria;
import it.unisa.model.CategoriaDAOImpl;
import it.unisa.model.Prodotto;
import it.unisa.model.ProdottoDAOImpl;


import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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
	private CategoriaDAOImpl categoriaDAO;

    @Override
    public void init() throws ServletException {
        prodottoDAO = new ProdottoDAOImpl();
        categoriaDAO = new CategoriaDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setAttribute("fromServlet", true);
    	String catName = request.getParameter("categoria");
    	int cat = 0;
    	if(catName != null) {
    		cat = categoriaDAO.getIdByName(catName);
    	}
    	List<Prodotto> prodotti = new ArrayList<Prodotto>();
    	
    	
    	if(cat == 0) {
    		prodotti = prodottoDAO.getProdottiAttivi();
    	} else {
    		try {
				prodotti = prodottoDAO.getFilteredProducts(cat);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	
        // Recupera tutti i prodotti dal database
    	
        List<Categoria> categorie = categoriaDAO.getAll();

        // Passa i prodotti alla View
        request.setAttribute("prodotti", prodotti);
        request.setAttribute("categorie", categorie);

        // Inoltra la richiesta alla View JSP
        request.getRequestDispatcher("catalogo.jsp").forward(request, response);
    }
}