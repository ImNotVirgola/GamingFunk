package it.unisa.model;

import java.io.Serializable;
import java.util.Objects;

public class OrdineProdottoKey implements Serializable {

    private static final long serialVersionUID = 1L;
	
    private int idOrdine;
    private int idProdotto;

    public OrdineProdottoKey() {}

    public OrdineProdottoKey(int idOrdine, int idProdotto) {
        this.idOrdine = idOrdine;
        this.idProdotto = idProdotto;
    }

    public int getIdOrdine() {
        return idOrdine;
    }

    public void setIdOrdine(int idOrdine) {
        this.idOrdine = idOrdine;
    }

    public int getIdProdotto() {
        return idProdotto;
    }

    public void setIdProdotto(int idProdotto) {
        this.idProdotto = idProdotto;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof OrdineProdottoKey)) return false;
        OrdineProdottoKey that = (OrdineProdottoKey) o;
        return idOrdine == that.idOrdine && idProdotto == that.idProdotto;
    }

    @Override
    public int hashCode() {
        return Objects.hash(idOrdine, idProdotto);
    }

    @Override
    public String toString() {
        return "OrdineProdottoKey{" +
                "idOrdine=" + idOrdine +
                ", idProdotto=" + idProdotto +
                '}';
    }
}
