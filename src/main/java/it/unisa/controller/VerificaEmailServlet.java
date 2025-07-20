package it.unisa.controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.UtenteDAOImpl;

/**
 * Servlet implementation class VerificaEmailServlet
 */
@WebServlet("/verificaEmail")
public class VerificaEmailServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        boolean esiste = false;

        if (email != null && !email.isEmpty()) {
            esiste = UtenteDAOImpl.emailExists(email);
        }

        response.setContentType("application/json");
        response.getWriter().write("{\"esiste\": " + esiste + "}");
    }
}
