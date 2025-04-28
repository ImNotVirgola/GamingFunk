package it.unisa.controller;

import it.unisa.model.*;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/login")
public class Login extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final model servizio = new model(); // Assicurati che "Model" sia il nome corretto della tua classe model

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera l'URL originale se presente e inoltra alla pagina di login
        String redirectUrl = request.getParameter("redirect");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            request.setAttribute("redirectUrl", redirectUrl);
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera i parametri del form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validazione dei parametri
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Inserisci email e password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            // Cerca l'utente nel database
            Utente utente = servizio.getUtenteByEmail(email);

            // Verifica se l'utente esiste e la password è corretta
            if (utente != null && BCrypt.checkpw(password, utente.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("utente", utente);
                session.setAttribute("email", utente.getEmail());
                session.setAttribute("nome", utente.getNome());
                session.setAttribute("cognome", utente.getCognome());
                session.setAttribute("indirizzo", utente.getIndirizzo());
                session.setAttribute("ruolo", utente.getRuolo());
                session.setAttribute("fotoProfilo", utente.getImmagine());

                // Reindirizza all'URL originale o alla home
                String redirectUrl = request.getParameter("redirect");
                if (redirectUrl != null && !redirectUrl.isEmpty()) {
                    response.sendRedirect(redirectUrl);
                } else {
                    response.sendRedirect(request.getContextPath() + "/catalogo.jsp");
                }
            } else {
                // Login fallito: mostra un messaggio di errore
                request.setAttribute("errorMessage", "Email o password errati.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Gestione generica degli errori
            request.setAttribute("errorMessage", "Si è verificato un errore durante il login. Riprova più tardi.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}