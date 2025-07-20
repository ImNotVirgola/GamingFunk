package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrdineProdottoDAOImpl extends GenericDAOImpl<OrdineProdotto, OrdineProdottoKey> {

    public OrdineProdottoDAOImpl() {
        super("ordine_prodotto", "id_ordine, id_prodotto");
    }
    
    public List<Map<String, Object>> getProdottiDettagliatiByOrdineId(int idOrdine) {
        List<Map<String, Object>> prodotti = new ArrayList<>();

        String sql = "SELECT op.id_prodotto, p.nome, op.quantita, op.prezzo_unitario " +
                     "FROM ordine_prodotto op JOIN prodotto p ON op.id_prodotto = p.id_prodotto " +
                     "WHERE op.id_ordine = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idOrdine);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> prodotto = new HashMap<>();
                prodotto.put("id_prodotto", rs.getInt("id_prodotto"));
                prodotto.put("nome", rs.getString("nome"));
                prodotto.put("quantita", rs.getInt("quantita"));
                prodotto.put("prezzo_unitario", rs.getDouble("prezzo_unitario"));
                prodotti.add(prodotto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return prodotti;
    }

    
    public List<OrdineProdotto> getProdottiByOrdineId(int idOrdine) {
        List<OrdineProdotto> lista = new ArrayList<>();
        String sql = "SELECT * FROM ordine_prodotto WHERE id_ordine = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idOrdine);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrdineProdotto op = new OrdineProdotto();
                op.setIdOrdine(rs.getInt("id_ordine"));
                op.setIdProdotto(rs.getInt("id_prodotto"));
                op.setQuantita(rs.getInt("quantita"));
                op.setPrezzoUnitario(rs.getDouble("prezzo_unitario"));
                lista.add(op);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }


    @Override
    protected OrdineProdotto mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new OrdineProdotto(
            rs.getInt("id_ordine"),
            rs.getInt("id_prodotto"),
            rs.getInt("quantita"),
            rs.getDouble("prezzo_unitario")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "id_ordine, id_prodotto, quantita, prezzo_unitario";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, OrdineProdotto ordineProdotto) throws SQLException {
        stmt.setInt(1, ordineProdotto.getIdOrdine());
        stmt.setInt(2, ordineProdotto.getIdProdotto());
        stmt.setInt(3, ordineProdotto.getQuantita());
        stmt.setDouble(4, ordineProdotto.getPrezzoUnitario());
    }

    @Override
    protected String getUpdateSetClause() {
        return "quantita = ?, prezzo_unitario = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, OrdineProdotto ordineProdotto) throws SQLException {
        stmt.setInt(1, ordineProdotto.getQuantita());
        stmt.setDouble(2, ordineProdotto.getPrezzoUnitario());
        stmt.setInt(3, ordineProdotto.getIdOrdine());
        stmt.setInt(4, ordineProdotto.getIdProdotto());
    }
} 
