package it.unisa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public abstract class GenericDAOImpl<T, ID> implements GenericDao<T, ID> {

    private final String tableName;
    private final String idColumn;

    protected GenericDAOImpl(String tableName, String idColumn) {
        this.tableName = tableName;
        this.idColumn = idColumn;
    }

    protected Connection getConnection() throws SQLException {
        try {
            // Registra il driver manualmente (opzionale ma consigliato)
            Class.forName("org.mariadb.jdbc.Driver");

            // Parametri di connessione
            String url = "jdbc:mariadb://localhost:3306/gamingfunk";
            String user = "root";
            String password = "root";

            // Restituisce la connessione
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            System.err.println("Driver JDBC non trovato: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Errore durante la connessione al database: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public T getById(ID id) {
        String query = "SELECT * FROM " + tableName + " WHERE " + idColumn + " = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setObject(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToEntity(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<T> getAll() {
        String query = "SELECT * FROM " + tableName;
        List<T> entities = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                entities.add(mapResultSetToEntity(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entities;
    }

    @Override
    public boolean add(T entity) {
        String query = "INSERT INTO " + tableName + " (" + getInsertColumns() + ") VALUES (" + getInsertPlaceholders() + ")";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            setPreparedStatementValues(stmt, entity);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(T entity) {
        String query = "UPDATE " + tableName + " SET " + getUpdateSetClause() + " WHERE " + idColumn + " = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            setPreparedStatementValuesForUpdate(stmt, entity);
            int AffectedRows = stmt.executeUpdate();
            return AffectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteById(ID id) {
        String query = "DELETE FROM " + tableName + " WHERE " + idColumn + " = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setObject(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    protected abstract T mapResultSetToEntity(ResultSet rs) throws SQLException;
    protected abstract String getInsertColumns();
    protected abstract String getInsertPlaceholders();
    protected abstract void setPreparedStatementValues(PreparedStatement stmt, T entity) throws SQLException;
    protected abstract String getUpdateSetClause();
    protected abstract void setPreparedStatementValuesForUpdate(PreparedStatement stmt, T entity) throws SQLException;
}