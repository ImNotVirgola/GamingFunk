package it.unisa.model;

import java.util.Date;

public class Forum {
    private int idForum;
    private Date dataCreazione;
    private String titolo;
    private String descrizione;
    private int idCreatore;

    public Forum() {}

    public Forum(int idForum, Date dataCreazione, String titolo, String descrizione, int idCreatore) {
        this.idForum = idForum;
        this.dataCreazione = dataCreazione;
        this.titolo = titolo;
        this.descrizione = descrizione;
        this.idCreatore = idCreatore;
    }

    // Getter e Setter
    public int getIdForum() { return idForum; }
    public void setIdForum(int idForum) { this.idForum = idForum; }
    public Date getDataCreazione() { return dataCreazione; }
    public void setDataCreazione(Date dataCreazione) { this.dataCreazione = dataCreazione; }
    public String getTitolo() { return titolo; }
    public void setTitolo(String titolo) { this.titolo = titolo; }
    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }
    public int getIdCreatore() { return idCreatore; }
    public void setIdCreatore(int idCreatore) { this.idCreatore = idCreatore; }
}