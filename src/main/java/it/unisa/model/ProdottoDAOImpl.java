package it.unisa.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProdottoDAOImpl extends GenericDAOImpl<Prodotto, Integer> {

    public ProdottoDAOImpl() {
        super("prodotto", "id_prodotto");
    }

    @Override
    protected Prodotto mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Prodotto(
                rs.getInt("id_prodotto"),
                rs.getInt("quantita_disponibile"),
                rs.getDouble("prezzo"),
                rs.getDouble("media_recensioni"),
                rs.getString("nome"),
                rs.getInt("quantita_venduta"),
                rs.getString("path_immagine"),
                rs.getString("descrizione"),
                rs.getInt("id_categoria"),
                rs.getInt("id_admin")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "quantita_disponibile, prezzo, media_recensioni, nome, quantita_venduta, path_immagine, descrizione, id_categoria, id_admin";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?, ?, ?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Prodotto prodotto) throws SQLException {
        stmt.setInt(1, prodotto.getQuantitaDisponibile());
        stmt.setDouble(2, prodotto.getPrezzo());
        stmt.setDouble(3, prodotto.getMediaRecensioni());
        stmt.setString(4, prodotto.getNome());
        stmt.setInt(5, prodotto.getQuantitaVenduta());
        stmt.setString(6, prodotto.getPathImmagine());
        stmt.setString(7, prodotto.getDescrizione());
        stmt.setInt(8, prodotto.getIdCategoria());
        stmt.setInt(9, prodotto.getIdAdmin());
    }

    @Override
    protected String getUpdateSetClause() {
        return "quantita_disponibile = ?, prezzo = ?, media_recensioni = ?, nome = ?, quantita_venduta = ?, path_immagine = ?, descrizione = ?, id_categoria = ?, id_admin = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Prodotto prodotto) throws SQLException {
        stmt.setInt(1, prodotto.getQuantitaDisponibile());
        stmt.setDouble(2, prodotto.getPrezzo());
        stmt.setDouble(3, prodotto.getMediaRecensioni());
        stmt.setString(4, prodotto.getNome());
        stmt.setInt(5, prodotto.getQuantitaVenduta());
        stmt.setString(6, prodotto.getPathImmagine());
        stmt.setString(7, prodotto.getDescrizione());
        stmt.setInt(8, prodotto.getIdCategoria());
        stmt.setInt(9, prodotto.getIdAdmin());
        stmt.setInt(10, prodotto.getIdProdotto());
    }
}