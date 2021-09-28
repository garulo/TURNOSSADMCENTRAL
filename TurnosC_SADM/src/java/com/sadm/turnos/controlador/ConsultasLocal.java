package com.sadm.turnos.controlador;

import com.sadm.turnos.dao.ConexionLocal;
import com.sadm.turnos.dao.Servicio;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

public class ConsultasLocal extends ConexionDBLocal {

    public ConsultasLocal(ConexionLocal cl) {
        super(cl);
    }

    /*
     *serv_ofi
     */
    public boolean serv_ofi(List<Servicio> lstServ, ConexionLocal conloc) {

        PreparedStatement pst = null;
        PreparedStatement pst2 = null;
        PreparedStatement pst3 = null;
        PreparedStatement pst4 = null;

        try {
            String consulta = "delete from servicios;";
            pst = getConexion(conloc).prepareStatement(consulta);

            System.out.println("pst::: " + pst);
            if (pst.executeUpdate() >= 0) {

                System.out.println("lstServ::: " + lstServ.size());
                for (Servicio s : lstServ) {
                    pst2 = null;

                    String consulta2 = "INSERT INTO `turnos`.`servicios` (`id`, `DescripcionServicio`, `Estatus`, `UserLastUpdate`, `FechaLastUpdate`, `Color`,`prefijo`) VALUES (?,?,?,?,?,?,?);";
                    pst2 = getConexion(conloc).prepareStatement(consulta2);
                    pst2.setString(1, s.getId());
                    pst2.setString(2, s.getDescripcionServicio());
                    pst2.setString(3, s.getEstatus());
                    pst2.setString(4, s.getUserLastUpdate());
                    pst2.setString(5, s.getFechaLastUpdate());
                    pst2.setString(6, s.getColor());
                    pst2.setString(7, s.getPrefijo());
                    System.out.println("pst2::: " + pst2);
                    if (pst2.executeUpdate() == 1) {
                        System.out.println("Servicio Agregado a DB LOCAL :::" + s.getDescripcionServicio());
                    }
                }
                /*Script para eliminar relación servicios ventanillas  
                 //            String consulta3 = "delete from servicio_ventanillas;";
                 //            pst3 = getConexion().prepareStatement(consulta3);
                 //
                 //            //System.out.println("pst3::: "+pst3);
                 //            if (pst3.executeUpdate() >= 0) {
                 //            System.out.println("::: Relacion Servicios Ventanillas eliminado en DB LOCAL :::" );
                 //           
                 //            }
                 //            String consulta4 = "UPDATE ventanillas SET servicios = '';";
                 //            pst4 = getConexion().prepareStatement(consulta4);
                 //
                 //            //System.out.println("pst4::: "+pst4);
                 //            if (pst4.executeUpdate() >= 0) {
                 //            System.out.println("::: Relacion Servicios Ventanillas eliminado en DB LOCAL :::" );
                 //           
                 //            }
                 */

                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion(conloc) != null) {
                    getConexion(conloc).close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (pst2 != null) {
                    pst2.close();
                }
                if (pst3 != null) {
                    pst3.close();
                }
                if (pst4 != null) {
                    pst4.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }

    //TEST de agregarOficina
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     ConexionLocal colo = new ConexionLocal();

     boolean oficina = co.agregarOficina(colo);
     System.out.println("Oficina Agregada :::" + oficina);
     }
     */

//                
    //agregarUsuario 
    public boolean agregarUsuario(String txtAgregarUUsuario, String txtAgregarUNombre, String txtAgregarUPass, String txtAgregarUEmail, String txtAgregarUEPerfil, String txtAgregarUOfi, String txtAgregarUEstatus, String useragr, ConexionLocal conloc) {

        PreparedStatement pst = null;
        String uid = UUID.randomUUID().toString();
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String fecha = dateFormat.format(cal.getTime());

        try {
            String consulta = "INSERT INTO `turnos`.`usuarios` (`id`, `usuario`, `password`, `nombre`, `email`, `idRol`, `estatus`, `fecha`, `ventanilla`) VALUES (?,?,?,?,?,?,?,?,?);";
            pst = getConexion(conloc).prepareStatement(consulta);

            pst.setString(1, uid);
            pst.setString(2, txtAgregarUUsuario);
            pst.setString(3, txtAgregarUPass);
            pst.setString(4, txtAgregarUNombre);
            pst.setString(5, txtAgregarUEmail);
            pst.setString(6, txtAgregarUEPerfil);
            pst.setString(7, txtAgregarUEstatus);
            pst.setString(8, fecha);
            pst.setString(9, txtAgregarUOfi);

            //System.out.println("pst UPDATE ::: " + pst);
            if (pst.executeUpdate() == 1) {
                System.out.println("Usuario Agregado en DB LOcal :::" + txtAgregarUUsuario + "/Oficina " + txtAgregarUOfi);

                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion(conloc) != null) {
                    getConexion(conloc).close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }

    //TEST de agregarUsuario
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     boolean servicio = co.agregarUsuario("Usuario", "Nombre", "Pass", "Email", "04", "1", "localprueba");
     System.out.println("Ventanilla Agregada :::" + servicio);
     }
     */

    public boolean agregar_oficina_local(ConexionLocal conloc) {
        PreparedStatement pst = null;

        try {
            String consulta = "INSERT INTO `turnos`.`oficinalocal` (`idOficina`, `num`, `nombre`, `desc`, `direccion`, `cp`, `municipio`, `tel`, `ciudad`, `email1`, `servidor`, `db_username`, `db_pass`, `db_host`, `db_port`, `db_name`) \n"
                    + "VALUES (?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?,?, ?, ?, ?, ?);";
            pst = getConexion(conloc).prepareStatement(consulta);

            pst.setString(1, conloc.getIdOficina());
            pst.setString(2, conloc.getNum());
            pst.setString(3, conloc.getNombre());
            pst.setString(4, conloc.getDesc());
            pst.setString(5, conloc.getDireccion());
            pst.setString(6, conloc.getCp());
            pst.setString(7, conloc.getMunicipio());
            pst.setString(8, conloc.getTel());
            pst.setString(9, conloc.getCiudad());
            pst.setString(10, conloc.getEmail1());
            pst.setString(11, conloc.getServidor());
            pst.setString(12, conloc.getDb_username());
            pst.setString(13, conloc.getDb_pass());
            pst.setString(14, conloc.getDb_host());
            pst.setString(15, conloc.getDb_port());
            pst.setString(16, conloc.getDb_name());

            //System.out.println("pst UPDATE ::: " + pst);
            if (pst.executeUpdate() == 1) {
                System.out.println("OficinaLocal Agregada en DB LOcal :::" + conloc.getDb_host() + "/Oficina " + conloc.getNum());

                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion(conloc) != null) {
                    getConexion(conloc).close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }

    
    
    public boolean editar_oficina_local(ConexionLocal conloc) {
        PreparedStatement pst = null;

        try {
            String consulta = "UPDATE `turnos`.`oficinalocal` SET  `nombre`=?, `desc`=?, `direccion`=?, `cp`=?, `municipio`=?, `tel`=?, `ciudad`=?, `email1`=?, `servidor`=?, `db_username`=?, `db_pass`=?, `db_host`=?, `db_port`=?, `db_name`=? WHERE (`num`=?);";
            pst = getConexion(conloc).prepareStatement(consulta);

            pst.setString(1, conloc.getNombre());
            pst.setString(2, conloc.getDesc());
            pst.setString(3, conloc.getDireccion());
            pst.setString(4, conloc.getCp());
            pst.setString(5, conloc.getMunicipio());
            pst.setString(6, conloc.getTel());
            pst.setString(7, conloc.getCiudad());
            pst.setString(8, conloc.getEmail1());
            pst.setString(9, conloc.getServidor());
            pst.setString(10, conloc.getDb_username());
            pst.setString(11, conloc.getDb_pass());
            pst.setString(12, conloc.getDb_host());
            pst.setString(13, conloc.getDb_port());
            pst.setString(14, conloc.getDb_name());
            pst.setString(15, conloc.getNum());
            

            //System.out.println("pst UPDATE ::: " + pst);
            if (pst.executeUpdate() == 1) {
                System.out.println("OficinaLocal Editada en DB LOcal :::" + conloc.getDb_host() + "/Oficina " + conloc.getNum());

                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion(conloc) != null) {
                    getConexion(conloc).close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }
}
