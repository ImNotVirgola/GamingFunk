package it.unisa.model;

public class Wishlist {
    private int idWishlist;
    private int idUtente;
    private int idProdotto;

    public Wishlist() {}

    public Wishlist(int idWishlist, int idUtente, int idProdotto) {
        this.idWishlist = idWishlist;
        this.idUtente = idUtente;
        this.idProdotto = idProdotto;
    }

    // Getter e Setter
    public int getIdWishlist() { return idWishlist; }
    public void setIdWishlist(int idWishlist) { this.idWishlist = idWishlist; }
    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }
    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }
}