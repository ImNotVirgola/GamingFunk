package it.unisa.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CommunityDAOImpl extends GenericDAOImpl<Community, Integer> {

    public CommunityDAOImpl() {
        super("community", "id_community");
    }

    @Override
    protected Community mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Community(
                rs.getInt("id_community"),
                rs.getString("nome"),
                rs.getString("descrizione"),
                rs.getInt("id_creatore")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "nome, descrizione, id_creatore";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Community community) throws SQLException {
        stmt.setString(1, community.getNome());
        stmt.setString(2, community.getDescrizione());
        stmt.setInt(3, community.getIdCreatore());
    }

    @Override
    protected String getUpdateSetClause() {
        return "nome = ?, descrizione = ?, id_creatore = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Community community) throws SQLException {
        stmt.setString(1, community.getNome());
        stmt.setString(2, community.getDescrizione());
        stmt.setInt(3, community.getIdCreatore());
        stmt.setInt(4, community.getIdCommunity());
    }
}