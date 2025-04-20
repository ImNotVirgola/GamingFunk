package it.unisa.controller;

import it.unisa.model.*;
import it.unisa.model.Utente;
import org.mindrot.jbcrypt.BCrypt; // Importa BCrypt

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
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String indirizzo = request.getParameter("indirizzo");
        String citta = request.getParameter("citta");
        String provincia = request.getParameter("provincia");
        String cap = request.getParameter("cap");

        // Inizializza una stringa per gli errori
        StringBuilder errorMessages = new StringBuilder();

        // Validazione del campo Nome
        if (nome == null || nome.trim().isEmpty()) {
            errorMessages.append("Il campo Nome è obbligatorio.<br>");
        } else if (!isValidName(nome)) {
            errorMessages.append("Il nome contiene caratteri non validi. Sono ammesse solo lettere e spazi.<br>");
        }

        // Validazione del campo Cognome
        if (cognome == null || cognome.trim().isEmpty()) {
            errorMessages.append("Il campo Cognome è obbligatorio.<br>");
        } else if (!isValidName(cognome)) {
            errorMessages.append("Il cognome contiene caratteri non validi. Sono ammesse solo lettere e spazi.<br>");
        }

        // Validazione del campo Email
        if (email == null || email.trim().isEmpty()) {
            errorMessages.append("Il campo Email è obbligatorio.<br>");
        } else if (!isValidEmail(email)) {
            errorMessages.append("L'email inserita non è valida.<br>");
        }

        // Verifica se l'email è già registrata
        Utente utenteEsistente = servizio.getUtenteByEmail(email);
        if (utenteEsistente != null) {
            errorMessages.append("L'email è già registrata. Prova con un'altra.<br>");
        }

        // Validazione del campo Password
        if (password == null || password.trim().isEmpty()) {
            errorMessages.append("Il campo Password è obbligatorio.<br>");
        } else if (password.length() < 6) {
            errorMessages.append("La password deve contenere almeno 6 caratteri.<br>");
        } else if (!isValidPassword(password)) {
            errorMessages.append("La password deve contenere almeno una lettera maiuscola, una minuscola, un numero e un carattere speciale.<br>");
        }

        // Validazione del campo Conferma Password
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errorMessages.append("Il campo Conferma Password è obbligatorio.<br>");
        } else if (!password.equals(confirmPassword)) {
            errorMessages.append("Le password non corrispondono.<br>");
        }

        // Validazione del campo Indirizzo (opzionale)
        if (indirizzo != null && !indirizzo.trim().isEmpty() && !isValidAddress(indirizzo)) {
            errorMessages.append("L'indirizzo contiene caratteri non validi.<br>");
        }

        // Validazione del campo CAP (opzionale)
        if (cap != null && !cap.trim().isEmpty() && !isValidCAP(cap)) {
            errorMessages.append("Il CAP inserito non è valido. Deve essere composto da 5 cifre numeriche.<br>");
        }

        // Se ci sono errori, memorizza il messaggio di errore nella sessione e reindirizza alla pagina di registrazione
        if (errorMessages.length() > 0) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", errorMessages.toString());
            response.sendRedirect(request.getContextPath() + "/register.jsp");
            return;
        }

        // Cripta la password usando BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Crea un nuovo oggetto Utente
        Utente nuovoUtente = new Utente();
        nuovoUtente.setNome(nome);
        nuovoUtente.setCognome(cognome);
        nuovoUtente.setEmail(email);
        nuovoUtente.setPassword(hashedPassword); // Salva la password criptata
        nuovoUtente.setIndirizzo(indirizzo);
        nuovoUtente.setCitta(citta);
        nuovoUtente.setProvincia(provincia);
        nuovoUtente.setCap(cap);
        nuovoUtente.setRuolo("regular"); // Imposta ruolo predefinito

        // Aggiungi l'utente al database
        boolean success = servizio.aggiungiUtente(nuovoUtente);

        if (success) {
            // Registrazione riuscita: reindirizza al form di login con un messaggio di successo
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Registrazione avvenuta con successo!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            // Registrazione fallita: memorizza il messaggio di errore nella sessione e reindirizza al form di registrazione
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Errore durante la registrazione. Riprova.");
            response.sendRedirect(request.getContextPath() + "/register.jsp");
        }
    }

    // Metodo per validare il formato dell'email
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }

    // Metodo per validare il formato del nome e cognome
    private boolean isValidName(String name) {
        String nameRegex = "^[a-zA-ZÀ-ù ]+$";
        Pattern pattern = Pattern.compile(nameRegex);
        return pattern.matcher(name).matches();
    }

    // Metodo per validare il formato della password
    private boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{6,}$";
        Pattern pattern = Pattern.compile(passwordRegex);
        return pattern.matcher(password).matches();
    }

    // Metodo per validare il formato dell'indirizzo
    private boolean isValidAddress(String address) {
        String addressRegex = "^[a-zA-Z0-9À-ù ,.'-]+$";
        Pattern pattern = Pattern.compile(addressRegex);
        return pattern.matcher(address).matches();
    }

    // Metodo per validare il formato del CAP
    private boolean isValidCAP(String cap) {
        String capRegex = "^\\d{5}$";
        Pattern pattern = Pattern.compile(capRegex);
        return pattern.matcher(cap).matches();
    }
}