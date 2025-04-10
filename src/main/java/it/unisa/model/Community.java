package it.unisa.model;

public class Community {
    private int idCommunity;
    private String nome;
    private String descrizione;
    private int idCreatore;

    public Community() {}

    public Community(int idCommunity, String nome, String descrizione, int idCreatore) {
        this.idCommunity = idCommunity;
        this.nome = nome;
        this.descrizione = descrizione;
        this.idCreatore = idCreatore;
    }

    // Getter e Setter
    public int getIdCommunity() { return idCommunity; }
    public void setIdCommunity(int idCommunity) { this.idCommunity = idCommunity; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }
    public int getIdCreatore() { return idCreatore; }
    public void setIdCreatore(int idCreatore) { this.idCreatore = idCreatore; }
}