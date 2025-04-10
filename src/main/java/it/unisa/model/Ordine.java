package it.unisa.model;

import java.math.BigDecimal;

public class Ordine {
    private int idOrdine;
    private String stato;
    private BigDecimal totale;
    private int datiOrdine;
    private int idUtente;

    public Ordine() {}

    public Ordine(int idOrdine, String stato, BigDecimal totale, int datiOrdine, int idUtente) {
        this.idOrdine = idOrdine;
        this.stato = stato;
        this.totale = totale;
        this.datiOrdine = datiOrdine;
        this.idUtente = idUtente;
    }

    // Getter e Setter
    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }
    public String getStato() { return stato; }
    public void setStato(String stato) { this.stato = stato; }
    public BigDecimal getTotale() { return totale; }
    public void setTotale(BigDecimal totale) { this.totale = totale; }
    public int getDatiOrdine() { return datiOrdine; }
    public void setDatiOrdine(int datiOrdine) { this.datiOrdine = datiOrdine; }
    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }
}