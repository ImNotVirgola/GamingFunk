package it.unisa.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EventoDAOImpl extends GenericDAOImpl<Evento, Integer> {

    public EventoDAOImpl() {
        super("evento", "id_evento");
    }

    @Override
    protected Evento mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Evento(
                rs.getInt("id_evento"),
                rs.getString("luogo"),
                rs.getString("data"),
                rs.getString("descrizione"),
                rs.getString("nome"),
                rs.getInt("id_organizzatore")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "luogo, data, descrizione, nome, id_organizzatore";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Evento evento) throws SQLException {
        stmt.setString(1, evento.getLuogo());
        stmt.setString(2, evento.getData());
        stmt.setString(3, evento.getDescrizione());
        stmt.setString(4, evento.getNome());
        stmt.setInt(5, evento.getIdOrganizzatore());
    }

    @Override
    protected String getUpdateSetClause() {
        return "luogo = ?, data = ?, descrizione = ?, nome = ?, id_organizzatore = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Evento evento) throws SQLException {
        stmt.setString(1, evento.getLuogo());
        stmt.setString(2, evento.getData());
        stmt.setString(3, evento.getDescrizione());
        stmt.setString(4, evento.getNome());
        stmt.setInt(5, evento.getIdOrganizzatore());
        stmt.setInt(6, evento.getIdEvento());
    }
}