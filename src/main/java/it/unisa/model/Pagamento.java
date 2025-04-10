package it.unisa.model;

public class Pagamento {
    private int idPagamento;
    private String metodoPagamento;
    private String statoPagamento;
    private int idOrdine;

    public Pagamento() {}

    public Pagamento(int idPagamento, String metodoPagamento, String statoPagamento, int idOrdine) {
        this.idPagamento = idPagamento;
        this.metodoPagamento = metodoPagamento;
        this.statoPagamento = statoPagamento;
        this.idOrdine = idOrdine;
    }

    // Getter e Setter
    public int getIdPagamento() { return idPagamento; }
    public void setIdPagamento(int idPagamento) { this.idPagamento = idPagamento; }
    public String getMetodoPagamento() { return metodoPagamento; }
    public void setMetodoPagamento(String metodoPagamento) { this.metodoPagamento = metodoPagamento; }
    public String getStatoPagamento() { return statoPagamento; }
    public void setStatoPagamento(String statoPagamento) { this.statoPagamento = statoPagamento; }
    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }
}