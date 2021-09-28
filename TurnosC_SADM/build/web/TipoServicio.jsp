<%@page import="com.sadm.turnos.dao.Servicio"%>
<%@page import="com.sadm.turnos.dao.TipoServicio"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.sadm.turnos.controlador.Consultas"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
    HttpSession objSession = request.getSession(false);
    String usuario = (String) objSession.getAttribute("usuario");
    String nombreUser = (String) objSession.getAttribute("nombre");
    if (null == usuario) {
        response.sendRedirect("Restringido.jsp");
    } else if (usuario.equals("")) {
        response.sendRedirect("index.jsp");
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrador Central de Turnos SADM</title>
        <link href="archivos/uploaded_files/Icono_SADM.png" rel="shortcut icon" type="image/x-icon" />
        <link href="archivos/uploaded_files/logo_sadm_color.png" rel="apple-touch-icon" />
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.23/angular.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"  crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"  crossorigin="anonymous"></script>        
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js">
        </script>
    </head>
    <body>
        <table class="table" style="alignment-adjust: central;" width="100%" height="100%" >
            <tbody style="alignment-baseline: central;" >
                <%                    Date fechaActual = new Date();
                    String n_fecha_format = new String();
                    n_fecha_format = new SimpleDateFormat("EEEEEEEEE dd 'de' MMMMM 'de' yyyy").format(fechaActual);
                    n_fecha_format = n_fecha_format.toUpperCase();
                    DateFormat time = new SimpleDateFormat("HH:mm");
                    String n_time_format = new String();
                    n_time_format = time.format(fechaActual);
                %>
                <tr>
                    <td colspan="3" style="alignment-adjust: auto;text-align: center;background-color: #668FB7;"><label style="font-weight: bold;font-size: 32px;font-weight: bold;font-size: 32px;font-family: 'Roboto', sans-serif;color: white;">OFICINA ADMINISTRATIVA CENTRAL</label></td>
                    <td colspan="2" style="alignment-adjust: auto;text-align: center;background-color: #668FB7; "><label style="font-size: 18px;font-family: 'Roboto', sans-serif;color: white;margin-top: 15px;"><%=n_fecha_format%></label></td>
                    <td colspan="1" style="alignment-adjust: auto;text-align: start;background-color: #668FB7; ">
                        <div class="dropdown">

                            <div class="dropdown-content">
                                <div class="desc">

                                    <form >

                                        <button style="background-color: white;border-radius: 7px;font-size: 12px;color: white;font-family: 'Roboto', sans-serif;color: white;" ><a href="DashBoardCentral.jsp">Regresar</a></button>

                                    </form>
                                </div>


                            </div>
                        </div>

                    </td>
                </tr>
                <tr>
                    <td colspan="5" style="alignment-adjust: auto;text-align: end;background-color: white;"><label style="font-weight: bold;font-size: 25px;font-family: 'Roboto', sans-serif;color: #58585A;"><strong>Bienvenido: </strong>  <%=nombreUser%></label></td>
                    <td width="80" style="background-color: white;" ></td>
                </tr>

            </tbody>
        </table>

        <div class="form-group" style="text-align:center;background-color: white;" >

            <div style="overflow: scroll;max-height:300px" >
                <table class="table table-striped">
                    <%
                        Consultas tiposervicio = new Consultas();
                        List<TipoServicio> lstTipoServicio = new ArrayList();
                        lstTipoServicio = tiposervicio.allTipoServicio();
                    %>
                    <thead >
                        <tr> 
                    <label style="margin-right: 40px;margin-bottom: 20px;margin-top: 10px;margin-left: 50px;float: left;color: #516179;font-weight: bold;font-size: 22px;font-family: 'Roboto', sans-serif;"><span>Tipos de Servicio</span></label>
                    </tr>
                    <tr>
                        <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Servicio</th>
                        <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Tipo</th>
                        <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Acciones</th>

                    </tr>
                    </thead>
                    <tbody>

                        <%
                            for (TipoServicio tp : lstTipoServicio) {
                        %>
                        <tr>
                            <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=tp.getDescripcion()%></td>
                            <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=tp.getNombre()%></td>
                            <td style="width: 20%;">

                                <!--<button type="button" onclick=""  data-toggle="modal" data-target=".bd-editartipo-modal-lg" style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\editar.PNG" title="Editar"/></button>-->
                                <button type="button" onclick="eliminarTipo('<%=tp.getIdtipo()%>')"   data-toggle="modal" data-target=".bd-eliminartipo-modal-lg"  style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\borrar.PNG" title="Eliminar"/></button>
                            </td>
                        </tr>

                        <%

                            }
                        %>

                    </tbody>
                    <script>
                        function eliminarTipo(p1){
                            document.getElementById("idTipoElim").value = p1;
                        }
                    </script>
                </table>
            </div>
            <div>
                <button type="button"  data-toggle="modal" data-target=".bd-agregartipo-modal-lg"  style="width: 8%;height: 8%;margin-right: 50px;margin-top: 10px;border: none;background-color: white;float: right;"><img style="width: 50%;" src="archivos\uploaded_files\btnagregar.png" title="Agregar  nuevo tipo"/></button>
            </div>
        </div>
        <!-- AGREGAR TIPO -->
        <div class="modal fade bd-agregartipo-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <form action="agregartipo"  method="post" id="formAgregarTipo" >
                    <div class="modal-content">

                        <div style="width: 100%;text-align: center;">
                            <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>AGREGAR NUEVO TIPO DE SERVICIO</strong></h1>
                        </div>


                        <div class="card">
                            <div class="card-body">
                                <div style="float: left;width: 100%;">
                                    <div class="input-group-prepend">
                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Selecciona un servicio</strong></label>
                                    </div>
                                    <script>
                                        function llenaservicio() {
                                            var serv = document.getElementById("slctAgregarServicio").value;
                                            var arrayserv = serv.split("=");
                                            document.getElementById("idservicio").value = arrayserv[0];
                                            document.getElementById("nombreservicio").value = arrayserv[1];


                                        }
                                    </script>
                                    <div>
                                        <%
                                            Consultas serv = new Consultas();
                                            List<Servicio> lstServ = new ArrayList();
                                            lstServ = serv.allServicios();
                                        %>

                                        <select onchange="llenaservicio()" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" required id="slctAgregarServicio" name="slctAgregarServicio" class="custom-select">

                                            <option value="" selected>Selecciona</option>
                                            <%
                                                for (Servicio s : lstServ) {
                                            %>

                                            <option value="<%=s.getId() + "=" + s.getDescripcionServicio()%>" ><%=s.getDescripcionServicio()%></option>
                                            <%

                                                }
                                            %>
                                        </select>

                                    </div> 
                                    <div class="input-group-prepend">
                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre del Tipo</strong></label>
                                    </div>
                                    <div>
                                        <input id="nombreservicio" name="nombreservicio" hidden>
                                        <input id="idservicio" name="idservicio" hidden>
                                        <input id="user" name="user" value="<%=usuario%>" hidden>
                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;"  placeholder="Teclea el nombre del tipo" id="agreTipo" name="agreTipo"  type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">

                                    </div>
                                </div>

                            </div></div>
                        <div class="modal-footer">
                            <button id="btneditserv" type="button" onclick="submit()" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong> GUARDAR CAMBIOS</strong></button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong> CERRAR </strong></button>
                        </div>
                    </div></form>
            </div></div>
                                        
            <!-- ELIMINAR TIPO SERVICIO -->
                                    <div class="modal fade bd-eliminartipo-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                                        <div class="modal-dialog modal-lg modal-dialog-centered">
                                            <form action="eliminartipo"  method="post" id="formEliminarTipo" >
                                                
                                                <input hidden  name="idTipoElim" data-name="idTipoElim" id="idTipoElim" />
                                                <div class="modal-content" >

                                                    <div style="width: 100%;text-align: center;">
                                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>ELIMINAR TIPO DE SERVICIO</strong></h1>
                                                    </div>


                                                    <div class="card">
                                                        <div class="card-body" style="">
                                                            <div >
                                                                <h1 style="font-size: 18px;font-family: 'Roboto', sans-serif;color: gray;"> ¿Estás seguro de eliminar el tipo de servicio seleccionado?</h1>
                                                            </div>

                                                        </div>   
                                                    </div>

                                                    <div class="modal-footer">
                                                        <button id="btnElimTipo" onclick="submit()" type="button" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>CONFIRMAR ELIMINAR</strong></button>
                                                        <button  type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CANCELAR</strong></button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>

                                    </div>
    </body>
</html>
