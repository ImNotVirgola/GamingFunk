package it.unisa.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RecensioneDAOImpl extends GenericDAOImpl<Recensione, Integer> {

    public RecensioneDAOImpl() {
        super("recensione", "id_recensione");
    }

    @Override
    protected Recensione mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Recensione(
                rs.getInt("id_recensione"),
                rs.getString("commento"),
                rs.getInt("voto"),
                rs.getInt("id_prodotto"),
                rs.getInt("id_utente")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "commento, voto, id_prodotto, id_utente";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Recensione recensione) throws SQLException {
        stmt.setString(1, recensione.getCommento());
        stmt.setInt(2, recensione.getVoto());
        stmt.setInt(3, recensione.getIdProdotto());
        stmt.setInt(4, recensione.getIdUtente());
    }

    @Override
    protected String getUpdateSetClause() {
        return "commento = ?, voto = ?, id_prodotto = ?, id_utente = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Recensione recensione) throws SQLException {
        stmt.setString(1, recensione.getCommento());
        stmt.setInt(2, recensione.getVoto());
        stmt.setInt(3, recensione.getIdProdotto());
        stmt.setInt(4, recensione.getIdUtente());
        stmt.setInt(5, recensione.getIdRecensione());
    }
}