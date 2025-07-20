package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProdottoDAOImpl extends GenericDAOImpl<Prodotto, Integer> {
	
	public int addAndReturnId(Prodotto prodotto) {
		String query = "INSERT INTO prodotto (nome, descrizione, prezzo, quantita_disponibile, id_categoria, media_recensioni) VALUES (?, ?, ?, ?, ?, ?)";
	    try (Connection conn = getConnection();
	         PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

	    	stmt.setString(1, prodotto.getNome());
	    	stmt.setString(2, prodotto.getDescrizione());
	    	stmt.setDouble(3, prodotto.getPrezzo());
	    	stmt.setInt(4, prodotto.getQuantitaDisponibile());
	    	stmt.setInt(5, prodotto.getIdCategoria());
	    	stmt.setDouble(6, prodotto.getMediaRecensioni());


	        stmt.executeUpdate();
	        ResultSet rs = stmt.getGeneratedKeys();
	        if (rs.next()) {
	            return rs.getInt(1);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return -1;
	}


    public ProdottoDAOImpl() {
        super("prodotto", "id_prodotto");
    }

    public List<Prodotto> getFilteredProducts(int cat) throws SQLException {
        String query = "SELECT * FROM prodotto WHERE id_categoria = ?";
        List<Prodotto> entities = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, cat);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    entities.add(mapResultSetToEntity(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return entities;
    }

    @Override
    protected Prodotto mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Prodotto(
                rs.getInt("id_prodotto"),
                rs.getInt("quantita_disponibile"),
                rs.getDouble("prezzo"),
                rs.getDouble("media_recensioni"),
                rs.getString("nome"),
                rs.getInt("quantita_venduta"),
                rs.getString("path_immagine"),
                rs.getString("descrizione"),
                rs.getInt("id_categoria"),
                rs.getInt("id_admin")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "quantita_disponibile, prezzo, media_recensioni, nome, quantita_venduta, path_immagine, descrizione, id_categoria, id_admin";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?, ?, ?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Prodotto prodotto) throws SQLException {
        stmt.setInt(1, prodotto.getQuantitaDisponibile());
        stmt.setDouble(2, prodotto.getPrezzo());
        stmt.setDouble(3, prodotto.getMediaRecensioni());
        stmt.setString(4, prodotto.getNome());
        stmt.setInt(5, prodotto.getQuantitaVenduta());
        stmt.setString(6, prodotto.getPathImmagine());
        stmt.setString(7, prodotto.getDescrizione());
        stmt.setInt(8, prodotto.getIdCategoria());
        stmt.setInt(9, prodotto.getIdAdmin());
    }

    @Override
    protected String getUpdateSetClause() {
        return "quantita_disponibile = ?, prezzo = ?, media_recensioni = ?, nome = ?, quantita_venduta = ?, path_immagine = ?, descrizione = ?, id_categoria = ?, id_admin = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Prodotto prodotto) throws SQLException {
        stmt.setInt(1, prodotto.getQuantitaDisponibile());
        stmt.setDouble(2, prodotto.getPrezzo());
        stmt.setDouble(3, prodotto.getMediaRecensioni());
        stmt.setString(4, prodotto.getNome());
        stmt.setInt(5, prodotto.getQuantitaVenduta());
        stmt.setString(6, prodotto.getPathImmagine());
        stmt.setString(7, prodotto.getDescrizione());
        stmt.setInt(8, prodotto.getIdCategoria());
        stmt.setInt(9, prodotto.getIdAdmin());
        stmt.setInt(10, prodotto.getIdProdotto());
    }

    public List<String> getNomiProdottiSimili(String term) {
        List<String> risultati = new ArrayList<>();
        String query = "SELECT nome FROM prodotto WHERE LOWER(nome) LIKE ? LIMIT 10";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, "%" + term.toLowerCase() + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    risultati.add(rs.getString("nome"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return risultati;
    }

    public List<Prodotto> cercaProdotti(String term) {
        List<Prodotto> risultati = new ArrayList<>();
        String sql = "SELECT * FROM prodotto WHERE LOWER(nome) LIKE ? LIMIT 20";

        try (Connection conn = ConPool.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + term.toLowerCase() + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    risultati.add(new Prodotto(
                        rs.getInt("id_prodotto"),
                        rs.getInt("quantita_disponibile"),
                        rs.getDouble("prezzo"),
                        rs.getDouble("media_recensioni"),
                        rs.getString("nome"),
                        rs.getInt("quantita_venduta"),
                        rs.getString("path_immagine"),
                        rs.getString("descrizione"),
                        rs.getInt("id_categoria"),
                        rs.getInt("id_admin")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return risultati;
    }
}