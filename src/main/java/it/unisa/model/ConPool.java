package it.unisa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConPool {

    private static final String URL = "jdbc:mariadb://localhost:3306/gamingfunk";  // cambia DB se serve
    private static final String USER = "giovanni";   // o l'utente del tuo DB
    private static final String PASSWORD = "new_password_here";   // o la tua password

    static {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver JDBC non trovato.", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
