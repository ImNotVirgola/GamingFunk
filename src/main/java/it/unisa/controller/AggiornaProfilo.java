package it.unisa.controller;

import it.unisa.model.Utente;
import it.unisa.model.UtenteDAOImpl;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/updateProfile")
public class AggiornaProfilo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Limiti di memoria e dimensione file per l'upload
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB: soglia per scrivere su disco
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 5;     // 5MB: dimensione massima per un singolo file
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 10; // 10MB: dimensione massima dell'intera richiesta

    // Percorso relativo dove salvare le immagini profilo
    private static final String RELATIVE_PATH = "images/profile";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Recupera la sessione e l'utente autenticato
        HttpSession session = request.getSession(false);
        Utente utente = (session != null) ? (Utente) session.getAttribute("utente") : null;

        // Se l'utente non è loggato, reindirizza al login
        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Verifica che il form sia multipart (necessario per l'upload dei file)
        if (!ServletFileUpload.isMultipartContent(request)) {
            response.getWriter().println("Errore: il form deve avere enctype=multipart/form-data");
            return;
        }

        // Percorso assoluto della directory dove salvare le immagini, calcolato in base al server (es. wtpwebapps)
        String uploadPath = getServletContext().getRealPath("/") + RELATIVE_PATH;

        // Crea la directory se non esiste
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists() && !uploadDir.mkdirs()) {
            throw new IOException("❌ Impossibile creare la directory immagini: " + uploadPath);
        }

        try {
            // Imposta la factory per gestire i file temporanei e dimensioni
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(MEMORY_THRESHOLD); // oltre questa soglia scrive su disco
            factory.setRepository(new File(System.getProperty("java.io.tmpdir"))); // cartella temporanea

            // Crea il gestore per l'upload
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setFileSizeMax(MAX_FILE_SIZE);
            upload.setSizeMax(MAX_REQUEST_SIZE);

            // Parsea la richiesta e ottiene tutti i campi del form
            List<FileItem> formItems = upload.parseRequest(request);
            String pathNelDB = null; // Percorso da salvare nel database

            for (FileItem item : formItems) {
                // Controlla se il campo è un file (non testo)
                if (!item.isFormField() && item.getSize() > 0) {

                    // Nome del file basato su nome utente e ID
                    String fileName = utente.getNome() + utente.getIdUtente() + ".png";
                    File storeFile = new File(uploadDir, fileName);

                    // Elimina il vecchio file immagine se già presente
                    if (storeFile.exists()) {
                        if (!storeFile.delete()) {
                            System.err.println("⚠️ Non sono riuscito a eliminare l'immagine precedente.");
                        }
                    }

                    // Salva il nuovo file sul server
                    item.write(storeFile);

                    // Percorso relativo da salvare nel database
                    pathNelDB = RELATIVE_PATH + "/" + fileName;
                }
            }

            // Se è stata caricata un'immagine, aggiorna il database
            if (pathNelDB != null) {
                utente.setImmagine(pathNelDB);
                boolean success = new UtenteDAOImpl().update(utente);

                if (success) {
                    // Aggiorna i dati nella sessione per mantenerli sincronizzati
                    session.setAttribute("utente", utente);
                    session.setAttribute("fotoProfilo", pathNelDB);
                    System.out.println("✔️ Foto profilo aggiornata: " + pathNelDB);
                } else {
                    System.out.println("❌ Errore durante l'update nel DB");
                }
            }

            // Dopo l'operazione, reindirizza alla pagina del profilo
            response.sendRedirect("profilo.jsp");

        } catch (Exception e) {
            // Gestione errori in caso di problemi con l'upload
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore durante il caricamento dell'immagine.");
        }
    }
}
