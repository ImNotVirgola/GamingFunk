package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrdineDAOImpl extends GenericDAOImpl<Ordine, Integer> {

    public OrdineDAOImpl() {
        super("ordine", "id_ordine");
    }

    @Override
    protected Ordine mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Ordine(
                rs.getInt("id_ordine"),
                rs.getString("stato"),
                rs.getBigDecimal("totale"),
                rs.getInt("dati_ordine"),
                rs.getInt("id_utente")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "stato, totale, dati_ordine, id_utente";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Ordine ordine) throws SQLException {
        stmt.setString(1, ordine.getStato());
        stmt.setBigDecimal(2, ordine.getTotale());
        stmt.setInt(3, ordine.getDatiOrdine());
        stmt.setInt(4, ordine.getIdUtente());
    }

    @Override
    protected String getUpdateSetClause() {
        return "stato = ?, totale = ?, dati_ordine = ?, id_utente = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Ordine ordine) throws SQLException {
        stmt.setString(1, ordine.getStato());
        stmt.setBigDecimal(2, ordine.getTotale());
        stmt.setInt(3, ordine.getDatiOrdine());
        stmt.setInt(4, ordine.getIdUtente());
        stmt.setInt(5, ordine.getIdOrdine());
    }

    public int creaOrdine(int idUtente, List<Map<String, Object>> carrello) {
        int idOrdine = -1;
        Connection con = null;

        try {
            con = ConPool.getConnection();
            System.out.println("Connessione stabilita");
            con.setAutoCommit(false);

            double totale = carrello.stream()
                    .mapToDouble(item -> {
                        double prezzo = parsePrice(item.get("prezzo"));
                        int quantita = parseQuantity(item.get("quantità"));
                        System.out.println("🛒 Item: " + item);
                        System.out.println("    Prezzo: " + prezzo + ", Quantità: " + quantita);
                        return prezzo * quantita;
                    })
                    .sum();

            System.out.println("💰 Totale calcolato: " + totale);
            try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO ordine (stato, totale, dati_ordine, id_utente) VALUES (?, ?, ?, ?)",
                    PreparedStatement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, "in elaborazione");
                ps.setBigDecimal(2, new java.math.BigDecimal(totale));
                ps.setInt(3, 0); // dati_ordine placeholder
                ps.setInt(4, idUtente);

                int righeInserite = ps.executeUpdate();
                System.out.println("📝 Inserite " + righeInserite + " righe in 'ordine'");

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        idOrdine = rs.getInt(1);
                        System.out.println("✅ ID ordine generato: " + idOrdine);
                    } else {
                        System.out.println("❌ Errore: nessuna chiave generata per ordine.");
                        con.rollback();
                        return -1;
                    }
                }
            }

            try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO ordine_prodotto (id_ordine, id_prodotto, quantita, prezzo_unitario) VALUES (?, ?, ?, ?)")) {

                for (Map<String, Object> item : carrello) {
                    int idProdotto = parseId(item.get("id"));
                    int quantita = parseQuantity(item.get("quantità"));
                    double prezzo = parsePrice(item.get("prezzo"));

                    System.out.println("📦 Prodotto -> ID: " + idProdotto + ", Q: " + quantita + ", Prezzo: " + prezzo);

                    if (idProdotto == -1 || quantita == -1 || prezzo == -1) {
                        System.out.println("❌ Errore: dati non validi, rollback");
                        con.rollback();
                        return -1;
                    }

                    ps.setInt(1, idOrdine);
                    ps.setInt(2, idProdotto);
                    ps.setInt(3, quantita);
                    ps.setBigDecimal(4, new java.math.BigDecimal(prezzo));
                    ps.addBatch();
                }

                ps.executeBatch();
                System.out.println("✅ Inseriti prodotti nel database");
            }

            con.commit();
            System.out.println("✅ Transazione completata con successo");
        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            e.printStackTrace();
            return -1;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }

        return idOrdine;
    }


    private int parseId(Object obj) {
        if (obj == null) return -1;

        if (obj instanceof Integer) {
            return (Integer) obj;
        }

        try {
            return Integer.parseInt(obj.toString());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return -1;
        }
    }

    private int parseQuantity(Object obj) {
        if (obj == null) return -1;

        if (obj instanceof Integer) {
            return (Integer) obj;
        }

        try {
            return Integer.parseInt(obj.toString());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return -1;
        }
    }

    private double parsePrice(Object obj) {
        if (obj == null) return -1;

        if (obj instanceof Number) {
            return ((Number) obj).doubleValue();
        }

        try {
            return Double.parseDouble(obj.toString());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public List<Ordine> getOrdiniByUtente(int idUtente) {
        List<Ordine> ordini = new ArrayList<>();

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM ordine WHERE id_utente = ? ORDER BY id_ordine DESC")) {

            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine ordine = mapResultSetToEntity(rs);
                    ordini.add(ordine);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ordini;
    }
    
    public List<Ordine> getByCliente(String filtroCliente) {
        List<Ordine> ordini = new ArrayList<>();
        String sql = "SELECT o.* FROM ordine o JOIN utente u ON o.id_utente = u.id_utente " +
                     "WHERE u.nome LIKE ? OR u.cognome LIKE ? ORDER BY o.id_ordine DESC";

        try (Connection con = ConPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String filtro = "%" + filtroCliente + "%";
            ps.setString(1, filtro);
            ps.setString(2, filtro);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ordini.add(mapResultSetToEntity(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ordini;
    }


}