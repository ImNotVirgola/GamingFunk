package it.unisa.controller;

import it.unisa.model.Utente;
import it.unisa.model.UtenteDAOImpl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/updateProfile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,   // 5 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class AggiornaProfilo extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        final UtenteDAOImpl utenteDAO = new UtenteDAOImpl();

        // Verifica se la sessione esiste
        if (session == null || session.getAttribute("utente") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Recupera l'utente dalla sessione
        Utente utente = (Utente) session.getAttribute("utente");

        // Recupera i parametri del form
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String indirizzo = request.getParameter("indirizzo");
        String citta = request.getParameter("citta");
        String provincia = request.getParameter("provincia");
        String cap = request.getParameter("cap");
        String password = request.getParameter("password");

        // Controlla e assegna i valori per ciascun parametro
        nome = (nome == null || nome.trim().isEmpty()) ? utente.getNome() : nome;
        cognome = (cognome == null || cognome.trim().isEmpty()) ? utente.getCognome() : cognome;
        email = (email == null || email.trim().isEmpty()) ? utente.getEmail() : email;
        indirizzo = (indirizzo == null || indirizzo.trim().isEmpty()) ? utente.getIndirizzo() : indirizzo;
        citta = (citta == null || citta.trim().isEmpty()) ? utente.getCitta() : citta;
        provincia = (provincia == null || provincia.trim().isEmpty()) ? utente.getProvincia() : provincia;
        cap = (cap == null || cap.trim().isEmpty()) ? utente.getCap() : cap;
        password = (password == null || password.trim().isEmpty()) ? utente.getPassword() : password;

        // Gestione del file caricato
        Part filePart = request.getPart("immagine");
        String fileName = "";

        if (filePart != null && filePart.getSize() > 0) {
            // Genera il nome del file basato sul nome dell'utente
            fileName = utente.getNome() + utente.getIdUtente() + ".png";

            // Percorso relativo alla directory "images/profile"
            String relativePath = "images/profile";

            // Percorso assoluto della directory di upload
            String uploadPath = getServletContext().getRealPath(relativePath);

            // Crea la directory se non esiste
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean dirCreated = uploadDir.mkdirs();
                if (!dirCreated) {
                    throw new IOException("Impossibile creare la directory: " + uploadPath);
                }
            }

            // Salva il file nella directory
            File file = new File(uploadDir, fileName);
            try (var inputStream = filePart.getInputStream()) {
                Files.copy(inputStream, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // Costruisci il percorso relativo per salvarlo nel database o utilizzarlo altrove
            fileName = relativePath.replace("\\", "/") + "/" + fileName;
        } else {
            fileName = utente.getImmagine(); // Usa l'immagine esistente se non viene caricata una nuova
        }

        // Aggiorna i dati dell'utente
        utente.setNome(nome);
        utente.setCognome(cognome);
        utente.setEmail(email);
        utente.setIndirizzo(indirizzo);
        utente.setCitta(citta);
        utente.setProvincia(provincia);
        utente.setCap(cap);
        utente.setPassword(password);
        utente.setImmagine(fileName); // Aggiorna il path dell'immagine profilo

        // Aggiorna i dati nel database tramite il DAO
        try {
            boolean success = utenteDAO.update(utente);
            if (!success) {
                response.getWriter().println("Errore durante l'aggiornamento dei dati.");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Errore durante l'aggiornamento dei dati.");
            return;
        }

        // Aggiorna l'utente nella sessione
        session.setAttribute("utente", utente);
        session.setAttribute("nome", nome);
        session.setAttribute("cognome", cognome);
        session.setAttribute("email", email);
        session.setAttribute("indirizzo", indirizzo);
        session.setAttribute("citta", citta);
        session.setAttribute("provincia", provincia);
        session.setAttribute("cap", cap);
        session.setAttribute("fotoProfilo", fileName);

        // Reindirizza alla pagina del profilo
        response.sendRedirect("profilo.jsp");
    }
}