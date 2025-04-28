package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class DiscussioneDAOImpl extends GenericDAOImpl<Discussione, Integer> {

    public DiscussioneDAOImpl() {
        super("discussione", "id_discussione");
    }
    
    public List<Discussione> getAllByForum(int id) {
        String query = "SELECT * FROM Discussione WHERE id_forum = ?";
        List<Discussione> disc = null;

        try (Connection conn = getConnection(); // Ottieni la connessione al database
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Imposta il parametro della query
            stmt.setInt(1, id);

            // Esegui la query
            ResultSet rs = stmt.executeQuery();

            // Se trovi un risultato, mappa l'oggetto Utente
            if (rs.next()) {
                disc.add(mapResultSetToEntity(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return disc; // Restituisce null se l'utente non è stato trovato
    }

    @Override
    protected Discussione mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Discussione(
                rs.getInt("id_discussione"),
                rs.getString("titolo"),
                rs.getString("contenuto"),
                rs.getString("data_pubblicazione"),
                rs.getInt("id_autore"),
                rs.getInt("id_forum")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "titolo, contenuto, data_pubblicazione, id_autore, id_forum";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Discussione discussione) throws SQLException {
        stmt.setString(1, discussione.getTitolo());
        stmt.setString(2, discussione.getContenuto());
        stmt.setString(3, discussione.getDataPubblicazione());
        stmt.setInt(4, discussione.getIdAutore());
        stmt.setInt(5, discussione.getIdForum());
    }

    @Override
    protected String getUpdateSetClause() {
        return "titolo = ?, contenuto = ?, data_pubblicazione = ?, id_autore = ?, id_forum = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Discussione discussione) throws SQLException {
        stmt.setString(1, discussione.getTitolo());
        stmt.setString(2, discussione.getContenuto());
        stmt.setString(3, discussione.getDataPubblicazione());
        stmt.setInt(4, discussione.getIdAutore());
        stmt.setInt(5, discussione.getIdForum());
        stmt.setInt(6, discussione.getIdDiscussione());
    }
}