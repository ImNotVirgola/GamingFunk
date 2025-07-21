package it.unisa.controller;

import it.unisa.model.Ordine;
import it.unisa.model.OrdineDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/gestioneOrdini")
public class VisualizzaOrdiniUtentiServlet extends HttpServlet {
   
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

		String filtroIdUtente = request.getParameter("idUtente");
        String dataInizio = request.getParameter("dataInizio");
        String dataFine = request.getParameter("dataFine");

        OrdineDAOImpl ordineDAO = new OrdineDAOImpl();
        List<Ordine> ordini;

        boolean hasId = filtroIdUtente != null && !filtroIdUtente.trim().isEmpty();
        boolean hasDataRange = dataInizio != null && !dataInizio.trim().isEmpty()
                             && dataFine != null && !dataFine.trim().isEmpty();

        try {
            if (hasId && hasDataRange) {
                ordini = ordineDAO.getOrdiniByIdAndDateRange(Integer.parseInt(filtroIdUtente), dataInizio, dataFine);
            } else if (hasId) {
                ordini = ordineDAO.getOrdiniByUtente(Integer.parseInt(filtroIdUtente));
            } else if (hasDataRange) {
                ordini = ordineDAO.getOrdiniByDateRange(dataInizio, dataFine);
            } else {
                ordini = ordineDAO.getAllOrdini();
            }
        } catch (NumberFormatException e) {
            ordini = ordineDAO.getAllOrdini(); // fallback se id non valido
        }

        request.setAttribute("ordini", ordini);
        request.getRequestDispatcher("gestioneOrdini.jsp").forward(request, response);
    }
}
