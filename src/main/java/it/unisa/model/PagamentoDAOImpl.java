package it.unisa.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PagamentoDAOImpl extends GenericDAOImpl<Pagamento, Integer> {

    public PagamentoDAOImpl() {
        super("pagamento", "id_pagamento");
    }

    @Override
    protected Pagamento mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Pagamento(
                rs.getInt("id_pagamento"),
                rs.getString("metodo_pagamento"),
                rs.getString("stato_pagamento"),
                rs.getInt("id_ordine")
        );
    }

    @Override
    protected String getInsertColumns() {
        return "metodo_pagamento, stato_pagamento, id_ordine";
    }

    @Override
    protected String getInsertPlaceholders() {
        return "?, ?, ?";
    }

    @Override
    protected void setPreparedStatementValues(PreparedStatement stmt, Pagamento pagamento) throws SQLException {
        stmt.setString(1, pagamento.getMetodoPagamento());
        stmt.setString(2, pagamento.getStatoPagamento());
        stmt.setInt(3, pagamento.getIdOrdine());
    }

    @Override
    protected String getUpdateSetClause() {
        return "metodo_pagamento = ?, stato_pagamento = ?, id_ordine = ?";
    }

    @Override
    protected void setPreparedStatementValuesForUpdate(PreparedStatement stmt, Pagamento pagamento) throws SQLException {
        stmt.setString(1, pagamento.getMetodoPagamento());
        stmt.setString(2, pagamento.getStatoPagamento());
        stmt.setInt(3, pagamento.getIdOrdine());
        stmt.setInt(4, pagamento.getIdPagamento());
    }
}