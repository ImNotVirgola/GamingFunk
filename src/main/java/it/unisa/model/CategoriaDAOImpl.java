package it.unisa.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CategoriaDAOImpl extends GenericDAOImpl<Categoria, Integer> {

    public CategoriaDAOImpl() {
        super("categoria", "id_categoria");
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