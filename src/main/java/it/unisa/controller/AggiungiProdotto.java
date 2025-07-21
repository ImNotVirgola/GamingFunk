package it.unisa.controller;

import it.unisa.model.Prodotto;
import it.unisa.model.ProdottoDAOImpl;
import it.unisa.model.Utente;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/aggiungiProdotto")
public class AggiungiProdotto extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 10;
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 15;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utente admin = (Utente) session.getAttribute("utente");

        int idAdmin = 0;
        if (admin != null && admin.getRuolo().equalsIgnoreCase("admin")) {
            idAdmin = admin.getIdUtente();
        }


        if (!ServletFileUpload.isMultipartContent(request)) {
            response.getWriter().println("Errore: il form deve avere enctype=multipart/form-data");
            return;
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);

        String relativePath = "images/products";
        String uploadPath = "C:/Users/Riccardo/eclipse-workspace/GamingFunk/src/main/webapp/" + relativePath;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            if (!uploadDir.mkdirs()) {
                throw new IOException("Impossibile creare la directory immagini: " + uploadPath);
            }
        }
        System.out.println("Salverò il file in: " + uploadPath);


        if (!uploadDir.exists()) uploadDir.mkdirs();

        Map<String, String> fields = new HashMap<>();
        String imagePath = null;

        try {
            List<FileItem> formItems = upload.parseRequest(request);

            for (FileItem item : formItems) {
                if (item.isFormField()) {
                    fields.put(item.getFieldName(), item.getString("UTF-8"));
                } else {
                    if (item.getSize() > 0) {
                        imagePath = relativePath + File.separator + "temp"; // path temporaneo, sovrascritto dopo
                    }
                }
            }

            Prodotto prodotto = new Prodotto();
            prodotto.setNome(fields.get("nome"));
            prodotto.setDescrizione(fields.get("descrizione"));
            prodotto.setPrezzo(Double.parseDouble(fields.get("prezzo")));
            prodotto.setQuantitaDisponibile(Integer.parseInt(fields.get("quantita")));
            prodotto.setIdCategoria(Integer.parseInt(fields.get("categoria")));
            prodotto.setMediaRecensioni(0.0);
            prodotto.setIdAdmin(idAdmin);
            prodotto.setAttivo(1);

            ProdottoDAOImpl dao = new ProdottoDAOImpl();
            int idGenerato = dao.addAndReturnId(prodotto);
            
            prodotto.setIdProdotto(idGenerato);

            if (idGenerato > 0 && imagePath != null) {
                for (FileItem item : formItems) {
                    if (!item.isFormField() && item.getSize() > 0) {
                        String fileName = idGenerato + ".png";
                        File storeFile = new File(uploadDir, fileName);
                        item.write(storeFile);

                        // SALVA IL PATH CORRETTO NEL DATABASE
                        String pathNelDB = relativePath + "/" + fileName;
                        prodotto.setPathImmagine(pathNelDB);
                        System.out.println("Salvataggio path immagine: " + prodotto.getPathImmagine());
                        System.out.println("ID prodotto: " + prodotto.getIdProdotto());
                        dao.update(prodotto);

                        dao.update(prodotto);

                        System.out.println("Salvato path nel DB: " + pathNelDB);
                    }
                }
            }


            response.sendRedirect("catalogo.jsp");

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("message", "Errore durante il caricamento: " + ex.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
