package it.unisa.controller;

import it.unisa.model.Prodotto;
import it.unisa.model.ProdottoDAOImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/modificaProdotto")
public class ModificaProdotto extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        int categoria = Integer.parseInt(request.getParameter("categoria"));
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));
        int quantita = Integer.parseInt(request.getParameter("quantita"));
        ProdottoDAOImpl prodottoDAO = new ProdottoDAOImpl();
        Prodotto prodotto = prodottoDAO.getById(id);
        prodotto.setNome(nome);
        prodotto.setIdCategoria(categoria);
        prodotto.setPrezzo(prezzo);
        prodotto.setQuantitaDisponibile(quantita);
        prodottoDAO.update(prodotto);
        response.sendRedirect("gestioneProdotti.jsp");
    }
}
