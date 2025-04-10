package it.unisa.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WishlistDAOImpl extends GenericDAOImpl<Wishlist, Integer> {

    public WishlistDAOImpl() {
        super("wishlist", "id_wishlist");
    }

    @Override
    protected Wishlist mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Wishlist(
                rs.getInt("id_wishlist"),
                rs.getInt("id_utente"),
                rs.getInt("id_prodotto")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "id_utente, id_prodotto";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Wishlist wishlist) throws SQLException {
        stmt.setInt(1, wishlist.getIdUtente());
        stmt.setInt(2, wishlist.getIdProdotto());
    }

    @Override
    protected String getUpdateSetClause() {
        return "id_utente = ?, id_prodotto = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Wishlist wishlist) throws SQLException {
        stmt.setInt(1, wishlist.getIdUtente());
        stmt.setInt(2, wishlist.getIdProdotto());
        stmt.setInt(3, wishlist.getIdWishlist());
    }
}