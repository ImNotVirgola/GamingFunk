package it.unisa.controller;

import it.unisa.model.Prodotto;
import it.unisa.model.ProdottoDAOImpl;
import it.unisa.model.Utente;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/aggiungiProdotto")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,
                 maxFileSize = 1024 * 1024 * 10,
                 maxRequestSize = 1024 * 1024 * 15)
public class AggiungiProdotto extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	HttpSession session = request.getSession(false);
    	
    	Utente admin = (Utente) session.getAttribute("utente");
    	
    	int idAdmin = 0;
    	
    	if(admin.getRuolo().equalsIgnoreCase("admin")) idAdmin = admin.getIdUtente();
    	
        String nome = request.getParameter("nome");
        String descrizione = request.getParameter("descrizione");
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));
        int quantita = Integer.parseInt(request.getParameter("quantita"));
        int categoria = Integer.parseInt(request.getParameter("categoria"));

        Prodotto prodotto = new Prodotto();
        prodotto.setNome(nome);
        prodotto.setDescrizione(descrizione);
        prodotto.setPrezzo(prezzo);
        prodotto.setQuantitaDisponibile(quantita);
        prodotto.setIdCategoria(categoria);
        prodotto.setMediaRecensioni(0.0);
        prodotto.setIdAdmin(idAdmin);


        ProdottoDAOImpl dao = new ProdottoDAOImpl();
        int idGenerato = dao.addAndReturnId(prodotto);

        if (idGenerato > 0) {
        	// Gestione del file caricato
            Part filePart = request.getPart("immagine");
            String fileName = "";

            if (filePart != null && filePart.getSize() > 0) {
                // Genera il nome del file basato sul nome dell'utente
                fileName = idGenerato + ".png";

                // Percorso relativo alla directory "images/profile"
                String relativePath = "images/products";

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
                fileName = prodotto.getPathImmagine(); // Usa l'immagine esistente se non viene caricata una nuova
            }
            
            prodotto.setIdProdotto(idGenerato);
            prodotto.setPathImmagine(fileName);
            
            dao.update(prodotto);

            response.sendRedirect("catalogo.jsp");
        }

    }
}

