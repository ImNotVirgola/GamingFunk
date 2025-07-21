package it.unisa.controller;

import it.unisa.model.Prodotto;
import it.unisa.model.ProdottoDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/modificaProdotto")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,    // 2MB
                 maxFileSize = 1024 * 1024 * 10,         // 10MB
                 maxRequestSize = 1024 * 1024 * 50)      // 50MB
public class ModificaProdotto extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String RELATIVE_PATH = "images/prodotti";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String descrizione = request.getParameter("descrizione");
            double prezzo = Double.parseDouble(request.getParameter("prezzo"));
            int quantita = Integer.parseInt(request.getParameter("quantita"));
            int idCategoria = Integer.parseInt(request.getParameter("categoria"));

            ProdottoDAOImpl dao = new ProdottoDAOImpl();
            Prodotto prodotto = dao.getById(id);

            if (prodotto == null) {
                response.sendRedirect("errore.jsp");
                return;
            }

            // Aggiorna i campi
            prodotto.setNome(nome);
            prodotto.setDescrizione(descrizione);
            prodotto.setPrezzo(prezzo);
            prodotto.setQuantitaDisponibile(quantita);
            prodotto.setIdCategoria(idCategoria);

            // Gestione immagine (se presente)
            Part filePart = request.getPart("immagine");
            String fileName = filePart.getSubmittedFileName();

            if (fileName != null && !fileName.isEmpty()) {
                // Percorso reale per salvataggio immagini
                String uploadPath = getServletContext().getRealPath("/") + RELATIVE_PATH;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists() && !uploadDir.mkdirs()) {
                    throw new IOException("❌ Impossibile creare la directory immagini: " + uploadPath);
                }

                // Nuovo nome file: prodotto<ID>.png
                String nuovoNome = id + ".png";
                File storeFile = new File(uploadDir, nuovoNome);

                // Elimina immagine precedente se esiste
                if (storeFile.exists() && !storeFile.delete()) {
                    System.err.println("⚠️ Non sono riuscito a eliminare l'immagine precedente.");
                }

                // Salva nuova immagine
                filePart.write(storeFile.getAbsolutePath());

                // Aggiorna path immagine
                String pathNelDB = RELATIVE_PATH + "/" + nuovoNome;
                prodotto.setPathImmagine(pathNelDB);
            }

            dao.update(prodotto);
            response.sendRedirect("catalogo.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Errore durante la modifica del prodotto.");
            request.getRequestDispatcher("errore.jsp").forward(request, response);
        }
    }
}
