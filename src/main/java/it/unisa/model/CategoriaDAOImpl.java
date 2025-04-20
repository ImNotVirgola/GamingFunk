package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CategoriaDAOImpl extends GenericDAOImpl<Categoria, Integer> {

    public CategoriaDAOImpl() {
        super("categoria", "id_categoria");
    }

    public Integer getIdByName(String nome) {
        String query = "SELECT * FROM categoria WHERE nome_categoria = ?";
        Categoria cat = new Categoria();

        try (Connection conn = getConnection(); // Ottieni la connessione al database
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Imposta il parametro della query
            stmt.setString(1, nome);

            // Esegui la query
            ResultSet rs = stmt.executeQuery();

            // Se trovi un risultato, mappa l'oggetto Utente
            if (rs.next()) {
                cat = mapResultSetToEntity(rs);
            }
        } catch (SQLException e) {
        	System.out.println("Ciao");
            //e.printStackTrace();
        }

        return cat.getIdCategoria(); // Restituisce null se l'utente non è stato trovato
    }
    
    @Override
    protected Categoria mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Categoria(
                rs.getInt("id_categoria"),
                rs.getString("nome_categoria")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "nome_categoria";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Categoria categoria) throws SQLException {
        stmt.setString(1, categoria.getNomeCategoria());
    }

    @Override
    protected String getUpdateSetClause() {
        return "nome_categoria = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Categoria categoria) throws SQLException {
        stmt.setString(1, categoria.getNomeCategoria());
        stmt.setInt(2, categoria.getIdCategoria());
    }
}