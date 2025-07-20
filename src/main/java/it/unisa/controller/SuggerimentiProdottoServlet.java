package it.unisa.controller;

import it.unisa.model.ProdottoDAOImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.google.gson.Gson;

import java.io.IOException;
import java.util.List;



@WebServlet("/suggerimenti")
public class SuggerimentiProdottoServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String term = request.getParameter("term");
        //if (term == null || term.length() < 2) return;
        if (term == null || term.trim().isEmpty()) return;

        ProdottoDAOImpl dao = new ProdottoDAOImpl();
        List<String> risultati = dao.getNomiProdottiSimili(term);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        new Gson().toJson(risultati, response.getWriter());
    }
}
