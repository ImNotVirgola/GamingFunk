package it.unisa.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/svuota-carrello")
public class SvuotaCarrello extends HttpServlet {
    
	private static final long serialVersionUID = 8366374445460239364L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("carrello");

        response.sendRedirect(request.getContextPath() + "/carrello.jsp");
    }
}