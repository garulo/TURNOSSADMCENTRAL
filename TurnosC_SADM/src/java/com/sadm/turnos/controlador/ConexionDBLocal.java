
package com.sadm.turnos.controlador;

import com.mysql.jdbc.Connection;
import com.sadm.turnos.dao.ConexionLocal;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConexionDBLocal {
    
static ConexionLocal ccll = new ConexionLocal();
private String CLASSNAMEDRIVER = "com.mysql.jdbc.Driver";

private Connection con;


public ConexionDBLocal(ConexionLocal cl){
String URL="jdbc:mysql://"+cl.getDb_host()+":"+cl.getDb_port()+"/"+cl.getDb_name();
    try{
    Class.forName(CLASSNAMEDRIVER);
    con = (Connection) DriverManager.getConnection(URL,cl.getDb_username(),cl.getDb_pass());
    
    }catch (ClassNotFoundException e ){
        System.err.println("ERROR: "+e);
    }catch (SQLException e ){
        System.out.println("ERROR: "+e);
    }

}

public java.sql.Connection getConexion() {
        
        return con;
    }

public Connection getConexion(ConexionLocal cl){
return con;
}

    public static void main(ConexionLocal cl) {
        ConexionDBLocal conn = new ConexionDBLocal(ccll);
        System.out.println("**** Conexión a DB Exitosa *****");
    }
}