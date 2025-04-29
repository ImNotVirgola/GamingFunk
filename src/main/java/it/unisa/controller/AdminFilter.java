package it.unisa.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "AdminFilter", urlPatterns = {"/gestioneProdotti.jsp", "/modificaProdotto.jsp", "/nuovoProdotto.jsp", "/utenti.jsp", "/ordini.jsp"})
public class AdminFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Nessuna inizializzazione necessaria
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isAdmin = false;
        if (session != null && session.getAttribute("utente") != null) {
            Object utenteObj = session.getAttribute("utente");
            try {
                // Assumiamo che il metodo getRuolo() esista in Utente
                String ruolo = (String) utenteObj.getClass().getMethod("getRuolo").invoke(utenteObj);
                if (ruolo != null && ruolo.equals("admin")) {
                    isAdmin = true;
                }
            } catch (Exception e) {
                // In caso di errore, non permettere l'accesso
                isAdmin = false;
            }
        }

        if (!isAdmin) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/catalogo.jsp?errore=accesso_admin");
            return;
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Nessuna risorsa da liberare
    }
}
