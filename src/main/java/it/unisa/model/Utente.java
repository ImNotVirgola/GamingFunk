package it.unisa.model;

public class Utente {
    private int idUtente;
    private String email;
    private String nome;
    private String cognome;
    private String indirizzo;
    private String citta;
    private String provincia;
    private String cap;
    private String password;
    private String ruolo;
    private Integer numOrdini;
    private Double totaleSpeso;
    private String fotoProfilo;

    public Utente() {}

    public Utente(int idUtente, String email, String nome, String cognome, String indirizzo, String citta, String provincia, String cap, String password, String ruolo, Integer numOrdini, Double totaleSpeso, String fotoProfilo) {
        this.idUtente = idUtente;
        this.email = email;
        this.nome = nome;
        this.cognome = cognome;
        this.indirizzo = indirizzo;
        this.citta = citta;
        this.provincia = provincia;
        this.cap = cap;
        this.password = password;
        this.ruolo = ruolo;
        this.numOrdini = numOrdini;
        this.totaleSpeso = totaleSpeso;
        this.fotoProfilo = fotoProfilo;
    }

    // Getter e Setter
    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getIndirizzo() { return indirizzo; }
    public void setIndirizzo(String indirizzo) { this.indirizzo = indirizzo; }
    public String getCitta() { return this.citta; }
    public void setCitta(String citta) { this.citta = citta; }
    public String getProvincia() { return this.provincia; }
    public void setProvincia(String provincia) { this.provincia = provincia; }
    public String getCap() { return this.cap; }
    public void setCap(String cap) { this.cap = cap; }
    public String getCognome() { return cognome; }
    public void setCognome(String cognome) { this.cognome = cognome; }
    public String getRuolo() { return ruolo; }
    public void setRuolo(String ruolo) { this.ruolo = ruolo; }
    public Integer getNumOrdini() { return numOrdini; }
    public void setNumOrdini(Integer numOrdini) { this.numOrdini = numOrdini; }
    public Double getTotaleSpeso() { return totaleSpeso; }
    public void setTotaleSpeso(Double totaleSpeso) { this.totaleSpeso = totaleSpeso; }
    public String getImmagine() { return fotoProfilo; }
    public void setImmagine(String path) { this.fotoProfilo = path; }

	
}