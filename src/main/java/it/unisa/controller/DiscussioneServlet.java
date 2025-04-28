package it.unisa.controller;

import it.unisa.model.Discussione;
import it.unisa.model.DiscussioneDAOImpl;
import it.unisa.model.Forum;
import it.unisa.model.ForumDAOImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DiscussioneServlet")
public class DiscussioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	
    private DiscussioneDAOImpl discussioneDAO = new DiscussioneDAOImpl();
    private ForumDAOImpl forumDAO = new ForumDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            // Mostra tutte le discussioni di un forum
            int forumId = Integer.parseInt(request.getParameter("forumId"));
            List<Discussione> discussioni = discussioneDAO.getAllByForum(forumId);
            request.setAttribute("discussioni", discussioni);
            request.setAttribute("forumId", forumId);
            request.getRequestDispatcher("forum.jsp").forward(request, response);
        } else if (action.equals("dettaglio")) {
            int discussioneId = Integer.parseInt(request.getParameter("discussioneId"));
            Discussione discussione = discussioneDAO.getById(discussioneId);
            request.setAttribute("discussione", discussione);
            request.getRequestDispatcher("discussione.jsp").forward(request, response);
        } else if (action.equals("nuova")) {
            int forumId = Integer.parseInt(request.getParameter("forumId"));
            request.setAttribute("forumId", forumId);
            request.getRequestDispatcher("nuovaDiscussione.jsp").forward(request, response);
        } else if (action.equals("nuovoPost")) {
            int discussioneId = Integer.parseInt(request.getParameter("discussioneId"));
            request.setAttribute("discussioneId", discussioneId);
            request.getRequestDispatcher("nuovoPost.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.equals("creaDiscussione")) {
            int forumId = Integer.parseInt(request.getParameter("forumId"));
            String titolo = request.getParameter("titolo");
            String contenuto = request.getParameter("contenuto");
            Discussione discussione = new Discussione();
            discussione.setIdForum(forumId);
            discussione.setTitolo(titolo);
            discussione.setContenuto(contenuto);
            discussioneDAO.add(discussione);
            response.sendRedirect("DiscussioneServlet?forumId=" + forumId);
        } else if (action != null && action.equals("creaPost")) {
            int discussioneId = Integer.parseInt(request.getParameter("discussioneId"));
            String contenuto = request.getParameter("contenuto");
            //discussioneDAO.doSavePost(discussioneId, contenuto);
            response.sendRedirect("DiscussioneServlet?action=dettaglio&discussioneId=" + discussioneId);
        }
    }
}
