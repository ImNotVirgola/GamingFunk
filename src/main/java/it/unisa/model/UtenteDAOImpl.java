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
                rs.getString("email"),
                rs.getString("nome"),
                rs.getString("cognome"),
                rs.getString("indirizzo"),
                rs.getString("citta"),
                rs.getString("provincia"),
                rs.getString("cap"),
                rs.getString("password"),
                rs.getString("ruolo"),
                rs.getInt("num_ordini"),
                rs.getDouble("totale_speso"),
                rs.getString("percorsoImmagine")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "email, nome, cognome, indirizzo, citta, provincia, cap, password, ruolo, num_ordini, totale_speso, percorsoImmagine";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Utente utente) throws SQLException {
        stmt.setString(1, utente.getEmail());
        stmt.setString(2, utente.getNome());
        stmt.setString(3, utente.getCognome());
        stmt.setString(4, utente.getIndirizzo());
        stmt.setString(5, utente.getCitta());
        stmt.setString(6, utente.getProvincia());
        stmt.setString(7,utente.getCap());
        stmt.setString(8, utente.getPassword());
        stmt.setString(9, utente.getRuolo());
        Integer numOrdini = utente.getNumOrdini();
        if (numOrdini == null) {
            stmt.setNull(10, java.sql.Types.INTEGER);
        } else {
            stmt.setInt(10, numOrdini);
        }

        Double totaleSpeso = utente.getTotaleSpeso();
        if (totaleSpeso == null) {
            stmt.setNull(11, java.sql.Types.DOUBLE);
        } else {
            stmt.setDouble(11, totaleSpeso);
        }
        stmt.setString(12, utente.getImmagine());
    }

    @Override
    protected String getUpdateSetClause() {
        return "email = ?, nome = ?, cognome = ?, indirizzo = ?, citta = ?, provincia = ?, cap = ?, password = ?, ruolo = ?, num_ordini = ?, totale_speso = ?, percorsoImmagine = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Utente utente) throws SQLException {
    	stmt.setString(1, utente.getEmail());
        stmt.setString(2, utente.getNome());
        stmt.setString(3, utente.getCognome());
        stmt.setString(4, utente.getIndirizzo());
        stmt.setString(5, utente.getCitta());
        stmt.setString(6, utente.getProvincia());
        stmt.setString(7,utente.getCap());
        stmt.setString(8, utente.getPassword());
        stmt.setString(9, utente.getRuolo());
        Integer numOrdini = utente.getNumOrdini();
        if (numOrdini == null) {
            stmt.setNull(10, java.sql.Types.INTEGER);
        } else {
            stmt.setInt(10, numOrdini);
        }

        Double totaleSpeso = utente.getTotaleSpeso();
        if (totaleSpeso == null) {
            stmt.setNull(11, java.sql.Types.DOUBLE);
        } else {
            stmt.setDouble(11, totaleSpeso);
        }
        stmt.setString(12, utente.getImmagine());
        stmt.setInt(13, utente.getIdUtente());
    }
}