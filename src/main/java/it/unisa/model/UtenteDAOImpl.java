package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UtenteDAOImpl extends GenericDAOImpl<Utente, Integer> {

    public UtenteDAOImpl() {
        super("utente", "id_utente");
    }
    
    public Utente getUtenteByEmail(String email) {
        String query = "SELECT * FROM Utente WHERE email = ?";
        Utente utente = null;

        try (Connection conn = getConnection(); // Ottieni la connessione al database
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Imposta il parametro della query
            stmt.setString(1, email);

            // Esegui la query
            ResultSet rs = stmt.executeQuery();

            // Se trovi un risultato, mappa l'oggetto Utente
            if (rs.next()) {
                utente = mapResultSetToEntity(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return utente; // Restituisce null se l'utente non è stato trovato
    }

    @Override
    protected Utente mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Utente(
                rs.getInt("id_utente"),
                rs.getString("nome"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("indirizzo"),
                rs.getString("cognome"),
                rs.getString("ruolo"),
                rs.getInt("num_ordini"),
                rs.getDouble("totale_speso"),
                rs.getString("percorsoImmagine")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "nome, email, password, indirizzo, cognome, ruolo, num_ordini, totale_speso, percorsoImmagine";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?, ?, ?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Utente utente) throws SQLException {
        stmt.setString(1, utente.getNome());
        stmt.setString(2, utente.getEmail());
        stmt.setString(3, utente.getPassword());
        stmt.setString(4, utente.getIndirizzo());
        stmt.setString(5, utente.getCognome());
        stmt.setString(6, utente.getRuolo());
        Integer numOrdini = utente.getNumOrdini();
        if (numOrdini == null) {
            stmt.setNull(7, java.sql.Types.INTEGER);
        } else {
            stmt.setInt(7, numOrdini);
        }

        Double totaleSpeso = utente.getTotaleSpeso();
        if (totaleSpeso == null) {
            stmt.setNull(8, java.sql.Types.DOUBLE);
        } else {
            stmt.setDouble(8, totaleSpeso);
        }
        stmt.setString(9, utente.getIndirizzo());
    }

    @Override
    protected String getUpdateSetClause() {
        return "nome = ?, email = ?, password = ?, indirizzo = ?, cognome = ?, ruolo = ?, num_ordini = ?, totale_speso = ?, percorsoImmagine = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Utente utente) throws SQLException {
        stmt.setString(1, utente.getNome());
        stmt.setString(2, utente.getEmail());
        stmt.setString(3, utente.getPassword());
        stmt.setString(4, utente.getIndirizzo());
        stmt.setString(5, utente.getCognome());
        stmt.setString(6, utente.getRuolo());
        Integer numOrdini = utente.getNumOrdini();
        if (numOrdini == null) {
            stmt.setNull(7, java.sql.Types.INTEGER);
        } else {
            stmt.setInt(7, numOrdini);
        }
        
        Double totaleSpeso = utente.getTotaleSpeso();
        if (totaleSpeso == null) {
            stmt.setNull(8, java.sql.Types.DOUBLE);
        } else {
            stmt.setDouble(8, totaleSpeso);
        }
        stmt.setString(9, utente.getImmagine());
        stmt.setInt(10, utente.getIdUtente());
    }
}