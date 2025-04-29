package it.unisa.model;

public class Prodotto {
    private int idProdotto;
    private int quantitaDisponibile;
    private double prezzo;
    private double mediaRecensioni;
    private String nome;
    private int quantitaVenduta;
    private String pathImmagine;
    private String descrizione;
    private int idCategoria;
    private int idAdmin;

    public Prodotto() {}

    public Prodotto(int idProdotto, int quantitaDisponibile, double prezzo, double mediaRecensioni, String nome, int quantitaVenduta, String pathImmagine, String descrizione, int idCategoria, int idAdmin) {
        this.idProdotto = idProdotto;
        this.quantitaDisponibile = quantitaDisponibile;
        this.prezzo = prezzo;
        this.mediaRecensioni = mediaRecensioni;
        this.nome = nome;
        this.quantitaVenduta = quantitaVenduta;
        this.pathImmagine = pathImmagine;
        this.descrizione = descrizione;
        this.idCategoria = idCategoria;
        this.idAdmin = idAdmin;
    }

    // Getter e Setter
    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }
    public int getQuantitaDisponibile() { return quantitaDisponibile; }
    public void setQuantitaDisponibile(int quantitaDisponibile) { this.quantitaDisponibile += quantitaDisponibile; }
    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }
    public double getMediaRecensioni() { return mediaRecensioni; }
    public void setMediaRecensioni(double mediaRecensioni) { this.mediaRecensioni = mediaRecensioni; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public int getQuantitaVenduta() { return quantitaVenduta; }
    public void setQuantitaVenduta(int quantitaVenduta) { this.quantitaVenduta = quantitaVenduta; }
    public String getPathImmagine() { return pathImmagine; }
    public void setPathImmagine(String pathImmagine) { this.pathImmagine = pathImmagine; }
    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }
    public int getIdCategoria() { return idCategoria; }
    public void setIdCategoria(int idCategoria) { this.idCategoria = idCategoria; }
    public int getIdAdmin() { return idAdmin; }
    public void setIdAdmin(int idAdmin) { this.idAdmin = idAdmin; }
}