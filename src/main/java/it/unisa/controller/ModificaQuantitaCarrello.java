package it.unisa.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/modifica-quantita-carrello")
public class ModificaQuantitaCarrello extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Map<String, Object>> carrello = (List<Map<String, Object>>) session.getAttribute("carrello");
        String indiceStr = request.getParameter("indice");
        String azione = request.getParameter("azione");

        if (carrello != null && indiceStr != null && azione != null) {
            int indice = Integer.parseInt(indiceStr);
            if (indice >= 0 && indice < carrello.size()) {
                Map<String, Object> item = carrello.get(indice);
                int quantita = Integer.parseInt(item.get("quantità").toString());

                if (azione.equals("aumenta")) {
                    item.put("quantità", quantita + 1);
                } else if (azione.equals("diminuisci") && quantita > 1) {
                    item.put("quantità", quantita - 1);
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/carrello.jsp");
    }
}