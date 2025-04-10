package it.unisa.model;

public class Recensione {
    private int idRecensione;
    private String commento;
    private Integer voto;
    private int idProdotto;
    private int idUtente;

    public Recensione() {}

    public Recensione(int idRecensione, String commento, Integer voto, int idProdotto, int idUtente) {
        this.idRecensione = idRecensione;
        this.commento = commento;
        this.voto = voto;
        this.idProdotto = idProdotto;
        this.idUtente = idUtente;
    }

    // Getter e Setter
    public int getIdRecensione() { return idRecensione; }
    public void setIdRecensione(int idRecensione) { this.idRecensione = idRecensione; }
    public String getCommento() { return commento; }
    public void setCommento(String commento) { this.commento = commento; }
    public Integer getVoto() { return voto; }
    public void setVoto(Integer voto) { this.voto = voto; }
    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }
    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }
}