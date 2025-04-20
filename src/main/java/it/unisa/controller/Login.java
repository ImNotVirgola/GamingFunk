package it.unisa.controller;

import it.unisa.model.*;
import it.unisa.model.Utente;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/login")
public class Login extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final model servizio = new model(); // Assicurati che "Model" sia il nome corretto della tua classe model

    // Metodo per gestire le richieste GET (mostra il form di login)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera l'URL originale se presente
        String redirectUrl = request.getParameter("redirect");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            request.setAttribute("redirectUrl", redirectUrl);
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    // Metodo per gestire le richieste POST (elabora i dati del form di login)
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

        // Cerca l'utente nel database
        Utente utente = servizio.getUtenteByEmail(email);
        
        String storedHashedPassword = utente.getPassword(); // Recupera l'hash dal database
        String enteredPassword = request.getParameter("password"); // Password inserita dall'utente

        if (BCrypt.checkpw(enteredPassword, storedHashedPassword) && utente != null) {
        	HttpSession session = request.getSession();
            session.setAttribute("utente", utente);
            session.setAttribute("email", utente.getEmail());
            session.setAttribute("nome", utente.getNome());
            session.setAttribute("cognome", utente.getCognome());
            session.setAttribute("indirizzo", utente.getIndirizzo());
            session.setAttribute("citta", utente.getCitta());
            session.setAttribute("provincia", utente.getProvincia());
            session.setAttribute("cap", utente.getCap());
<<<<<<< Updated upstream
            session.setAttribute("ruolo", utente.getRuolo());
            session.setAttribute("fotoProfilo", utente.getImmagine());

            // Reindirizza all'URL originale o alla home
            String redirectUrl = request.getParameter("redirect");
            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/catalogo.jsp");
            }
=======
            session.setAttribute("fotoProfilo", utente.getImmagine());
            session.setAttribute("password", utente.getPassword());
            response.sendRedirect(request.getContextPath() + "/catalogo.jsp");
>>>>>>> Stashed changes
        } else {
            // Login fallito: mostra un messaggio di errore
            request.setAttribute("errorMessage", "Email o password errati.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}