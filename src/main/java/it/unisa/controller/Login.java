package it.unisa.controller;

import it.unisa.model.*;
import it.unisa.model.Utente;



import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class Login extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final model servizio = new model();

    // Metodo per gestire le richieste GET (mostra il form di login)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    // Metodo per gestire le richieste POST (elabora i dati del form di login)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Cerca l'utente nel database
        Utente utente = servizio.getUtenteByEmail(email);

        if (utente != null && utente.getPassword().equals(password)) {
            // Login riuscito: crea una sessione e reindirizza alla home
            HttpSession session = request.getSession();
            session.setAttribute("utente", utente);
            session.setAttribute("email", utente.getEmail());
            session.setAttribute("nome", utente.getNome());
            session.setAttribute("cognome", utente.getCognome());
            session.setAttribute("indirizzo", utente.getIndirizzo());
            session.setAttribute("citta", utente.getCitta());
            session.setAttribute("provincia", utente.getProvincia());
            session.setAttribute("cap", utente.getCap());
            session.setAttribute("ruolo", utente.getRuolo());
            session.setAttribute("fotoProfilo", utente.getImmagine());
            response.sendRedirect(request.getContextPath() + "/catalogo.jsp");
        } else {
            // Login fallito: reindirizza al form di login con un messaggio di errore
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=true");
        }
    }
}