package it.unisa.controller;

import it.unisa.model.*;
import it.unisa.model.Utente;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/register")
public class Register extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private final model servizio = new model();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera i parametri dal form
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Inizializza una stringa per gli errori
        StringBuilder errorMessages = new StringBuilder();

        // Validazione dei campi
        if (username == null || username.trim().isEmpty()) {
            errorMessages.append("Il campo Username è obbligatorio.<br>");
        }
        if (email == null || email.trim().isEmpty()) {
            errorMessages.append("Il campo Email è obbligatorio.<br>");
        } else if (!isValidEmail(email)) {
            errorMessages.append("L'email inserita non è valida.<br>");
        }
        if (password == null || password.trim().isEmpty()) {
            errorMessages.append("Il campo Password è obbligatorio.<br>");
        } else if (password.length() < 6) {
            errorMessages.append("La password deve contenere almeno 6 caratteri.<br>");
        }
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errorMessages.append("Il campo Conferma Password è obbligatorio.<br>");
        } else if (!password.equals(confirmPassword)) {
            errorMessages.append("Le password non corrispondono.<br>");
        }

        // Verifica se l'email è già registrata
        Utente utenteEsistente = servizio.getUtenteByEmail(email);
        if (utenteEsistente != null) {
            errorMessages.append("L'email è già registrata. Prova con un'altra.<br>");
        }

        // Se ci sono errori, reindirizza alla pagina di registrazione con i messaggi di errore
        if (errorMessages.length() > 0) {
            response.sendRedirect(request.getContextPath() + "/register.jsp?error=" + errorMessages.toString());
            return;
        }

        // Crea un nuovo oggetto Utente
        Utente nuovoUtente = new Utente();
        nuovoUtente.setNome(username); // Usa "username" come nome utente
        nuovoUtente.setEmail(email);
        nuovoUtente.setPassword(password);
        nuovoUtente.setRuolo("regular"); // Imposta ruolo predefinito

        // Aggiungi l'utente al database
        boolean success = servizio.aggiungiUtente(nuovoUtente);

        if (success) {
            // Registrazione riuscita: reindirizza al form di login con un messaggio di successo
            response.sendRedirect(request.getContextPath() + "/login.jsp?success=true");
        } else {
            // Registrazione fallita: reindirizza al form di registrazione con un messaggio di errore
            response.sendRedirect(request.getContextPath() + "/register.jsp?error=Errore durante la registrazione. Riprova.");
        }
    }

    // Metodo per validare il formato dell'email
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }
}