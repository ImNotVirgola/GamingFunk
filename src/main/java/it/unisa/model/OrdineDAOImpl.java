package it.unisa.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OrdineDAOImpl extends GenericDAOImpl<Ordine, Integer> {

    public OrdineDAOImpl() {
        super("ordine", "id_ordine");
    }

    @Override
    protected Ordine mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Ordine(
                rs.getInt("id_ordine"),
                rs.getString("stato"),
                rs.getBigDecimal("totale"),
                rs.getInt("dati_ordine"),
                rs.getInt("id_utente")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "stato, totale, dati_ordine, id_utente";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Ordine ordine) throws SQLException {
        stmt.setString(1, ordine.getStato());
        stmt.setBigDecimal(2, ordine.getTotale());
        stmt.setInt(3, ordine.getDatiOrdine());
        stmt.setInt(4, ordine.getIdUtente());
    }

    @Override
    protected String getUpdateSetClause() {
        return "stato = ?, totale = ?, dati_ordine = ?, id_utente = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Ordine ordine) throws SQLException {
        stmt.setString(1, ordine.getStato());
        stmt.setBigDecimal(2, ordine.getTotale());
        stmt.setInt(3, ordine.getDatiOrdine());
        stmt.setInt(4, ordine.getIdUtente());
        stmt.setInt(5, ordine.getIdOrdine());
    }
}