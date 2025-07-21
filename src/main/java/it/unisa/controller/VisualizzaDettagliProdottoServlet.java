package it.unisa.controller;

import it.unisa.model.Prodotto;
import it.unisa.model.ProdottoDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/visualizzaProdotto")
public class VisualizzaDettagliProdottoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("catalogo.jsp");
            return;
        }

        int idProdotto;
        try {
            idProdotto = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("catalogo.jsp");
            return;
        }

        ProdottoDAOImpl prodottoDAO = new ProdottoDAOImpl();
        Prodotto prodotto = prodottoDAO.getById(idProdotto);

        if (prodotto == null || prodotto.getAttivo() == 0) {
            response.sendRedirect("catalogo.jsp");
            return;
        }

        request.setAttribute("prodotto", prodotto);

        Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
        request.setAttribute("isAdmin", isAdmin != null ? isAdmin : false);

        request.getRequestDispatcher("dettagliProdotto.jsp").forward(request, response);
    }
}
