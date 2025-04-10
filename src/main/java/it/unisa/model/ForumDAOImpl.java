package it.unisa.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class ForumDAOImpl extends GenericDAOImpl<Forum, Integer> {

    public ForumDAOImpl() {
        super("forum", "id_forum");
    }

    @Override
    protected Forum mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Forum(
                rs.getInt("id_forum"),
                rs.getDate("data_creazione"),
                rs.getString("titolo"),
                rs.getString("descrizione"),
                rs.getInt("id_creatore")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "data_creazione, titolo, descrizione, id_creatore";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Forum forum) throws SQLException {
        stmt.setDate(1, new java.sql.Date(forum.getDataCreazione().getTime()));
        stmt.setString(2, forum.getTitolo());
        stmt.setString(3, forum.getDescrizione());
        stmt.setInt(4, forum.getIdCreatore());
    }

    @Override
    protected String getUpdateSetClause() {
        return "data_creazione = ?, titolo = ?, descrizione = ?, id_creatore = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Forum forum) throws SQLException {
        stmt.setDate(1, new java.sql.Date(forum.getDataCreazione().getTime()));
        stmt.setString(2, forum.getTitolo());
        stmt.setString(3, forum.getDescrizione());
        stmt.setInt(4, forum.getIdCreatore());
        stmt.setInt(5, forum.getIdForum());
    }
}