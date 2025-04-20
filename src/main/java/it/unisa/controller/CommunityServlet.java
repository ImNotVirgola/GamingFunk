package it.unisa.controller;

import it.unisa.model.Community;
import it.unisa.model.CommunityDAOImpl;
import it.unisa.model.Forum;
import it.unisa.model.ForumDAOImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/CommunityServlet")
public class CommunityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private CommunityDAOImpl communityDAO = new CommunityDAOImpl();
    private ForumDAOImpl forumDAO = new ForumDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            // Mostra tutte le community
            List<Community> communities = communityDAO.getAll();
            request.setAttribute("communities", communities);
            request.getRequestDispatcher("community.jsp").forward(request, response);
        } else if (action.equals("forum")) {
            int communityId = Integer.parseInt(request.getParameter("communityId"));
            List<Forum> forumList = forumDAO.getForumByCommunity(communityId);
            request.setAttribute("forumList", forumList);
            request.setAttribute("communityId", communityId);
            request.getRequestDispatcher("forum.jsp").forward(request, response);
        } else if (action.equals("nuova")) {
            // Mostra pagina creazione nuova community
            request.getRequestDispatcher("nuovaCommunity.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.equals("creaCommunity")) {
            String nome = request.getParameter("nome");
            String descrizione = request.getParameter("descrizione");
            Community community = new Community();
            community.setNome(nome);
            community.setDescrizione(descrizione);
            communityDAO.add(community);
            response.sendRedirect("CommunityServlet");
        }
    }
}
