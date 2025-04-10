package it.unisa.model;

public class Evento {
    private int idEvento;
    private String luogo;
    private String data;
    private String descrizione;
    private String nome;
    private int idOrganizzatore;

    public Evento() {}

    public Evento(int idEvento, String luogo, String data, String descrizione, String nome, int idOrganizzatore) {
        this.idEvento = idEvento;
        this.luogo = luogo;
        this.data = data;
        this.descrizione = descrizione;
        this.nome = nome;
        this.idOrganizzatore = idOrganizzatore;
    }

    // Getter e Setter
    public int getIdEvento() { return idEvento; }
    public void setIdEvento(int idEvento) { this.idEvento = idEvento; }
    public String getLuogo() { return luogo; }
    public void setLuogo(String luogo) { this.luogo = luogo; }
    public String getData() { return data; }
    public void setData(String data) { this.data = data; }
    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public int getIdOrganizzatore() { return idOrganizzatore; }
    public void setIdOrganizzatore(int idOrganizzatore) { this.idOrganizzatore = idOrganizzatore; }
}