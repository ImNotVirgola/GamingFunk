package it.unisa.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/rimuovi-dal-carrello")
public class RimuoviDalCarrello extends HttpServlet {
    
	private static final long serialVersionUID = 5217331756262833188L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> carrello = (List<Map<String, Object>>) session.getAttribute("carrello");

        if (carrello != null) {
            String indiceStr = request.getParameter("indice");
            if (indiceStr != null) {
                int indice = Integer.parseInt(indiceStr);
                if (indice >= 0 && indice < carrello.size()) {
                    carrello.remove(indice);
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/carrello.jsp");
    }
}