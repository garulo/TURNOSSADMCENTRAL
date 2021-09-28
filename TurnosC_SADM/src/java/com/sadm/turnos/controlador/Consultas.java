/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sadm.turnos.controlador;

import com.sadm.turnos.dao.ConexionLocal;
import com.sadm.turnos.dao.Oficina;
import com.sadm.turnos.dao.Servicio;
import com.sadm.turnos.dao.TipoServicio;
import com.sadm.turnos.dao.Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

/**
 *
 * @author marco
 */
public class Consultas extends ConexionDBCentral {

    /*
     * USUARIOS
     */
    //AUTENTICACIÓN DE USUARIO
    public Usuario autenticacion(String usuario, String password) {

        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            String consulta = "select * from usuarios where usuario = ? and password= ? and estatus ='1' and idRol='1';";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, usuario);
            pst.setString(2, password);

            rs = pst.executeQuery();

            Usuario user = new Usuario();
            while (rs.next()) {
                user = new Usuario();
                user.setId(rs.getString("id"));
                user.setUsuario(rs.getString("usuario"));
                user.setPassword(rs.getString("password"));
                user.setNombre(rs.getString("nombre"));
                user.setEmail(rs.getString("email"));
                user.setIdRol(rs.getString("idRol"));
                user.setEstatus(rs.getString("estatus"));
                user.setFecha(rs.getString("fecha"));

            }

            System.out.println("USUARIO ::: " + user.getNombre());
            return user;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return null;
    }
    //TEST de autenticacion

//     public static void main(String[] args) {
//     Consultas co = new Consultas();
//     Usuario user = new Usuario();
//    user = co.autenticacion("Admin", "PassTest");
//    System.out.println("idRol ::: "+user.getIdRol());
//     }
    /* Obtener all allUsuariosAdmin*/
    public List<Usuario> allUsuariosAdmin() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Usuario usuario;
        List<Usuario> lstUsuario = new ArrayList<Usuario>();

        try {
            String consulta = "select * from usuarios where idRol <> '3';";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getString("id"));
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setPassword(rs.getString("password"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setIdRol(rs.getString("idRol"));
                usuario.setEstatus(rs.getString("estatus"));
                usuario.setFecha(rs.getString("fecha"));
                usuario.setOficina(rs.getString("oficina"));

                lstUsuario.add(usuario);

            }

            return lstUsuario;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }
        return lstUsuario;
    }
    //TEST de allUsuariosAdmin
   /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Usuario> allUsuariosAdmin = new ArrayList<Usuario>();
     lstOficinas = co.allOficinas();
     System.out.println("Lista de Usuarios Admin :::" + lstOficinas.size()); 
     }
     */

    /*agregarUsuario*/
    //agregarUsuario 
    public boolean agregarUsuario(String txtAgregarUUsuario, String txtAgregarUNombre, String txtAgregarUPass, String txtAgregarUEmail, String txtAgregarUEPerfil, String txtAgregarUOfi, String txtAgregarUEstatus, String useragr) {

        PreparedStatement pst = null;
        String uid = UUID.randomUUID().toString();
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String fecha = dateFormat.format(cal.getTime());

        try {
            String consulta = "INSERT INTO usuarios (id, usuario, password, nombre, email, idRol, estatus, fecha, oficina) VALUES (?,?,?,?,?,?,?,?,?);";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, uid);
            pst.setString(2, txtAgregarUUsuario);
            pst.setString(3, txtAgregarUPass);
            pst.setString(4, txtAgregarUNombre);
            pst.setString(5, txtAgregarUEmail);
            pst.setString(6, txtAgregarUEPerfil);
            pst.setString(7, txtAgregarUEstatus);
            pst.setString(8, fecha);
            pst.setString(9, txtAgregarUOfi);

            System.out.println("pst UPDATE central ::: " + pst);
            if (pst.executeUpdate() == 1) {
                System.out.println("Usuario Agregado :::" + txtAgregarUUsuario);

                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
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

    /*eliminarUsuario*/
    //eliminarUsuario 
    public boolean eliminarUsuario(String idUsElim, String userelim) {

        PreparedStatement pst9 = null;

        try {

            String consulta9 = "delete from usuarios where id = ? ;";
            pst9 = getConexion().prepareStatement(consulta9);
            pst9.setString(1, idUsElim);

            if (pst9.executeUpdate() >= 1) {
                System.out.println("Usuario eliminado :::" + idUsElim + " :: Por :: " + userelim);

            }

            return true;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }

                if (pst9 != null) {
                    pst9.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }
    //TEST de eliminarUsuario

    /*public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean servicio = co.eliminarUsuario("8baf4c07-8fe0-4ac3-9e7b-ed17319eec11","user");
     System.out.println("Eliminar Usuario test  :::" + servicio);
     }*/
    /*editarUsuario*/
    //editarUsuario 
    public boolean editarUsuario(String txtEditarUId, String txtEditarUUsu, String txtEditarUNombre, String txtEditarUPass, String txtEditarUEmail, String txtEditarUEPerfil, String txtEditarUEstatus, String txtEditarUOfi, String txtusredit) {

        PreparedStatement pst = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String fecha = dateFormat.format(cal.getTime());

        try {
            String consulta = "UPDATE usuarios SET password=?, nombre=?, email=?, idRol=?, estatus=?, fecha=?, oficina=? WHERE (usuario=?);";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, txtEditarUPass);
            pst.setString(2, txtEditarUNombre);
            pst.setString(3, txtEditarUEmail);
            pst.setString(4, txtEditarUEPerfil);
            pst.setString(5, txtEditarUEstatus);
            pst.setString(6, fecha);
            pst.setString(7, txtEditarUOfi);
            pst.setString(8, txtEditarUUsu);

            System.out.println("pst UPDATE ::: " + pst);

            if (pst.executeUpdate() == 1) {
                System.out.println("Usuario Editado :::" + txtEditarUUsu);

                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
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
    //TEST de editarUsuario
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     boolean servicio = co.agregarUsuarioVentanilla("");
     System.out.println("Ventanilla Agregada :::" + servicio);
     }
     */

    /*
     *****
     *****Oficinas
     *****
     */
    //Obtener all allOficinas 
    public List<Oficina> allOficinas() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Oficina oficina;
        List<Oficina> lstOficinas = new ArrayList<Oficina>();

        try {
            String consulta = "select * from oficinas;";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                oficina = new Oficina();
                oficina.setId(rs.getString("idOficina"));
                oficina.setNum(rs.getString("num"));
                oficina.setNombre(rs.getString("nombre"));
                oficina.setDesc(rs.getString("descripcion"));
                oficina.setDireccion(rs.getString("direccion"));
                oficina.setCp(rs.getString("cp"));
                oficina.setMunicipio(rs.getString("municipio"));
                oficina.setTel1(rs.getString("tel"));
                oficina.setCiudad(rs.getString("ciudad"));
                oficina.setEmail1(rs.getString("email1"));
                oficina.setServidor(rs.getString("servidor"));
                oficina.setDb_username(rs.getString("db_username"));
                oficina.setDb_pass(rs.getString("db_pass"));
                oficina.setDb_host(rs.getString("db_host"));
                oficina.setDb_port(rs.getString("db_port"));
                oficina.setDb_name(rs.getString("db_name"));
                oficina.setServicios(rs.getString("servicios"));
                oficina.setCodUniCom(rs.getString("codUniCom"));

                lstOficinas.add(oficina);

            }

            return lstOficinas;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }
        return lstOficinas;
    }
    //TEST de allOficinas
   /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Oficina> lstOficinas = new ArrayList<Oficina>();
     lstOficinas = co.allOficinas();
     System.out.println("Lista de ofcinas :::" + lstOficinas.size()); 
     }
     */

    //agregarOficina 
    public boolean agregarOficina(String user, String agreOfiNum,String agreUniCom, String agreOfiNombre, String agreOfiDesc, String agreOfiDir, String agreOfiCP, String agreOfiMun, String agreOfiTel, String agreOfiCity, String agreOfiEmail, String dbUserName, String server, String dbPass, String dbHost, String dbPort, String dbName, String agreOfiServ) {

        PreparedStatement pst = null;
        PreparedStatement pstz = null;
        String uid = UUID.randomUUID().toString();
        System.out.println("agreOfiMun:: " + agreOfiMun);
        try {
            System.out.println("agregaroficina::: " + agreOfiNum);
            String consulta = "INSERT INTO oficinas (idOficina, num, nombre,descripcion, direccion, cp, municipio, tel, ciudad, email1, servidor,  db_username, db_pass, db_host, db_port, db_name,servicios,codUniCom) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, uid);
            pst.setString(2, agreOfiNum);
            pst.setString(3, agreOfiNombre);
            pst.setString(4, agreOfiDesc);
            pst.setString(5, agreOfiDir);
            pst.setString(6, agreOfiCP);
            pst.setString(7, agreOfiMun);
            pst.setString(8, agreOfiTel);
            pst.setString(9, agreOfiCity);
            pst.setString(10, agreOfiEmail);
            pst.setString(11, server);
            pst.setString(12, dbUserName);
            pst.setString(13, dbPass);
            pst.setString(14, dbHost);
            pst.setString(15, dbPort);
            pst.setString(16, dbName);
            pst.setString(17, agreOfiServ);
            pst.setString(18, agreUniCom);

            System.out.println("pst::: " + pst);
            if (pst.executeUpdate() == 1) {
                System.out.println("Oficina Agregada :::" + agreOfiNombre);
                //AGREGAR TABLA LOCAL
                pstz = null;
                StringTokenizer st = new StringTokenizer(agreOfiServ);
                String uidz = UUID.randomUUID().toString();
                DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Calendar calz = Calendar.getInstance();
                String fechaz = dateFormatz.format(calz.getTime());
                String consultaz = new String();
                List<String> lstSt = new ArrayList();
                while (st.hasMoreTokens()) {
                    String ser = new String();
                    ser = st.nextToken();
                    lstSt.add(ser);
                }
                System.out.println("lstSt size :::" + lstSt.size());
                if (lstSt.size() > 0) {
                    for (String strServ : lstSt) {
                        pstz = null;
                        uidz = UUID.randomUUID().toString();
                        dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                        calz = Calendar.getInstance();
                        fechaz = dateFormatz.format(calz.getTime());
                        consultaz = new String();
                        consultaz = "INSERT INTO oficina_servicio (id, Oficina, NombreServicio, UsuarioLastUpdate, FechaLastUpdate) VALUES (?, ?, ?, ?, ?);";
                        pstz = getConexion().prepareStatement(consultaz);

                        pstz.setString(1, uidz);
                        pstz.setString(2, agreOfiNum);
                        pstz.setString(3, strServ);
                        pstz.setString(4, user);
                        pstz.setString(5, fechaz);

                        if (pstz.executeUpdate() == 1) {
                            System.out.println("Oficina - Servicio Agregados :::" + agreOfiNum + " ::: " + strServ);
                        } else {
                            System.out.println("Oficina - Servicio ERROR AGREGAR :::" + agreOfiNum + " ::: " + agreOfiNombre);
                        }
                    }
                }

                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (pstz != null) {
                    pstz.close();
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

     boolean oficina = co.agregarOficina();
     System.out.println("Oficina Agregada :::" + oficina);
     }
     */

    //eliminarOficina 
    public boolean eliminarOficina(String txtNumOficina, String txtIdOficina, String txtUserElim) {

        PreparedStatement pst9 = null;
        PreparedStatement pst = null;

        try {

            String consulta9 = "delete from oficinas where idOficina = ? ;";
            pst9 = getConexion().prepareStatement(consulta9);
            pst9.setString(1, txtIdOficina);

            if (pst9.executeUpdate() >= 1) {
                System.out.println("Oficina eliminada :::" + txtIdOficina + "  Por el usuario::: " + txtUserElim);
                pst = null;
                String consulta = "delete from oficina_servicio where Oficina = ? ;";
                pst = getConexion().prepareStatement(consulta);
                pst.setString(1, txtNumOficina);
                if (pst.executeUpdate() >= 1) {
                    System.out.println("Oficina-Servicio eliminada :::" + txtNumOficina + "  Por el usuario::: " + txtUserElim);
                }
            }

            return true;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (pst9 != null) {
                    pst9.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }
    //TEST de eliminarOficina

    /*public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean servicio = co.eliminarOficina("8baf4c07-8fe0-4ac3-9e7b-ed17319eec11");
     System.out.println("Eliminar Oficina test  :::" + servicio);
     }*/
    //editarOficina 
    public boolean editarOficina(String user, String editOfiId, String editOfiNum, String editOfiNombre, String editOfiDesc, String editOfiDir, String editOfiCP, String editOfiMun, String editOfiTel, String editOfiCity, String editOfiEmail, String editOfiServ, String editdbUserName, String editdbPass, String editdbHost, String editdbPort, String editdbName) {

        PreparedStatement pst = null;
        PreparedStatement pstz = null;
        PreparedStatement pstc = null;

        try {
            String consulta = "UPDATE oficinas SET nombre=?, descripcion=?, direccion=?, cp=?, municipio=?, tel=?, ciudad=?, email1=?, servicios=?, servidor=?,db_username=?,db_pass=?, db_host=?, db_port=?,db_name=? WHERE (idOficina=?);";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, editOfiNombre);
            pst.setString(2, editOfiDesc);
            pst.setString(3, editOfiDir);
            pst.setString(4, editOfiCP);
            pst.setString(5, editOfiMun);
            pst.setString(6, editOfiTel);
            pst.setString(7, editOfiCity);
            pst.setString(8, editOfiEmail);
            pst.setString(9, editOfiServ);
            pst.setString(10, editdbHost);
            pst.setString(11, editdbUserName);
            pst.setString(12, editdbPass);
            pst.setString(13, editdbHost);
            pst.setString(14, editdbPort);
            pst.setString(15, editdbName);
            pst.setString(16, editOfiId);

            //System.out.println("pst::: " + pst);
            if (pst.executeUpdate() == 1) {
                System.out.println("Oficina editada :::" + editOfiNombre + "  Por el usuario::: " + user);

                pstc = null;
                String consultac = new String();
                consultac = "delete from oficina_servicio where Oficina= ? ;";
                pstc = getConexion().prepareStatement(consultac);
                pstc.setString(1, editOfiNum);
                if (pstc.executeUpdate() == 1) {
                    System.out.println("Oficina - Servicios Eliminados :::" + editOfiServ + " ::: ");
                }

                StringTokenizer st = new StringTokenizer(editOfiServ);

                String uidz = UUID.randomUUID().toString();
                DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Calendar calz = Calendar.getInstance();
                String fechaz = dateFormatz.format(calz.getTime());
                String consultaz = new String();
                List<String> lstSt = new ArrayList();

                while (st.hasMoreTokens()) {
                    String ser = new String();
                    ser = st.nextToken();
                    lstSt.add(ser);
                }

                for (String strServ : lstSt) {

                    pstz = null;
                    uidz = UUID.randomUUID().toString();
                    dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                    calz = Calendar.getInstance();
                    fechaz = dateFormatz.format(calz.getTime());
                    consultaz = new String();
                    consultaz = "INSERT INTO oficina_servicio (id, Oficina, NombreServicio, UsuarioLastUpdate, FechaLastUpdate) VALUES (?, ?, ?, ?, ?);";
                    pstz = getConexion().prepareStatement(consultaz);

                    pstz.setString(1, uidz);
                    pstz.setString(2, editOfiNum);
                    pstz.setString(3, strServ);
                    pstz.setString(4, user);
                    pstz.setString(5, fechaz);

                    if (pstz.executeUpdate() == 1) {
                        System.out.println("Servicios - Ventanilla Editados :::" + editOfiNum + " ::: " + strServ);
                    } else {
                        System.out.println("Servicios - Ventanilla ERROR EDITAR :::" + editOfiNum + " ::: " + editOfiServ);
                    }

                }

                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (pstz != null) {
                    pstz.close();
                }
                if (pstc != null) {
                    pstc.close();
                }

            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }
    //TEST de editarOficina
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean oficina = co.editarOficina();
     System.out.println("Oficina Editada :::" + oficina);
     }
     */

    /*
     *****
     *****Servicios
     *****
     */
    //Obtener Servicios Activos
    public List<Servicio> serviciosActivos() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Servicio servicio;
        List<Servicio> lstServicios = new ArrayList<Servicio>();

        try {
            String consulta = "select * from servicios where Estatus='1';";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                servicio = new Servicio();

                servicio.setId(rs.getString("id"));
                servicio.setDescripcionServicio(rs.getString("DescripcionServicio"));
                servicio.setEstatus(rs.getString("Estatus"));
                servicio.setUserLastUpdate(rs.getString("UserLastUpdate"));
                servicio.setFechaLastUpdate(rs.getString("FechaLastUpdate"));
                servicio.setColor(rs.getString("Color"));
                servicio.setPrefijo(rs.getString("prefijo"));

                lstServicios.add(servicio);

            }

            return lstServicios;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }
        return lstServicios;
    }
    //TEST de serviciosActivos
   /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Servicio> lstOficinas = new ArrayList<Servicio>();
     lstOficinas = co.serviciosActivos();
     System.out.println("Lista de servicios :::" + lstOficinas.size()); 
     }
     */

    //Obtener allServicios
    public List<Servicio> allServicios() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Servicio servicio;
        List<Servicio> lstServicios = new ArrayList<Servicio>();

        try {
            String consulta = "select * from servicios";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                servicio = new Servicio();

                servicio.setId(rs.getString("id"));
                servicio.setDescripcionServicio(rs.getString("DescripcionServicio"));
                servicio.setEstatus(rs.getString("Estatus"));
                servicio.setUserLastUpdate(rs.getString("UserLastUpdate"));
                servicio.setFechaLastUpdate(rs.getString("FechaLastUpdate"));
                servicio.setColor(rs.getString("Color"));
                servicio.setPrefijo(rs.getString("prefijo"));

                lstServicios.add(servicio);

            }

            return lstServicios;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }
        return lstServicios;
    }
    //TEST de allServicios
   /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Servicio> lstOficinas = new ArrayList<Servicio>();
     lstOficinas = co.allServicios();
     System.out.println("Lista de servicios :::" + lstOficinas.size()); 
     }
     */

    //allTipoServicio
    //Obtener allTipoServicio
    public List<TipoServicio> allTipoServicio() {

        PreparedStatement pst = null;
        ResultSet rs = null;
        TipoServicio servicio;
        List<TipoServicio> lstServicios = new ArrayList<TipoServicio>();

        try {
            String consulta = "select * from cat_tipo_servicios";
            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();

            while (rs.next()) {
                servicio = new TipoServicio();

                servicio.setIdtipo(rs.getString("idtipo"));
                servicio.setIdservicio(rs.getString("idservicio"));
                servicio.setNombre(rs.getString("Nombre"));
                servicio.setDescripcion(rs.getString("Descripcion"));

                lstServicios.add(servicio);

            }

            return lstServicios;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }
        return lstServicios;
    }
    //TEST de allServicios
   /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Servicio> lstOficinas = new ArrayList<Servicio>();
     lstOficinas = co.allServicios();
     System.out.println("Lista de servicios :::" + lstOficinas.size()); 
     }
     */
    
    //agregarTipoServicio
    public boolean agregarTipoServicio(String idtipo,String nombreservicio,String idservicio,String nombretipo,String user) {

        PreparedStatement pst = null;
        DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar calz = Calendar.getInstance();
        String fechaz = dateFormatz.format(calz.getTime());

        try {
            String consulta = "INSERT INTO cat_tipo_servicios ([idtipo], [idservicio], [Nombre], [Descripcion], [UserLastUpdate], [FechaLastUpdate]) VALUES (?, ?, ?, ?, ?, ?);";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, idtipo);
            pst.setString(2, idservicio);
            pst.setString(3, nombretipo);
            pst.setString(4, nombreservicio);
            pst.setString(5, user);
            pst.setString(6, fechaz);

            //System.out.println("pst::: "+pst);
            if (pst.executeUpdate() == 1) {
                  System.out.println("Tipo de Servicio Agregado ::: "+nombretipo+" : Por :" + user);
                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
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
    //TEST de agregarServicio
    
  
    
    
    //agregarServicio 
    public boolean agregarServicio(String user, String agreServNombre, String txtAgregarSEstatus, String colorselectorA, String prefijo) {

        PreparedStatement pst = null;
        String uid = UUID.randomUUID().toString();
        DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar calz = Calendar.getInstance();
        String fechaz = dateFormatz.format(calz.getTime());

        try {
            String consulta = "INSERT INTO servicios (id, DescripcionServicio, Estatus, UserLastUpdate, FechaLastUpdate, Color, prefijo) VALUES (?, ?, ?, ?, ?, ?, ?);";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, uid);
            pst.setString(2, agreServNombre);
            pst.setString(3, txtAgregarSEstatus);
            pst.setString(4, user);
            pst.setString(5, fechaz);
            pst.setString(6, colorselectorA);
            pst.setString(7, prefijo);

            //System.out.println("pst::: "+pst);
            if (pst.executeUpdate() == 1) {
                //  System.out.println("Servicio Agregado ::: "+agreServNombre+" : Por :" + user);
                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
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
    //TEST de agregarServicio
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean oficina = co.agregarServicio();
     System.out.println("Servicio Agregado :::" + oficina);
     }
     */

    //eliminarTipoServicio 
    public boolean eliminarTipoServicio(String idTipoElim) {

        PreparedStatement pst9 = null;

        try {

            String consulta9 = "delete from cat_tipo_servicios where idtipo = ? ;";
            pst9 = getConexion().prepareStatement(consulta9);
            pst9.setString(1, idTipoElim);

            if (pst9.executeUpdate() >= 1) {
                System.out.println("Servicio eliminado :::" + idTipoElim );
               
            }

            return true;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst9 != null) {
                    pst9.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }
    
    
    
    
    //eliminarServicio 
    public boolean eliminarServicio(String txtNombreServElim, String txtUserElimServ) {

        PreparedStatement pst9 = null;
        PreparedStatement pst = null;

        try {

            String consulta9 = "delete from servicios where DescripcionServicio = ? ;";
            pst9 = getConexion().prepareStatement(consulta9);
            pst9.setString(1, txtNombreServElim);

            if (pst9.executeUpdate() >= 1) {
                System.out.println("Servicio eliminado :::" + txtNombreServElim + "  Por el usuario::: " + txtUserElimServ);
                pst = null;
                String consulta = "delete from oficina_servicio where NombreServicio = ? ;";
                pst = getConexion().prepareStatement(consulta);
                pst.setString(1, txtNombreServElim);
                if (pst.executeUpdate() >= 1) {
                    System.out.println("Oficina-Servicio eliminada :::" + txtNombreServElim + "  Por el usuario::: " + txtUserElimServ);
                }
            }

            return true;

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (pst9 != null) {
                    pst9.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return false;
    }
    //TEST de eliminarServicio

    /*public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean servicio = co.eliminarServicio("");
     System.out.println("Eliminar Oficina test  :::" + servicio);
     }*/
//editarServicio 
    public boolean editarServicio(String user, String editServId, String editServNombre, String txtEditarSEstatus, String colorselectorE,String editServPrefijo) {

        PreparedStatement pst = null;
        String uid = UUID.randomUUID().toString();
        DateFormat dateFormatz = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar calz = Calendar.getInstance();
        String fechaz = dateFormatz.format(calz.getTime());

        try {
            String consulta = "UPDATE servicios SET Estatus= ? , UserLastUpdate= ? , FechaLastUpdate= ? , Color= ? , prefijo = ? WHERE (id= ? );";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, txtEditarSEstatus);
            pst.setString(2, user);
            pst.setString(3, fechaz);
            pst.setString(4, colorselectorE);
            pst.setString(5, editServPrefijo);
            pst.setString(6, editServId);

            //System.out.println("pst::: "+pst);
            if (pst.executeUpdate() == 1) {
                //  System.out.println("Servicio Agregado ::: "+agreServNombre+" : Por :" + user);
                return true;
            }

        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
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
    //TEST de agregarServicio
    /*
     public static void main(String[] args) {
     Consultas co = new Consultas();

     boolean oficina = co.agregarServicio();
     System.out.println("Servicio Agregado :::" + oficina);
     }
     */

    //Obtener slctServ
    public List<Servicio> slctServ(String agreOfiServ) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Servicio servicio;
        List<Servicio> lstServicios = new ArrayList<Servicio>();
        StringTokenizer st = new StringTokenizer(agreOfiServ);
        List<String> lstSt = new ArrayList();
        while (st.hasMoreTokens()) {
            String ser = new String();
            ser = st.nextToken();
            lstSt.add(ser);
        }

        try {
            for (String strServ : lstSt) {
                String consulta = "select * from servicios where DescripcionServicio =?";
                pst = getConexion().prepareStatement(consulta);
                pst.setString(1, strServ);
                rs = pst.executeQuery();

                while (rs.next()) {
                    servicio = new Servicio();

                    servicio.setId(rs.getString("id"));
                    servicio.setDescripcionServicio(rs.getString("DescripcionServicio"));
                    servicio.setEstatus(rs.getString("Estatus"));
                    servicio.setUserLastUpdate(rs.getString("UserLastUpdate"));
                    servicio.setFechaLastUpdate(rs.getString("FechaLastUpdate"));
                    servicio.setColor(rs.getString("Color"));
                    servicio.setPrefijo(rs.getString("prefijo"));

                    lstServicios.add(servicio);

                }

            }
        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return lstServicios;
    }
    //TEST de slctServ
   /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Servicio> lstOficinas = new ArrayList<Servicio>();
     lstOficinas = co.slctServ();
     System.out.println("Lista de servicios :::" + lstOficinas.size()); 
     }
     */

    //
//Obtener conexionOficina
    public ConexionLocal conexionOficina(String txtAgregarUOfi) {

        PreparedStatement pst = null;
        ResultSet rs = null;
        Servicio servicio;
        ConexionLocal cl = new ConexionLocal();

        try {

            String consulta = "select db_username, db_pass,db_host,db_port,db_name from oficinas where num =?";
            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, txtAgregarUOfi);
            rs = pst.executeQuery();
            while (rs.next()) {
                cl.setDb_username(rs.getString("db_username"));
                cl.setDb_pass(rs.getString("db_pass"));
                cl.setDb_host(rs.getString("db_host"));
                cl.setDb_port(rs.getString("db_port"));
                cl.setDb_name(rs.getString("db_name"));
            }
        } catch (Exception e) {
            System.err.println("catch Error: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {

                System.err.println("finally Error: " + e);
            }

        }

        return cl;
    }
    //TEST de slctServ
   /*
     public static void main(String[] args) {
     Consultas co = new Consultas();
     List<Servicio> lstOficinas = new ArrayList<Servicio>();
     lstOficinas = co.slctServ();
     System.out.println("Lista de servicios :::" + lstOficinas.size()); 
     }
     */
}
