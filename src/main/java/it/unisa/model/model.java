package it.unisa.model;

import java.util.List;

public class model{

    // DAO Instances
    private final UtenteDAOImpl utenteDAO = new UtenteDAOImpl();
    private final ProdottoDAOImpl prodottoDAO = new ProdottoDAOImpl();
    private final CategoriaDAOImpl categoriaDAO = new CategoriaDAOImpl();
    private final CommunityDAOImpl communityDAO = new CommunityDAOImpl();
    private final DiscussioneDAOImpl discussioneDAO = new DiscussioneDAOImpl();
    private final EventoDAOImpl eventoDAO = new EventoDAOImpl();
    private final ForumDAOImpl forumDAO = new ForumDAOImpl();
    private final OrdineDAOImpl ordineDAO = new OrdineDAOImpl();
    private final PagamentoDAOImpl pagamentoDAO = new PagamentoDAOImpl();
    private final RecensioneDAOImpl recensioneDAO = new RecensioneDAOImpl();
    private final WishlistDAOImpl wishlistDAO = new WishlistDAOImpl();

    // Metodi per Utente
    public Utente getUtenteById(int idUtente) {
        return utenteDAO.getById(idUtente);
    }
    
    public Utente getUtenteByEmail(String email) {
    	return utenteDAO.getUtenteByEmail(email);
    }

    public List<Utente> getAllUtenti() {
        return utenteDAO.getAll();
    }

    public boolean aggiungiUtente(Utente utente) {
        return utenteDAO.add(utente);
    }

    public boolean aggiornaUtente(Utente utente) {
        return utenteDAO.update(utente);
    }

    public boolean eliminaUtente(int idUtente) {
        return utenteDAO.deleteById(idUtente);
    }

    // Metodi per Prodotto
    public Prodotto getProdottoById(int idProdotto) {
        return prodottoDAO.getById(idProdotto);
    }

    public List<Prodotto> getAllProdotti() {
        return prodottoDAO.getAll();
    }

    public boolean aggiungiProdotto(Prodotto prodotto) {
        return prodottoDAO.add(prodotto);
    }

    public boolean aggiornaProdotto(Prodotto prodotto) {
        return prodottoDAO.update(prodotto);
    }

    public boolean eliminaProdotto(int idProdotto) {
        return prodottoDAO.deleteById(idProdotto);
    }

    // Metodi per Categoria
    public Categoria getCategoriaById(int idCategoria) {
        return categoriaDAO.getById(idCategoria);
    }

    public List<Categoria> getAllCategorie() {
        return categoriaDAO.getAll();
    }

    public boolean aggiungiCategoria(Categoria categoria) {
        return categoriaDAO.add(categoria);
    }

    public boolean aggiornaCategoria(Categoria categoria) {
        return categoriaDAO.update(categoria);
    }

    public boolean eliminaCategoria(int idCategoria) {
        return categoriaDAO.deleteById(idCategoria);
    }

    // Metodi per Community
    public Community getCommunityById(int idCommunity) {
        return communityDAO.getById(idCommunity);
    }

    public List<Community> getAllCommunity() {
        return communityDAO.getAll();
    }

    public boolean aggiungiCommunity(Community community) {
        return communityDAO.add(community);
    }

    public boolean aggiornaCommunity(Community community) {
        return communityDAO.update(community);
    }

    public boolean eliminaCommunity(int idCommunity) {
        return communityDAO.deleteById(idCommunity);
    }

    // Metodi per Discussione
    public Discussione getDiscussioneById(int idDiscussione) {
        return discussioneDAO.getById(idDiscussione);
    }

    public List<Discussione> getAllDiscussioni() {
        return discussioneDAO.getAll();
    }

    public boolean aggiungiDiscussione(Discussione discussione) {
        return discussioneDAO.add(discussione);
    }

    public boolean aggiornaDiscussione(Discussione discussione) {
        return discussioneDAO.update(discussione);
    }

    public boolean eliminaDiscussione(int idDiscussione) {
        return discussioneDAO.deleteById(idDiscussione);
    }

    // Metodi per Evento
    public Evento getEventoById(int idEvento) {
        return eventoDAO.getById(idEvento);
    }

    public List<Evento> getAllEventi() {
        return eventoDAO.getAll();
    }

    public boolean aggiungiEvento(Evento evento) {
        return eventoDAO.add(evento);
    }

    public boolean aggiornaEvento(Evento evento) {
        return eventoDAO.update(evento);
    }

    public boolean eliminaEvento(int idEvento) {
        return eventoDAO.deleteById(idEvento);
    }

    // Metodi per Forum
    public Forum getForumById(int idForum) {
        return forumDAO.getById(idForum);
    }

    public List<Forum> getAllForum() {
        return forumDAO.getAll();
    }

    public boolean aggiungiForum(Forum forum) {
        return forumDAO.add(forum);
    }

    public boolean aggiornaForum(Forum forum) {
        return forumDAO.update(forum);
    }

    public boolean eliminaForum(int idForum) {
        return forumDAO.deleteById(idForum);
    }

    // Metodi per Ordine
    public Ordine getOrdineById(int idOrdine) {
        return ordineDAO.getById(idOrdine);
    }

    public List<Ordine> getAllOrdini() {
        return ordineDAO.getAll();
    }

    public boolean aggiungiOrdine(Ordine ordine) {
        return ordineDAO.add(ordine);
    }

    public boolean aggiornaOrdine(Ordine ordine) {
        return ordineDAO.update(ordine);
    }

    public boolean eliminaOrdine(int idOrdine) {
        return ordineDAO.deleteById(idOrdine);
    }

    // Metodi per Pagamento
    public Pagamento getPagamentoById(int idPagamento) {
        return pagamentoDAO.getById(idPagamento);
    }

    public List<Pagamento> getAllPagamenti() {
        return pagamentoDAO.getAll();
    }

    public boolean aggiungiPagamento(Pagamento pagamento) {
        return pagamentoDAO.add(pagamento);
    }

    public boolean aggiornaPagamento(Pagamento pagamento) {
        return pagamentoDAO.update(pagamento);
    }

    public boolean eliminaPagamento(int idPagamento) {
        return pagamentoDAO.deleteById(idPagamento);
    }

    // Metodi per Recensione
    public Recensione getRecensioneById(int idRecensione) {
        return recensioneDAO.getById(idRecensione);
    }

    public List<Recensione> getAllRecensioni() {
        return recensioneDAO.getAll();
    }

    public boolean aggiungiRecensione(Recensione recensione) {
        return recensioneDAO.add(recensione);
    }

    public boolean aggiornaRecensione(Recensione recensione) {
        return recensioneDAO.update(recensione);
    }

    public boolean eliminaRecensione(int idRecensione) {
        return recensioneDAO.deleteById(idRecensione);
    }

    // Metodi per Wishlist
    public Wishlist getWishlistById(int idWishlist) {
        return wishlistDAO.getById(idWishlist);
    }

    public List<Wishlist> getAllWishlist() {
        return wishlistDAO.getAll();
    }

    public boolean aggiungiWishlist(Wishlist wishlist) {
        return wishlistDAO.add(wishlist);
    }

    public boolean aggiornaWishlist(Wishlist wishlist) {
        return wishlistDAO.update(wishlist);
    }

    public boolean eliminaWishlist(int idWishlist) {
        return wishlistDAO.deleteById(idWishlist);
    }
}