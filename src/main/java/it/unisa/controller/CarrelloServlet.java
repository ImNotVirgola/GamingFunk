package it.unisa.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@WebServlet("/carrello-servlet")
public class CarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("get".equals(action)) {
            // Recupera il carrello dalla sessione
            List<CarrelloItem> carrello = (List<CarrelloItem>) session.getAttribute("carrello");
            if (carrello == null) {
                carrello = new ArrayList<>();
            }

            // Invia il carrello come risposta JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(carrello));
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            // Legge il carrello dal corpo della richiesta
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            String json = sb.toString();

            // Converte il JSON in una lista di oggetti CarrelloItem
            List<CarrelloItem> carrello = new Gson().fromJson(json, new TypeToken<List<CarrelloItem>>() {}.getType());

            // Salva il carrello nella sessione
            session.setAttribute("carrello", carrello);

            // Risponde con successo
            response.setStatus(HttpServletResponse.SC_OK);
        }
    }
}

class CarrelloItem {
    private String nome;
    private double prezzo;
    private int quantità;

    // Getters e Setters
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(double prezzo) {
        this.prezzo = prezzo;
    }

    public int getQuantità() {
        return quantità;
    }

    public void setQuantità(int quantità) {
        this.quantità = quantità;
    }
}