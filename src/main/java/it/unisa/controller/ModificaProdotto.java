package it.unisa.controller;

import it.unisa.model.Prodotto;
import it.unisa.model.ProdottoDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@WebServlet("/modificaProdotto")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,    // 2MB
                 maxFileSize = 1024 * 1024 * 10,         // 10MB
                 maxRequestSize = 1024 * 1024 * 50)      // 50MB
public class ModificaProdotto extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String descrizione = request.getParameter("descrizione");
            double prezzo = Double.parseDouble(request.getParameter("prezzo"));
            int quantita = Integer.parseInt(request.getParameter("quantita"));
            int idCategoria = Integer.parseInt(request.getParameter("categoria"));

            // Gestione file immagine (se presente)
            Part filePart = request.getPart("immagine");
            String fileName = filePart.getSubmittedFileName();
            String pathImmagine = null;

            if (fileName != null && !fileName.isEmpty()) {
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images" + File.separator + "prodotti";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String fullPath = uploadPath + File.separator + fileName;
                filePart.write(fullPath);

                pathImmagine = "images/prodotti/" + fileName;
            }

            ProdottoDAOImpl dao = new ProdottoDAOImpl();
            Prodotto prodotto = dao.getById(id);
            if (prodotto != null) {
                prodotto.setNome(nome);
                prodotto.setDescrizione(descrizione);
                prodotto.setPrezzo(prezzo);
                prodotto.setQuantitaDisponibile(quantita);
                prodotto.setIdCategoria(idCategoria);

                if (pathImmagine != null) {
                    prodotto.setPathImmagine(pathImmagine);
                }

                dao.update(prodotto);
            }

            response.sendRedirect("catalogo.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Errore durante la modifica del prodotto.");
            request.getRequestDispatcher("errore.jsp").forward(request, response);
        }
    }
}