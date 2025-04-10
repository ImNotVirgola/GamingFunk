package it.unisa.model;

public class Discussione {
    private int idDiscussione;
    private String titolo;
    private String contenuto;
    private String dataPubblicazione;
    private int idAutore;
    private int idForum;

    public Discussione() {}

    public Discussione(int idDiscussione, String titolo, String contenuto, String dataPubblicazione, int idAutore, int idForum) {
        this.idDiscussione = idDiscussione;
        this.titolo = titolo;
        this.contenuto = contenuto;
        this.dataPubblicazione = dataPubblicazione;
        this.idAutore = idAutore;
        this.idForum = idForum;
    }

    // Getter e Setter
    public int getIdDiscussione() { return idDiscussione; }
    public void setIdDiscussione(int idDiscussione) { this.idDiscussione = idDiscussione; }
    public String getTitolo() { return titolo; }
    public void setTitolo(String titolo) { this.titolo = titolo; }
    public String getContenuto() { return contenuto; }
    public void setContenuto(String contenuto) { this.contenuto = contenuto; }
    public String getDataPubblicazione() { return dataPubblicazione; }
    public void setDataPubblicazione(String dataPubblicazione) { this.dataPubblicazione = dataPubblicazione; }
    public int getIdAutore() { return idAutore; }
    public void setIdAutore(int idAutore) { this.idAutore = idAutore; }
    public int getIdForum() { return idForum; }
    public void setIdForum(int idForum) { this.idForum = idForum; }
}