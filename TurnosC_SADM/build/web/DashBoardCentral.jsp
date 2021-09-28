
<%@page import="com.sadm.turnos.dao.Usuario"%>
<%@page import="com.sadm.turnos.dao.Servicio"%>
<%@page import="com.sadm.turnos.dao.Oficina"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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

        <style>
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: none;
                min-width: 20px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);

                z-index: 1;
                margin-right: 10px;
            }

            .dropdown:hover .dropdown-content {
                display: block;
                margin-right: 10px;
            }
            .desc {

                text-align: center;
                margin-right: 10px;

            }
        </style>
        <style>
            .demo input[type="checkbox"] {
                display: none;
            }
            .demo input[type="checkbox"] + label span {
                display: inline-block;
                width: 15px;
                height: 15px;
                margin: -1px 4px 0 0;
                vertical-align: middle;
                background: url(archivos\\uploaded_files\\checkbox_uncheck.png);
                background-size: cover;
                cursor: pointer;
            }
            .demo input[type="checkbox"]:checked + label span {
                background: url(archivos\\uploaded_files\\checkbox_check.png);
                background-size: cover;
            }
        </style>
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i&display=swap" rel="stylesheet">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> 
        <script>
            $(document).ready(function () {
                $("#myInput").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#myTable tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
                $("#myInput2").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#myTable2 tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
                $("#myInput3").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#myTable3 tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>
    </head>
    <body  >
        <div class="modal fade bd-perfil-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header">
                        <h1> <span class="badge badge-secondary">Perfil Central</span></h1><br>
                    </div>
                    <div class="modal-body">
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group">

                                </div>
                            </div>   
                        </div>
                    </div>
                    <div class="modal-footer">

                        <button  type="button" class="btn btn-primary" style="margin: 20px;">Guardar</button>

                        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="margin: 20px;">Cancelar</button>
                    </div>
                </div>

            </div>

        </div>



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
                            <img src="archivos/uploaded_files/icono_perfil.PNG" alt="Perfil" width="52" height="32" style="margin-top: 10px;">

                            <div class="dropdown-content">
                                <div class="desc">

                                    <!-- <button type="button" class="btn btn-outline-success" data-toggle="modal" data-target=".bd-perfil-modal-lg" target="_blank" >Mi Perfil</button>-->
                                    <form action="cerrarsesion"   method="post" id="formsalir" >

                                        <button type="submit" style="background-color: #668FB7;border-radius: 7px;font-size: 12px;color: white;font-family: 'Roboto', sans-serif;color: white;" data-toggle="modal"><strong>CERRAR SESIÓN</strong></button>

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

                <tr >

                    <td colspan="6" style="alignment-adjust: auto;text-align: center;background-color: white;">
                        <div style="text-align:center;">
                            <!--  <ul class="nav nav-tabs"  role="tablist"> -->
                            <ul  class="nav nav-tabs"  role="tablist">
                                <li style="width: 33%;"  class="nav-item" >
                                    <a class="nav-link active" id="oficina-tab" data-toggle="tab" href="#oficinas" role="tab" aria-controls="home" aria-selected="true"><img style="width: 100%;" src="archivos\uploaded_files\OFICINAS.PNG" title="OFICINAS "/></a>

                                </li>
                                <li style="width: 33%;"  class="nav-item">
                                    <a class="nav-link" id="servicio-tab" data-toggle="tab" href="#servicios" role="tab" aria-controls="home" aria-selected="true"><strong><img style="width: 100%;" src="archivos\uploaded_files\SERVICIOS.PNG" title="SERVICIOS"/></strong></a>
                                </li>
                                <li style="width: 33%;"  class="nav-item">
                                    <a class="nav-link" id="usuario-tab" data-toggle="tab" href="#usuarios" role="tab" aria-controls="home" aria-selected="true"><img style="width: 100%;" src="archivos\uploaded_files\USUARIOS.PNG" title="USUARIOS"/></a>
                                </li>


                            </ul>

                            <div class="tab-content"style="text-align:center;">

                                <!-- OFICINAS -->    

                                <div class="tab-pane active" id="oficinas" role="tabpanel" aria-labelledby="home-tab" style="text-align:center;">


                                    <div class="form-group" style="text-align:center;" >


                                        <div style="overflow: scroll;max-height: 300px;background-color: white;" >
                                            <table class="table table-striped"  >
                                                <%

                                                    Consultas oficinas = new Consultas();
                                                    List<Oficina> lstOficinas = new ArrayList();
                                                    lstOficinas = oficinas.allOficinas();

                                                %>
                                                <thead  >
                                                    <tr> 
                                                <label style="margin-right: 40px;margin-bottom: 20px;margin-top: 10px;margin-left: 50px;float: left;color: #516179;font-weight: bold;font-size: 22px;font-family: 'Roboto', sans-serif;"><span>Filtros</span>
                                                    <input id="myInput" style="border-top: none;border-left: none;border-right: none;border-bottom-color: #90AFCE;width: 500px;color:#A0A0A0;font-size: 14px;font-family: 'Roboto', sans-serif;"   type="search" placeholder="Búsqueda por #Of., nombre, descripción, cd, municipio, ciudad">

                                                    <img style="margin-left: 10px;width: 5%;" src="archivos\uploaded_files\lupa.PNG" title="Buscar"/>
                                                </label>
                                                </tr>
                                                <tr>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">#Of.</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">UniCom</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Nombre</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Descripción</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Dirección</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">CP</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Municipio</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Ciudad</th>

                                                    <th scope="col">Acciones</th>
                                                </tr>
                                                </thead>
                                                <tbody id="myTable">
                                                    <%                                                        
                                                    for (Oficina o : lstOficinas) {
                                                    %>
                                                    <tr>

                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=o.getNum()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=o.getCodUniCom()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=o.getNombre()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=o.getDesc()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=o.getDireccion()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=o.getCp()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=o.getMunicipio()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=o.getCiudad()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;width: 20%;">
                                                            <button type="button" onclick="editarOficina('<%=o.getId()%>', '<%=o.getNum()%>', '<%=o.getNombre()%>', '<%=o.getDesc()%>', '<%=o.getDireccion()%>', '<%=o.getCp()%>', '<%=o.getMunicipio()%>', '<%=o.getTel1()%>', '<%=o.getCiudad()%>', '<%=o.getEmail1()%>', '<%=o.getServicios()%>', '<%=o.getDb_host()%>', '<%=o.getDb_username()%>', '<%=o.getDb_pass()%>', '<%=o.getDb_port()%>', '<%=o.getDb_name()%>')"   data-toggle="modal" data-target=".bd-editaroficina-modal-lg" style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\editar.PNG" title="Editar"/></button>
                                                            <button type="button" onclick="eliminarOficina('<%=o.getId()%>', '<%=o.getNum()%>')" data-toggle="modal" data-target=".bd-eliminaroficina-modal-lg" style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\borrar.PNG" title="Eliminar"/></button>
                                                        </td>
                                                    </tr>
                                                    <%

                                                        }
                                                    %>
                                                </tbody>

                                            </table>
                                            <script>
                                                function eliminarOficina(p1, p2) {

                                                    document.getElementById("txtIdOficina").value = p1;
                                                    document.getElementById("txtNumOficina").value = p2;
                                                }
                                                function editarOficina(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12,p13,p14,p15,p16) {
                                                    document.getElementById("editOfiId").value = p1;
                                                    document.getElementById("editOfiNum").value = p2;
                                                    document.getElementById("editOfiNombre").value = p3;
                                                    document.getElementById("editOfiDesc").value = p4;
                                                    document.getElementById("editOfiDir").value = p5;
                                                    document.getElementById("editOfiCP").value = p6;
                                                    document.getElementById("editOfiMun").value = p7;
                                                    document.getElementById("editOfiTel").value = p8;
                                                    document.getElementById("editOfiCity").value = p9;
                                                    document.getElementById("editOfiEmail").value = p10;
                                                    document.getElementById("editdbHost").value = p12;
                                                    document.getElementById("editdbUserName").value = p13;
                                                    document.getElementById("editdbPass").value = p14;
                                                    document.getElementById("editdbPort").value = p15;
                                                    document.getElementById("editdbName").value = p16;

                                                    var espacio = " ";
                                                    dividirCadena(p11, espacio);

                                                }
                                                function dividirCadena(cadenaADividir, separador) {
                                                    var arrayDeCadenas = cadenaADividir.split(separador);

                                                    for (var i = 0; i < arrayDeCadenas.length; i++) {
                                                        if (null !== document.getElementById("Check" + arrayDeCadenas[i])) {
                                                            document.getElementById("Check" + arrayDeCadenas[i]).checked = 1;
                                                            document.getElementById("serSelec").value = document.getElementById("serSelec").value + arrayDeCadenas[i] + " ";

                                                        }
                                                    }
                                                }
                                            </script>
                                            <div>

                                            </div>

                                        </div><button type="button"  data-toggle="modal" data-target=".bd-agregaroficina-modal-lg" style="width: 8%;height: 8%;margin-right: 50px;margin-top: 10px;border: none;background-color: white;float: right;"><img style="width: 50%;" src="archivos\uploaded_files\btnagregar.png" title="Agregar nueva oficina"/></button>

                                    </div>

                                    <!-- Eliminar Oficina-->

                                    <div class="modal fade bd-eliminaroficina-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                                        <div class="modal-dialog modal-lg modal-dialog-centered">
                                            <form action="eliminaroficina"  method="post" id="formEliminarOficina" >
                                                <input id="txtIdOficina" name="txtIdOficina" hidden>
                                                <input id="txtNumOficina" name="txtNumOficina" hidden>
                                                <input id="txtUserElim" name="txtUserElim" value="<%=usuario%>" hidden>

                                                <div class="modal-content" >

                                                    <div style="width: 100%;text-align: center;">
                                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>ELIMINAR OFICINA</strong></h1><br>
                                                    </div>


                                                    <div class="card">
                                                        <div class="card-body" style="">
                                                            <div >
                                                                <h1 style="font-size: 18px;font-family: 'Roboto', sans-serif;color: gray;"> ¿Estás seguro de eliminar la oficina seleccionada?</h1>
                                                            </div>

                                                        </div>   
                                                    </div>

                                                    <div class="modal-footer">
                                                        <button id="btnElimOfi" onclick="submit()" type="button" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>CONFIRMAR ELIMINAR</strong></button>
                                                        <button  type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CANCELAR</strong></button>
                                                    </div>
                                                </div>


                                            </form>
                                        </div>

                                    </div>

                                    <!-- Agregar Oficina-->

                                    <div class="modal fade bd-agregaroficina-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                                        <div class="modal-dialog modal-lg modal-dialog-centered">

                                            <form action="agregaroficina"  method="post" id="formAgregarOficina" name="formAgregarOficina" >

                                                <input name="user" value="<%=usuario%>" hidden>

                                                <div class="modal-content">

                                                    <div style="width: 100%;text-align: center;">
                                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>AGREGAR NUEVA OFICINA</strong></h1>
                                                    </div>



                                                    <div class="card">
                                                        <div class="card-body">
                                                            <div style="float: left;width: 50%;">
                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Número</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el número" required id="agreOfiNum" name="agreOfiNum" onblur="lengthagreOfiNum()" type="number" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>



                                                                    <script>
                                                                        function lengthagreOfiNum() {
                                                                            if (document.getElementById("agreOfiNum").value === '') {
                                                                                alert("El número es requerido");
                                                                                document.getElementById("btnAgregarOficina").hidden = true;
                                                                            }
                                                                            var agreOfiNum = document.getElementById("agreOfiNum").value;
                                                                            if (null !== agreOfiNum) {
                                                                                if (agreOfiNum === "00") {
                                                                                    alert("El valor mínimo para el Número es 01");
                                                                                    document.getElementById("agreOfiNum").value = "";
                                                                                }
                                                                                if (agreOfiNum.length < 2) {
                                                                                    alert("El valor mínimo para el Número es 01");
                                                                                    document.getElementById("agreOfiNum").value = "";
                                                                                }
                                                                                if (agreOfiNum.length >= 3) {
                                                                                    alert("El valor máximo para el Número es 99");
                                                                                    document.getElementById("agreOfiNum").value = "";
                                                                                }
                                                                            }




                                                                        }
                                                                    </script>
                                                                </div><br>
                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" onblur="valAgreOfNombre()" placeholder="Teclea el nombre" id="agreOfiNombre"  name="agreOfiNombre" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                        <script>
                                                                            function valAgreOfNombre() {
                                                                                if (document.getElementById("agreOfiNombre").value === '') {
                                                                                    alert("El nombre es requerido");
                                                                                    document.getElementById("btnAgregarOficina").hidden = true;
                                                                                } else {

                                                                                    document.getElementById("btnAgregarOficina").hidden = false;
                                                                                }
                                                                            }
                                                                        </script>
                                                                    </div><br>

                                                                </div><br>
                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Descripción</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea la descripción"  name="agreOfiDesc" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Dirección</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea la dirección" name="agreOfiDir" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Código Postal</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el código postal" onblur="lengthagreOfiCP()" id="agreOfiCP" name="agreOfiCP" type="number" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                        <script>
                                                                            function lengthagreOfiCP() {
                                                                                var agreOfiCP = document.getElementById("agreOfiCP").value;
                                                                                if (null !== agreOfiCP) {
                                                                                    if (agreOfiCP === "00000") {
                                                                                        alert("El valor mínimo para el CP es 00001");
                                                                                        document.getElementById("agreOfiCP").value = "";
                                                                                    }
                                                                                    if (agreOfiCP.length < 5) {
                                                                                        alert("El valor mínimo para el CP es 00001");
                                                                                        document.getElementById("agreOfiCP").value = "";
                                                                                    }
                                                                                    if (agreOfiCP.length > 5) {
                                                                                        alert("El valor máximo para el CP es 99999");
                                                                                        document.getElementById("agreOfiCP").value = "";
                                                                                    }
                                                                                }

                                                                            }
                                                                        </script>
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Municipio</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el municipio" name="agreOfiMun" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div>

                                                                </div>
                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Teléfono</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input  style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el teléfono" name="agreOfiTel" id="agreOfiTel" onblur="lengthagreOfiTel()" type="number" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                        <script>
                                                                            function lengthagreOfiTel() {
                                                                                var agreOfiTel = document.getElementById("agreOfiTel").value;
                                                                                if (null !== agreOfiTel) {
                                                                                    if (agreOfiTel === "0000000000") {
                                                                                        alert("El valor mínimo para el Teléfono es 0000000001");
                                                                                        document.getElementById("agreOfiTel").value = "";
                                                                                    }
                                                                                    if (agreOfiTel.length < 10) {
                                                                                        alert("El valor mínimo para el Teléfono es de 10 dígitos");
                                                                                        document.getElementById("agreOfiTel").value = "";
                                                                                    }
                                                                                    if (agreOfiTel.length > 10) {
                                                                                        alert("El valor máximo para el Teléfono es de 10 dígitos");
                                                                                        document.getElementById("agreOfiTel").value = "";
                                                                                    }
                                                                                }

                                                                            }
                                                                        </script>
                                                                    </div>

                                                                </div><br>
                                                                <div class="input-group-prepend">
                                                                    <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Asignar servicios</strong></label>
                                                                </div>
                                                                <div>
                                                                    <%
                                                                        Consultas servicios = new Consultas();
                                                                        List<Servicio> lstSer = new ArrayList();
                                                                        lstSer = servicios.serviciosActivos();
                                                                        for (Servicio s : lstSer) {
                                                                    %>
                                                                    <div name="tratamiento" class="demo" style="float: left;">
                                                                        <input onclick="tomarValorChk('<%=s.getDescripcionServicio()%>')"   type="checkbox" id="Chk<%=s.getDescripcionServicio()%>">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 14px;margin-left: 70px;margin-right:70px" for="Chk<%=s.getDescripcionServicio()%>"><span></span><%=s.getDescripcionServicio()%></label>
                                                                    </div>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </div>
                                                                <input type="text"  id="agreOfiServ" name="agreOfiServ" hidden >
                                                            </div>   
                                                            <div style="float: right;width: 50%;">
                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>UniCom</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el id unicom" required id="agreUniCom" name="agreUniCom" onblur="lengthagreUnicom()" type="number" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>



                                                                    <script>
                                                                        function lengthagreUnicom() {
                                                                            if (document.getElementById("agreUniCom").value === '') {
                                                                                alert("El UniCom es requerido");
                                                                                document.getElementById("btnAgregarOficina").hidden = true;
                                                                            }
                                                                            var agreOfiNum = document.getElementById("agreUniCom").value;
                                                                            if (null !== agreOfiNum) {
                                                                                if (agreOfiNum === "0000") {
                                                                                    alert("El valor mínimo para el UniCom es 0001");
                                                                                    document.getElementById("agreUniCom").value = "";
                                                                                }
                                                                                if (agreOfiNum.length < 4) {
                                                                                    alert("El valor mínimo para el UniCom es 0001");
                                                                                    document.getElementById("agreUniCom").value = "";
                                                                                }
                                                                                if (agreOfiNum.length > 4) {
                                                                                    alert("El valor máximo para el UniCom es 9999");
                                                                                    document.getElementById("agreUniCom").value = "";
                                                                                }
                                                                            }




                                                                        }
                                                                    </script>
                                                                </div><br>
                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Ciudad</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea la ciudad" name="agreOfiCity" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Correo electrónico</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el correo electrónico" name="agreOfiEmail" type="email" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Usuario de conexión a DB</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el usuario para conexión a DB de sucursal" name="dbUserName" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Password del usuario de la conexión a DB</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el password correspondiente al usuario" name="dbPass" type="password" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Ip del Host donde se hospeda la DB de la sucursal</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea la IP correspondiente Host de la DB" name="dbHost" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Puerto de acceso a la DB de la sucursal</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el puerto correspondiente de la DB en sucursal" name="dbPort" type="number" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre de la DB de la sucursal</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el nombre de la DB en sucursal" name="dbName" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>


                                                                <br>

                                                                <script>
                                                                    function tomarValorChk(p1) {

                                                                        if (document.getElementById("Chk" + p1).checked) {
                                                                            document.getElementById("agreOfiServ").value = document.getElementById("agreOfiServ").value + p1 + " ";
                                                                        } else {
                                                                            var chkfalse = document.getElementById("agreOfiServ").value;
                                                                            chkfalse = chkfalse.replace(p1 + " ", "");
                                                                            document.getElementById("agreOfiServ").value = chkfalse;
                                                                        }

                                                                    }
                                                                </script></div>

                                                        </div> 
                                                        <div class="modal-footer">
                                                            <button hidden id="btnAgregarOficina" type="button" onclick="submit()" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>CREAR OFICINA</strong></button>
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;" ><strong>CERRAR</strong></button>
                                                        </div></div></div>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- Editar Oficina-->

                                    <div class="modal fade bd-editaroficina-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                                        <div class="modal-dialog modal-lg modal-dialog-centered">

                                            <form action="editaroficina"  method="post" id="formEditarOficina" name="formEditarOficina"  >

                                                <input name="user" value="<%=usuario%>" hidden>
                                                <input id="editOfiId" name="editOfiId"  hidden>
                                                <div class="modal-content" onclick="valbtnNombre()">

                                                    <div style="width: 100%;text-align: center;">
                                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>EDITAR OFICINA</strong></h1>
                                                    </div>

                                                    <div class="card">

                                                        <div class="card-body">
                                                            <div style="float: left;width: 50%;">

                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Número</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" readonly="" id="editOfiNum" name="editOfiNum"  type="number" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input placeholder="Teclea el nombre" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;"  id="editOfiNombre" name="editOfiNombre" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                        <script>
                                                                            function valbtnNombre() {
                                                                                if (document.getElementById("editOfiNombre").value === '') {
                                                                                    document.getElementById("btnEditarOficina").hidden = true;
                                                                                    alert("El nombre es requerido");
                                                                                } else {
                                                                                    document.getElementById("btnEditarOficina").hidden = false;
                                                                                }
                                                                            }
                                                                        </script> 

                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Descripción</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%"> 
                                                                        <input placeholder="Teclea la descripción" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="editOfiDesc" name="editOfiDesc" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Dirección</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input placeholder="Teclea la dirección" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="editOfiDir" name="editOfiDir" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Código Postal</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input placeholder="Teclea el código postal" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" onblur="lengtheditOfiCP()" id="editOfiCP" name="editOfiCP" type="number" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                        <script>
                                                                            function lengtheditOfiCP() {
                                                                                var editOfiCP = document.getElementById("editOfiCP").value;
                                                                                if (null !== editOfiCP) {
                                                                                    if (editOfiCP === "00000") {
                                                                                        alert("El valor mínimo para el CP es 00001");
                                                                                        document.getElementById("editOfiCP").value = "";
                                                                                    }
                                                                                    if (editOfiCP.length < 5) {
                                                                                        alert("El valor mínimo para el CP es 00001");
                                                                                        document.getElementById("editOfiCP").value = "";
                                                                                    }
                                                                                    if (editOfiCP.length > 5) {
                                                                                        alert("El valor máximo para el CP es 99999");
                                                                                        document.getElementById("editOfiCP").value = "";
                                                                                    }
                                                                                }

                                                                            }
                                                                        </script>
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Municipio</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input placeholder="Teclea el municipio" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="editOfiMun" name="editOfiMun" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div>

                                                                </div>
                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Teléfono</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input placeholder="Teclea el teléfono" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" name="editOfiTel" id="editOfiTel" onblur="lengtheditOfiTel()" type="number" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                        <script>
                                                                            function lengtheditOfiTel() {
                                                                                var editOfiTel = document.getElementById("editOfiTel").value;
                                                                                if (null !== editOfiTel) {
                                                                                    if (editOfiTel === "0000000000") {
                                                                                        alert("El valor mínimo para el Teléfono es 0000000001");
                                                                                        document.getElementById("editOfiTel").value = "";
                                                                                    }
                                                                                    if (editOfiTel.length < 10) {
                                                                                        alert("El valor mínimo para el Teléfono es de 10 dígitos");
                                                                                        document.getElementById("editOfiTel").value = "";
                                                                                    }
                                                                                    if (editOfiTel.length > 10) {
                                                                                        alert("El valor máximo para el Teléfono es de 10 dígitos");
                                                                                        document.getElementById("editOfiTel").value = "";
                                                                                    }
                                                                                }

                                                                            }
                                                                        </script>  </div>

                                                                </div><br>
                                                                <div class="input-group-prepend">
                                                                    <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Servicios Asignados </strong></label>
                                                                </div>
                                                                <input type="text"  id="serSelec" name="editOfiServ" hidden>
                                                                <div>
                                                                    <%
                                                                        Consultas servici = new Consultas();
                                                                        List<Servicio> lstSe = new ArrayList();
                                                                        lstSe = servici.serviciosActivos(); //ServActVent

                                                                        for (Servicio se : lstSe) {

                                                                    %>
                                                                    <div  class="demo" style="float: left;">
                                                                        <input onclick="tomValorChk('<%=se.getDescripcionServicio()%>')"   style="border-color: #58585A;margin-left: 50px;margin-right:50px;" type="checkbox" id="Check<%=se.getDescripcionServicio()%>">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 14px;margin-left: 70px;margin-right:70px"  for="Check<%=se.getDescripcionServicio()%>"><span></span><%=se.getDescripcionServicio()%></label>
                                                                    </div>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>
                                                            <div style="float: right;width: 50%;">



                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Ciudad</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input placeholder="Teclea la ciudad" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="editOfiCity" id="editOfiCity" name="editOfiCity" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Correo electrónico</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input placeholder="Teclea el correo electrónico" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="editOfiEmail" name="editOfiEmail" type="email" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div>
                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Usuario de conexión a DB</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el usuario para conexión a DB de sucursal" id="editdbUserName" name="editdbUserName" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Password del usuario de la conexión a DB</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el password correspondiente al usuario" id="editdbPass" name="editdbPass" type="password" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Ip del Host donde se hospeda la DB de la sucursal</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea la IP correspondiente Host de la DB" id="editdbHost" name="editdbHost" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Puerto de acceso a la DB de la sucursal</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el puerto correspondiente de la DB en sucursal" id="editdbPort" name="editdbPort" type="number" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>

                                                                <div class="input-group input-group-lg">

                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre de la DB de la sucursal</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el nombre de la DB en sucursal" id="editdbName" name="editdbName" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div><br>

                                                                </div><br>



                                                                <script>
                                                                    function tomValorChk(p1) {

                                                                        if (document.getElementById("Check" + p1).checked) {
                                                                            document.getElementById("serSelec").value = document.getElementById("serSelec").value + p1 + " ";
                                                                        } else {
                                                                            var chkfalse = document.getElementById("serSelec").value;
                                                                            chkfalse = chkfalse.replace(p1 + " ", "");
                                                                            document.getElementById("serSelec").value = chkfalse;
                                                                        }





                                                                    }
                                                                </script></div></div>
                                                        <div class="modal-footer">
                                                            <button hidden id="btnEditarOficina" type="button" onclick="submit()" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>GUARDAR CAMBIOS</strong></button>
                                                            <button type="button" onclick="deseleccionar_chk()"  class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong> CERRAR</strong></button>
                                                            <script>
                                                                function deseleccionar_chk() {

                                                                    for (i = 0; i < document.formEditarOficina.elements.length; i++) {
                                                                        if (document.formEditarOficina.elements[i].type === "checkbox") {
                                                                            document.formEditarOficina.elements[i].checked = 0;

                                                                        }
                                                                        document.getElementById("serSelec").value = "";
                                                                    }
                                                                }
                                                            </script>

                                                        </div>
                                                    </div></div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- SERVICIOS -->               

                                <div class="tab-pane" id="servicios" role="tabpanel" aria-labelledby="home-tab" style="text-align:center;">

                                    <div class="form-group" style="text-align:center;background-color: white;" >

                                        <div style="overflow: scroll;max-height:300px" >
                                            <table class="table table-striped">
                                                <%
                                                    Consultas serv = new Consultas();
                                                    List<Servicio> lstServ = new ArrayList();
                                                    lstServ = serv.allServicios();
                                                %>
                                                <thead >
                                                    <tr> 
                                                <label style="margin-right: 40px;margin-bottom: 20px;margin-top: 10px;margin-left: 50px;float: left;color: #516179;font-weight: bold;font-size: 22px;font-family: 'Roboto', sans-serif;"><span>Filtros</span>
                                                    <input id="myInput2" style="border-top: none;border-left: none;border-right: none;border-bottom-color: #90AFCE;width: 500px;color:#A0A0A0;font-size: 14px;font-family: 'Roboto', sans-serif;"   type="search" placeholder="Búsqueda por nombre, creado por, estatus,  color, fecha">

                                                    <img style="margin-left: 10px;width: 5%;" src="archivos\uploaded_files\lupa.PNG" title="Buscar"/>
                                                </label>
                                                </tr>
                                                <tr>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Nombre</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Creado por</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Estatus</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Color</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Fecha de Creación</th>
                                                    <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Acciones</th>
                                                </tr>
                                                </thead >
                                                <tbody id="myTable2">
                                                    <%
                                                        for (Servicio s : lstServ) {

                                                    %>
                                                    <tr>

                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=s.getDescripcionServicio()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=s.getUserLastUpdate()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=s.getEstatus()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><input readonly="" style="background: <%=s.getColor()%>;width: 30px;"   ></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=s.getFechaLastUpdate()%></td>
                                                        <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;width: 20%;">
                                                            <button type="button" onclick="" style="width: 20%;height: 20%;border: none;background-color: lightskyblue;"><a href="TipoServicio.jsp">Tipos</a></button>
                                                            <button type="button" onclick="editarServicio('<%=s.getId()%>', '<%=s.getDescripcionServicio()%>', '<%=s.getEstatus()%>', '<%=s.getColor()%>','<%=s.getPrefijo()%>')"  data-toggle="modal" data-target=".bd-editarservicio-modal-lg" style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\editar.PNG" title="Editar"/></button>
                                                            <button type="button" onclick="eliminarServicio('<%=s.getDescripcionServicio()%>')" data-toggle="modal" data-target=".bd-eliminarservicio-modal-lg" style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\borrar.PNG" title="Eliminar"/></button>
                                                        </td>
                                                    </tr>
                                                    <%

                                                        }
                                                    %>
                                                </tbody>

                                            </table>
                                            <script>
                                                function eliminarServicio(p1) {
                                                    document.getElementById("txtNombreServElim").value = p1;

                                                }
                                                function editarServicio(p1, p2, p3, p4,p5) {

                                                    document.getElementById("editServId").value = p1;
                                                    document.getElementById("editServNombre").value = p2;
                                                    document.getElementById("txtEditarSEstatus").value = p3;
                                                    document.getElementById("colorselectorE").value = p4;
                                                    document.getElementById("colorservedit").value = p4;
                                                    document.getElementById("editServPrefijo").value = p5;

                                                }

                                            </script>
                                        </div> <button type="button" onclick="document.getElementById('colorservagre').value = '#ffffff';" data-toggle="modal" data-target=".bd-agregarservicio-modal-lg" style="width: 8%;height: 8%;margin-right: 50px;margin-top: 10px;border: none;background-color: white;float: right;"><img style="width: 50%;" src="archivos\uploaded_files\btnagregar.png" title="Agregar nuevo servicio"/></button></div>
                                    <!-- Eliminar Servicio-->

                                    <div class="modal fade bd-eliminarservicio-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                                        <div class="modal-dialog modal-lg modal-dialog-centered">
                                            <form action="eliminarservicio"  method="post" id="formEliminarServicio" >
                                                <input id="txtNombreServElim" name="txtNombreServElim" hidden>

                                                <input id="txtUserElimServ" name="txtUserElimServ" value="<%=usuario%>" hidden>
                                                <div class="modal-content" >

                                                    <div style="width: 100%;text-align: center;">
                                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>ELIMINAR SERVICIO</strong></h1>
                                                    </div>


                                                    <div class="card">
                                                        <div class="card-body" style="">
                                                            <div >
                                                                <h1 style="font-size: 18px;font-family: 'Roboto', sans-serif;color: gray;"> ¿Estás seguro de eliminar el servicio seleccionado?</h1>
                                                            </div>

                                                        </div>   
                                                    </div>

                                                    <div class="modal-footer">
                                                        <button id="btnElimServ" onclick="submit()" type="button" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>CONFIRMAR ELIMINAR</strong></button>
                                                        <button  type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CANCELAR</strong></button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>

                                    </div>

                                    <!-- Agregar Servicio-->

                                    <div class="modal fade bd-agregarservicio-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                                        <div class="modal-dialog modal-lg modal-dialog-centered">

                                            <form action="agregarservicio"  method="post" id="formAgregarServicio" name="formAgregarServicio" >

                                                <input name="user" value="<%=usuario%>" hidden>

                                                <div class="modal-content" >

                                                    <div style="width: 100%;text-align: center;">
                                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>AGREGAR NUEVO SERVICIO</strong></h1>
                                                    </div>



                                                    <div class="card">
                                                        <div class="card-body">

                                                            <div class="input-group input-group-lg" style="width: 100%;">
                                                                <div style="width: 55%;"> 
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;"  placeholder="Teclea el nombre" id="agreServNombre" name="agreServNombre" onblur="validarNombreServicio()" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div></div>
                                                                <div style="width: 55%;"> 
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Prefijo</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;"  placeholder="Teclea el prefijo"  id="agreServPrefijo" name="agreServPrefijo" type="text" maxlength="3" onkeyup="javascript:this.value=this.value.toUpperCase();" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div></div>
                                                               
                                                                <div style="width: 45%" >
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Color</strong></label>
                                                                    </div>
                                                                    <div style="width: 50%;">
                                                                        <div  style="width: 90%;float: left;">
                                                                            <input disabled  id="colorservagre"  type="color" style="width: 50px;height: 40px;" >
                                                                            <script>
                                                                                function selectColor() {
                                                                                    document.getElementById("colorservagre").value = document.getElementById("colorselectorA").value;

                                                                                    if (document.getElementById("colorselectorA").value === '#ffffff') {
                                                                                        alert("Debes seleccionar un color para el servicio");
                                                                                    } else {
                                                                                        if (document.getElementById("agreServNombre").value === '') {
                                                                                            alert("El nombre es requerido");
                                                                                        } else {
                                                                                            document.getElementById("btncrearserv").hidden = false;
                                                                                        }

                                                                                    }
                                                                                }
                                                                            </script>
                                                                        </div>
                                                                        <div style="width: 10%;float: right;">
                                                                            <select style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" onchange="selectColor()" id="colorselectorA" name="colorselectorA" class="custom-select" > 

                                                                                <option value = "#668FB7" style="background-color:#668FB7;color: black; " ></option> 
                                                                                <option value = "#92BE13" style="background-color:#92BE13;color: black; " ></option> 
                                                                                <option value = "#006EB2" style="background-color:#006EB2;color: black; " ></option> 
                                                                                <option value = "#90AFCE" style="background-color:#90AFCE;color: black; " ></option> 
                                                                                <option value = "#7C3E85" style="background-color:#7C3E85;color: black; " ></option> 
                                                                                <option value = "#02B3BE" style="background-color:#02B3BE;color: black;" ></option> 
                                                                                <option value = "#1AAAE3" style="background-color:#1AAAE3;color: black;" ></option> 
                                                                                <option value = "#C84490" style="background-color:#C84490;color: black;" ></option> 
                                                                                <option value = "#F6610E" style="background-color:#F6610E;color: black;" ></option>
                                                                            </select>  
                                                                        </div>

                                                                    </div >
                                                                </div> 
                                                            </div>
                                                            <div style="width: 30%" >

                                                                <div>
                                                                    <select hidden  id="txtAgregarSEstatus" name="txtAgregarSEstatus" class="custom-select">

                                                                        <option value="1">Activo</option>
                                                                        <option value="0">Inactivo</option>
                                                                    </select>
                                                                </div><br>

                                                                <div class="input-group-prepend">
                                                                    <div  class="demo" style="float: left;">
                                                                        <input checked onclick="valChk1();"  style="border-color: #58585A;" type="checkbox"  id="CheckVal1" >
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 14px;" for="CheckVal1"><span></span><strong>Activo</strong></label>
                                                                    </div>
                                                                    <script>
                                                                        function valChk1() {
                                                                            if (document.getElementById('CheckVal1').checked) {
                                                                                document.getElementById('txtAgregarSEstatus').value = "1";
                                                                            } else {
                                                                                document.getElementById("txtAgregarSEstatus").value = "0";

                                                                            }

                                                                        }
                                                                    </script>
                                                                </div>

                                                            </div><br>
                                                            <script>
                                                                function validarNombreServicio() {
                                                                    var agreServiNombre = document.getElementById("agreServNombre").value;


                                                                    agreServiNombre = getCleanedString(agreServiNombre);
                                                                    document.getElementById("agreServNombre").value = agreServiNombre;

                                                                    if (agreServiNombre === '') {
                                                                        alert('El nombre es requerido');
                                                                    } else {
                                                                        if (document.getElementById("colorselectorA").value === '#ffffff') {

                                                                        } else {
                                                                            document.getElementById("btncrearserv").hidden = false;
                                                                        }
                                                                    }
                                                                }

                                                                function getCleanedString(cadena) {
                                                                    // Definimos los caracteres que queremos eliminar
                                                                    var specialChars = "!@#$^&%*()+=-[]\{}|:<>?,.´";

                                                                    // Los eliminamos todos
                                                                    for (var i = 0; i < specialChars.length; i++) {
                                                                        cadena = cadena.replace(new RegExp("\\" + specialChars[i], 'gi'), '');
                                                                    }

                                                                    // Quitamos espacios y los sustituimos por _ porque nos gusta mas asi
                                                                    cadena = cadena.replace(/ /g, "_");
                                                                    cadena = cadena.replace(/"/g, "");

                                                                    // Quitamos acentos y "ñ". Fijate en que va sin comillas el primer parametro
                                                                    cadena = cadena.replace(/á/gi, "a");
                                                                    cadena = cadena.replace(/é/gi, "e");
                                                                    cadena = cadena.replace(/í/gi, "i");
                                                                    cadena = cadena.replace(/ó/gi, "o");
                                                                    cadena = cadena.replace(/ú/gi, "u");
                                                                    cadena = cadena.replace(/ñ/gi, "n");
                                                                    return cadena;
                                                                }
                                                            </script>
                                                        </div>

                                                    </div>

                                                    <div class="modal-footer">
                                                        <button hidden type="button" id="btncrearserv" onclick="submit()" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong> CREAR SERVICIO</strong></button>
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong> CERRAR</strong></button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- Editar Servicio-->

                                    <div class="modal fade bd-editarservicio-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                                        <div class="modal-dialog modal-lg modal-dialog-centered">

                                            <form action="editarservicio"  method="post" id="formEditarServicio" name="formEditarServicio" >
                                                <input id="editServId" name="editServId" hidden>
                                                <input name="user" value="<%=usuario%>" hidden>

                                                <div class="modal-content">

                                                    <div style="width: 100%;text-align: center;">
                                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>EDITAR SERVICIO</strong></h1>

                                                    </div>

                                                    <div class="card">
                                                        <div class="card-body">

                                                            <div class="input-group input-group-lg" style="width: 100%;">
                                                                <div style="width: 50%;"> 
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" readonly placeholder="Teclea el nombre" id="editServNombre" name="editServNombre" onblur="validarNombreServicioEditar()" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div></div>
                                                                <div style="width: 55%;"> 
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Prefijo</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;"  placeholder="Teclea el prefijo"  id="editServPrefijo" name="editServPrefijo" type="text" maxlength="3" onkeyup="javascript:this.value=this.value.toUpperCase();" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div></div>
                                                                <div style="width: 50%" >
                                                                    <div class="input-group-prepend">
                                                                        <label  style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Color</strong></label>
                                                                    </div>
                                                                    <div style="width: 50%;">
                                                                        <div  style="width: 70%;float: left;">
                                                                            <input disabled id="colorservedit"  type="color" style="width: 50px;height: 40px;"  >
                                                                            <script>
                                                                                function selectColorE() {
                                                                                    document.getElementById("colorservedit").value = document.getElementById("colorselectorE").value;

                                                                                    if (document.getElementById("colorselectorE").value === '#ffffff') {
                                                                                        alert("Debes seleccionar un color para el servicio");
                                                                                    } else {
                                                                                        document.getElementById("btneditserv").hidden = false;
                                                                                    }
                                                                                }
                                                                            </script>
                                                                        </div>
                                                                        <div style="width: 20%;float: right;">
                                                                            <select style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" onchange="selectColorE()" id="colorselectorE" name="colorselectorE" class="custom-select" > 

                                                                                <option value = "#668FB7" style="background-color:#668FB7;color: black; " ></option> 
                                                                                <option value = "#92BE13" style="background-color:#92BE13;color: black; " ></option> 
                                                                                <option value = "#006EB2" style="background-color:#006EB2;color: black; " ></option> 
                                                                                <option value = "#90AFCE" style="background-color:#90AFCE;color: black; " ></option> 
                                                                                <option value = "#7C3E85" style="background-color:#7C3E85;color: black; " ></option> 
                                                                                <option value = "#02B3BE" style="background-color:#02B3BE;color: black;" ></option> 
                                                                                <option value = "#1AAAE3" style="background-color:#1AAAE3;color: black;" ></option> 
                                                                                <option value = "#C84490" style="background-color:#C84490;color: black;" ></option> 
                                                                                <option value = "#F6610E" style="background-color:#F6610E;color: black;" ></option>
                                                                            </select>  
                                                                        </div>

                                                                    </div >
                                                                </div> 
                                                            </div>
                                                            <div style="width: 20%" >

                                                                <div>
                                                                    <select hidden  id="txtEditarSEstatus" name="txtEditarSEstatus" class="custom-select">

                                                                        <option value="1">Activo</option>
                                                                        <option value="0">Inactivo</option>
                                                                    </select>
                                                                </div><br>

                                                                <div class="input-group-prepend">
                                                                    <div  class="demo" style="float: left;">
                                                                        <input checked onclick="valChk2();"  style="border-color: #58585A;" type="checkbox"  id="CheckVal2" >
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 14px;"  for="CheckVal2"><span></span><strong>Activo</strong></label>
                                                                    </div>
                                                                    <script>
                                                                        function valChk2() {
                                                                            if (document.getElementById('CheckVal2').checked) {
                                                                                document.getElementById('txtEditarSEstatus').value = "1";
                                                                            } else {
                                                                                document.getElementById("txtEditarSEstatus").value = "0";
                                                                            }

                                                                        }
                                                                    </script>
                                                                </div>

                                                            </div>
                                                            <script>
                                                                function validarNombreServicioEditar() {
                                                                    var editServiNombre = document.getElementById("editServNombre").value;
                                                                    if (editServiNombre === '') {
                                                                        alert("El nombre es requerido");
                                                                    }

                                                                    editServiNombre = getCleanedString(editServiNombre);
                                                                    document.getElementById("editServNombre").value = editServiNombre;


                                                                }

                                                                function getCleanedString(cadena) {
                                                                    // Definimos los caracteres que queremos eliminar
                                                                    var specialChars = "!@#$^&%*()+=-[]{}|:<>?,.´";

                                                                    // Los eliminamos todos
                                                                    for (var i = 0; i < specialChars.length; i++) {
                                                                        cadena = cadena.replace(new RegExp("\\" + specialChars[i], 'gi'), '');
                                                                    }

                                                                    // Quitamos espacios y los sustituimos por _ porque nos gusta mas asi
                                                                    cadena = cadena.replace(/ /g, "_");
                                                                    cadena = cadena.replace(/"/g, "");

                                                                    // Quitamos acentos y "ñ". Fijate en que va sin comillas el primer parametro
                                                                    cadena = cadena.replace(/á/gi, "a");
                                                                    cadena = cadena.replace(/é/gi, "e");
                                                                    cadena = cadena.replace(/í/gi, "i");
                                                                    cadena = cadena.replace(/ó/gi, "o");
                                                                    cadena = cadena.replace(/ú/gi, "u");
                                                                    cadena = cadena.replace(/ñ/gi, "n");
                                                                    return cadena;
                                                                }
                                                            </script>
                                                        </div>
                                                    </div> 
                                                    <div class="modal-footer">
                                                        <button hidden id="btneditserv" type="button" onclick="submit()" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong> GUARDAR CAMBIOS</strong></button>
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong> CERRAR </strong></button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- USUARIOS -->               

                                <div class="tab-pane" name="alta" id="usuarios" role="tabpanel" aria-labelledby="profile-tab" >

                                    <div class="form-group" style="text-align:center;background-color: white;" >

                                        <div style="overflow: scroll;max-height: 300px;background-color: white;" >
                                            <div style="max-height:300px" >
                                                <table class="table table-striped">
                                                    <%
                                                        Consultas usuarios = new Consultas();
                                                        List<Usuario> lstUsuarios = new ArrayList();
                                                        lstUsuarios = usuarios.allUsuariosAdmin();
                                                    %>
                                                    <thead >
                                                        <tr> 
                                                    <label style="margin-right: 40px;margin-bottom: 20px;margin-top: 10px;margin-left: 50px;float: left;color: #516179;font-weight: bold;font-size: 22px;font-family: 'Roboto', sans-serif;"><span>Filtros</span>
                                                        <input id="myInput3" style="border-top: none;border-left: none;border-right: none;border-bottom-color: #90AFCE;width: 500px;color:#A0A0A0;font-size: 14px;font-family: 'Roboto', sans-serif;"   type="search" placeholder="Búsqueda por usuario, nombre, email, perfil, estatus, fecha">

                                                        <img style="margin-left: 10px;width: 5%;" src="archivos\uploaded_files\lupa.PNG" title="Buscar"/>
                                                    </label>
                                                    </tr>
                                                    <tr>
                                                        <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Usuario</th>
                                                        <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Nombre</th>
                                                        <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Email</th>
                                                        <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" ="col">Perfil</th>
                                                        <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Estatus</th>
                                                        <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;" scope="col">Fecha creación</th>
                                                        <th style="color: #58585A;font-weight: bold;font-size: 16px;font-family: 'Roboto', sans-serif;"scope="col">Acciones</th>
                                                    </tr>
                                                    </thead >
                                                    <tbody id="myTable3">
                                                        <%
                                                            for (Usuario u : lstUsuarios) {
                                                                String perfil = new String();
                                                                int p = Integer.parseInt(u.getIdRol());
                                                                switch (p) {
                                                                    case 1:
                                                                        perfil = "Admin Of. Central";
                                                                        break;
                                                                    case 2:
                                                                        perfil = "Admin Oficina";
                                                                        break;

                                                                }
                                                                String estatus = new String();
                                                                int e = Integer.parseInt(u.getEstatus());
                                                                switch (e) {
                                                                    case 0:
                                                                        estatus = "Inactivo";
                                                                        break;
                                                                    case 1:
                                                                        estatus = "Activo";
                                                                        break;
                                                                }
                                                        %>

                                                        <tr>

                                                            <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=u.getUsuario()%></td>
                                                            <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=u.getNombre()%></td>
                                                            <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=u.getEmail()%></td>
                                                            <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=perfil%></td>
                                                            <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=estatus%></td>
                                                            <td style="color: #A0A0A0;font-weight: bold;font-size: 14px;font-family: 'Roboto', sans-serif;"><%=u.getFecha()%></td>
                                                            <td style="width: 20%;">

                                                                <button type="button" onclick="editarUsu('<%=u.getId()%>', '<%=u.getNombre()%>', '<%=u.getPassword()%>', '<%=u.getEstatus()%>', '<%=u.getUsuario()%>', '<%=u.getEmail()%>', '<%=u.getIdRol()%>', '<%=u.getEstatus()%>', '<%=u.getOficina()%>');"  data-toggle="modal" data-target=".bd-editaruser-modal-lg" style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\editar.PNG" title="Editar"/></button>
                                                                <button type="button" onclick="eliminarUsu('<%=u.getId()%>');"   data-toggle="modal" data-target=".bd-eliminaruser-modal-lg"  style="width: 20%;height: 20%;border: none;background-color: none;"><img style="width: 100%;height: 100%" src="archivos\uploaded_files\borrar.PNG" title="Eliminar"/></button>
                                                            </td>
                                                        </tr>
                                                        <%}%>
                                                    </tbody>
                                                    <script>
                                                        function eliminarUsu(p1) {
                                                            document.getElementById("idUsElim").value = p1;
                                                        }

                                                        function editarUsu(p1, p2, p3, p4, p5, p6, p7, p8, p9) {

                                                            document.getElementById("txtEditarUId").value = p1;
                                                            document.getElementById("txtEditarUNombre").value = p2;
                                                            document.getElementById("txtEditarUPass").value = p3;
                                                            document.getElementById("txtEditarUEstatus").value = p4;
                                                            document.getElementById("txtEditarUUsu").value = p5;
                                                            document.getElementById("txtEditarUEmail").value = p6;
                                                            document.getElementById("txtEditarUEPerfil").value = p7;
                                                            document.getElementById("txtEditarUEstatus").value = p8;
                                                            document.getElementById("CheckVal4").value = p8;
                                                            document.getElementById("txtEditarUOfi").value = p9;



                                                        }
                                                    </script>

                                                </table></div>
                                        </div>
                                        <div>
                                            <button type="button"  data-toggle="modal" data-target=".bd-agregaruser-modal-lg"  style="width: 8%;height: 8%;margin-right: 50px;margin-top: 10px;border: none;background-color: white;float: right;"><img style="width: 50%;" src="archivos\uploaded_files\btnagregar.png" title="Agregar  nuevo usuario"/></button>
                                        </div>
                                    </div>
                                    <!-- ELIMINAR USUARIO -->
                                    <div class="modal fade bd-eliminaruser-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                                        <div class="modal-dialog modal-lg modal-dialog-centered">
                                            <form action="eliminarusuario"  method="post" id="formEliminarUsuario" >
                                                <input value="<%=usuario%>" name="userelim" data-name="userelim" id="userelim" hidden/>
                                                <input   name="idUsElim" data-name="idUsElim" id="idUsElim" hidden/>
                                                <div class="modal-content" >

                                                    <div style="width: 100%;text-align: center;">
                                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>ELIMINAR USUARIO</strong></h1>
                                                    </div>


                                                    <div class="card">
                                                        <div class="card-body" style="">
                                                            <div >
                                                                <h1 style="font-size: 18px;font-family: 'Roboto', sans-serif;color: gray;"> ¿Estás seguro de eliminar el usuario seleccionado?</h1>
                                                            </div>

                                                        </div>   
                                                    </div>

                                                    <div class="modal-footer">
                                                        <button id="btnElimVent" onclick="submit()" type="button" class="btn btn-primary" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>CONFIRMAR ELIMINAR</strong></button>
                                                        <button  type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CANCELAR</strong></button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>

                                    </div>

                                    <!-- AGREGAR USUARIO -->
                                    <div class="modal fade bd-agregaruser-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                                        <div class="modal-dialog modal-lg modal-dialog-centered">
                                            <form action="agregarusuario"  method="post" id="formAgregarUsuario" >
                                                <div class="modal-content">

                                                    <div style="width: 100%;text-align: center;">
                                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>AGREGAR NUEVO USUARIO</strong></h1>
                                                    </div>


                                                    <div class="card">
                                                        <div class="card-body">
                                                            <div style="float: left;width: 50%;">

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Usuario</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input onblur="valusuagre()"  style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="txtAgregarUUsuario" placeholder="Teclea el usuario" name="txtAgregarUUsuario" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                        <script>
                                                                            function valusuagre() {
                                                                                if (document.getElementById("txtAgregarUUsuario").value === '') {
                                                                                    alert("EL USUARIO ES REQUERIDO");
                                                                                    document.getElementById("btnAgreU").hidden = true;
                                                                                    document.getElementById("txtAgregarUEPerfil").value = '';
                                                                                }
                                                                            }
                                                                        </script>
                                                                    </div></div><br>    

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input onblur="valnombagre()" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el nombre"  id="txtAgregarUNombre" name="txtAgregarUNombre" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                        <script>
                                                                            function valnombagre() {
                                                                                if (document.getElementById("txtAgregarUNombre").value === '') {
                                                                                    alert("EL NOMBRE ES REQUERIDO");
                                                                                    document.getElementById("btnAgreU").hidden = true;
                                                                                    document.getElementById("txtAgregarUEPerfil").value = '';
                                                                                }
                                                                            }
                                                                        </script>
                                                                    </div></div><br> 

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Password</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input onblur="valpassbagre()" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el password"  id="txtAgregarUPass" name="txtAgregarUPass" type="password" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                        <script>
                                                                            function valpassbagre() {
                                                                                if (document.getElementById("txtAgregarUPass").value === '') {
                                                                                    alert("EL PASSWORD ES REQUERIDO");
                                                                                    document.getElementById("btnAgreU").hidden = true;
                                                                                    document.getElementById("txtAgregarUEPerfil").value = '';
                                                                                }
                                                                            }
                                                                        </script>
                                                                    </div></div><br> 

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Confirmar Password</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input onblur="valpassconfbagre()" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el password"  id="txtAgregarUPassConfirm" name="txtAgregarUPassConfirm" type="password" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                        <script>
                                                                            function valpassconfbagre() {
                                                                                if (document.getElementById("txtAgregarUPass").value === document.getElementById("txtAgregarUPassConfirm").value) {

                                                                                } else {
                                                                                    alert("LOS PASSWORD NO COINCIDEN");
                                                                                    document.getElementById("txtAgregarUPass").value = '';
                                                                                    document.getElementById("txtAgregarUPassConfirm").value = '';
                                                                                }
                                                                            }
                                                                        </script>
                                                                    </div></div>
                                                            </div>
                                                            <div style="float: right;width: 50%;">

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Correo electrónico</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el correo electrónico"  id="txtAgregarUEmail" name="txtAgregarUEmail" type="email"  class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div></div><br>


                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Permisos</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <div>
                                                                            <select onchange="valperfilagre()" style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" required id="txtAgregarUEPerfil" name="txtAgregarUEPerfil" class="custom-select">
                                                                                <option value="" selected>Selecciona una perfil</option>
                                                                                <option value="1">Admin Of. Central</option>
                                                                                <option value="2">Admin Oficina</option>
                                                                            </select>
                                                                        </div> 
                                                                        <script>
                                                                            function valperfilagre() {
                                                                                if (document.getElementById("txtAgregarUEPerfil").value === '') {
                                                                                    alert("EL PERFIL ES REQUERIDO");
                                                                                    document.getElementById("btnAgreU").hidden = true;
                                                                                } else {
                                                                                    if (document.getElementById("txtAgregarUUsuario").value === '') {
                                                                                        alert("EL USUARIO ES REQUERIDO");
                                                                                    } else {
                                                                                        if (document.getElementById("txtAgregarUNombre").value === '') {
                                                                                            alert("EL NOMBRE ES REQUERIDO");
                                                                                        } else {
                                                                                            if (document.getElementById("txtAgregarUPass").value === '') {
                                                                                                alert("EL PASSWORD ES REQUERIDO");
                                                                                            } else {
                                                                                                document.getElementById("btnAgreU").hidden = false;
                                                                                            }

                                                                                        }

                                                                                    }

                                                                                }
                                                                            }
                                                                        </script>

                                                                    </div></div><br>

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Oficina administrativa asignada</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <div>
                                                                            <select  style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" id="txtAgregarUOfi" name="txtAgregarUOfi" class="custom-select">
                                                                                <option value="" selected>Ninguna Oficina</option>
                                                                                <%
                                                                                    Consultas ofAsig = new Consultas();
                                                                                    List<Oficina> lstofiAsig = new ArrayList();
                                                                                    lstofiAsig = ofAsig.allOficinas();
                                                                                    for (Oficina ofi : lstofiAsig) {

                                                                                %>

                                                                                <option value="<%=ofi.getNum()%>"><%=ofi.getNombre()%></option>


                                                                                <%
                                                                                    }
                                                                                %>
                                                                            </select>
                                                                        </div>    
                                                                    </div></div><br>

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <div>
                                                                            <select hidden  id="txtAgregarUEstatus" name="txtAgregarUEstatus" >

                                                                                <option selected value="1">Activo</option>
                                                                                <option value="0">Inactivo</option>
                                                                            </select>
                                                                        </div><br>


                                                                        <div  class="demo" style="float: left;">
                                                                            <input checked onclick="valChk3();"  style="border-color: #58585A;" type="checkbox" id="CheckVal3" >
                                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 14px;" for="CheckVal3"><span></span><strong>Activo</strong></label>
                                                                        </div>
                                                                        <script>
                                                                            function valChk3() {
                                                                                if (document.getElementById('CheckVal3').checked) {
                                                                                    document.getElementById('txtAgregarUEstatus').value = "1";
                                                                                } else {
                                                                                    document.getElementById("txtAgregarUEstatus").value = "0";
                                                                                }

                                                                            }
                                                                        </script>

                                                                    </div></div>


                                                            </div> </div> </div>


                                                    <div class="modal-footer">
                                                        <input type="text" value="<%=usuario%>"  id="user" name="useragr" hidden>
                                                        <button hidden id="btnAgreU" onclick="submit()" type="button" class="btn btn-primary"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>CREAR USUARIO</strong></button>
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal"   style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CERRAR</strong></button>
                                                    </div>
                                                </div></form>
                                        </div>
                                    </div>


                                    <!-- EDITAR USUARIOS -->
                                    <div class="modal fade bd-editaruser-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" >
                                        <div class="modal-dialog modal-lg modal-dialog-centered">
                                            <form action="editarusuario" method="post" id="formEditarUsuario" name="formEditarUsuario"> <!-- class="was-validated"> -->
                                                <div class="modal-content">
                                                    <input id="txtusredit" name="txtusredit" value="<%=usuario%>" hidden>
                                                    <input id="txtEditarUId" name="txtEditarUId" hidden>

                                                    <div style="width: 100%;text-align: center;">
                                                        <h1 style="font-size: 18px;background-color:#668FB7;font-family: 'Roboto', sans-serif;color: white;"><strong>EDITAR USUARIO</strong></h1>
                                                    </div>


                                                    <div class="card">
                                                        <div class="card-body">
                                                            <div style="float: left;width: 50%;">

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Usuario</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" readonly id="txtEditarUUsu" name="txtEditarUUsu" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div></div><br>    

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Nombre</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el nombre" id="txtEditarUNombre" name="txtEditarUNombre"  type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div></div><br> 

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Password</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el Password" id="txtEditarUPass" name="txtEditarUPass" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div></div><br> 

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Confirmar Password</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el Password"  id="txtEditarUPassConfirm" name="txtEditarUPassConfirm" type="password" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div></div><br>



                                                            </div>
                                                            <div style="float: right;width: 50%;">

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Correo electrónico</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <input style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el Correo electrónico" id="txtEditarUEmail" name="txtEditarUEmail" type="text" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
                                                                    </div></div><br>


                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Permisos</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <div>
                                                                            <select  style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;" placeholder="Teclea el Password"  id="txtEditarUEPerfil" name="txtEditarUEPerfil" class="custom-select">

                                                                                <option value="1">Admin Of. Central</option>
                                                                                <option value="2">Admin Oficina</option>
                                                                            </select>
                                                                        </div>    
                                                                    </div></div><br>

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 16px;"><strong>Oficina administrativa asignada</strong></label>
                                                                    </div>
                                                                    <div style="width: 90%">
                                                                        <div>
                                                                            <select style="font-family: 'Roboto', sans-serif;color: #A0A0A0;font-size: 14px;"   id="txtEditarUOfi" name="txtEditarUOfi" class="custom-select">
                                                                                <option value="" selected>Ninguna Oficina</option>
                                                                                <%
                                                                                    Consultas ofAsigEdit = new Consultas();
                                                                                    List<Oficina> lstofiAsigedit = new ArrayList();
                                                                                    lstofiAsigedit = ofAsigEdit.allOficinas();
                                                                                    for (Oficina of : lstofiAsigedit) {

                                                                                %>

                                                                                <option value="<%=of.getNum()%>"><%=of.getNombre()%></option>


                                                                                <%
                                                                                    }
                                                                                %>
                                                                            </select>
                                                                        </div>    
                                                                    </div></div><br>

                                                                <div class="input-group input-group-lg">       
                                                                    <div class="input-group-prepend">
                                                                        <div>
                                                                            <select hidden  id="txtEditarUEstatus" name="txtEditarUEstatus" >

                                                                                <option selected value="1">Activo</option>
                                                                                <option value="0">Inactivo</option>
                                                                            </select>
                                                                        </div><br>


                                                                        <div  class="demo" style="float: left;">
                                                                            <input  onclick="valChk4();"  style="border-color: #58585A;" type="checkbox"  id="CheckVal4" >
                                                                            <label style="font-family: 'Roboto', sans-serif;color: #58585A;font-size: 14px;" for="CheckVal4"><span></span><strong>Activo</strong></label>
                                                                        </div>
                                                                        <script>
                                                                            function valChk4() {
                                                                                if (document.getElementById('CheckVal3').checked) {
                                                                                    document.getElementById('txtEditarUEstatus').value = "1";
                                                                                } else {
                                                                                    document.getElementById("txtEditarUEstatus").value = "0";
                                                                                }

                                                                            }
                                                                        </script>

                                                                    </div></div>


                                                            </div> </div>
                                                    </div>

                                                    <div class="modal-footer">
                                                        <input type="text" value="<%=usuario%>"  id="user" name="useragr" hidden>
                                                        <button id="btnEditUsr" onclick="submit()" type="button" class="btn btn-primary"  style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;background-color: #006EB2;"><strong>EDITAR USUARIO</strong></button>
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal"   style="font-size: 14px;font-family: 'Roboto', sans-serif;color: white;"><strong>CERRAR</strong></button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div></div>


                            </div>

                        </div>

                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </body>

</html>
