
package com.sadm.turnos.controlador;

import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDBCentral {
    
  private java.sql.Connection con;

    public ConexionDBCentral() {
        //System.out.println("::: ConexionDBCentral :::");
        try {

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String connectionURL = "jdbc:sqlserver://192.168.46.97:1433;databaseName=turnos_central;user=admweb;password=mko2021;";
            con = (java.sql.Connection) DriverManager.getConnection(connectionURL);
            System.out.println("Conexión Central Exitosa");

        } catch (ClassNotFoundException e) {
            System.err.println("ERROR ClassNotFoundException: " + e);
        } catch (SQLException e) {
            System.out.println("ERROR SQLException: " + e);
        }
    }

    public java.sql.Connection getConexion() {
        
        return con;
    }
    public static void main(String[] args) {
        ConexionDBCentral conn = new ConexionDBCentral();
        //System.out.println("**** Conexión a DB Central Exitosa *****");
    }
}
