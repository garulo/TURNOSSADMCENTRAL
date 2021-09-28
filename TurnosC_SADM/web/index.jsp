<%-- 
    Document   : Login
    Created on : Feb 23, 2020, 7:05:27 PM
    Author     : marco
--%>

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
        <script src="js/stacktable.js"></script>
        <link href="css/stacktable.css" rel="stylesheet">
        <style>
            body{
                margin: 0;display: flex;
            }
            video {
                position: fixed;
                min-width: 100%;
                min-height: 100%;
                left: 50%;
                top: 50%;
                transform: translateX(-50%) translateY(-50%);
                z-index: -1;
                /*-webkit-filter:sepia(100%);*/
            }
        </style>
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i&display=swap" rel="stylesheet">
    </head>
    <body style="height: 100%;width: 100%;text-align: left;background:url('/Turnos_SADM/archivos/uploaded_files/fondo_agua_sadm_1_1.jpg');background-size:cover;" >
        <!--<video muted autoplay loop style="background-image:url(&quot;archivos/uploaded_files/fondo_agua_sadm_1_1.jpg&quot;)" >
              <source src="archivos/uploaded_files/video_base.mp4" > 
          
        </video>-->       
        <div style="margin: auto;display: table;height: 100%;alignment-adjust: central;background-color: white;margin-top: 10%;">           
            <div style="display: table-cell;vertical-align: middle;alignment-adjust: central;" >

                <div class="table-responsive">
                    <form action="inicosesion"   method="post" id="formlogin" >
                        <table class="table">
                            <thead>
                                <tr >
                            <div style="margin-left:80px;margin-top: 50px;">
                                <div  >
                                    <h2 style="font-size: 22px;color: #58585A;font-family: 'Roboto', sans-serif;">ADMINISTRADOR DE TURNOS</h2>
                                </div>
                            </div>
                            </tr>
                            </thead>
                            <tbody >
                                <tr>
                                    <td style="margin: 10px;alignment-adjust: auto;width: 400px;text-align: center;">
                                        <img src="archivos/uploaded_files/logo_sadm_2.png"  width='70%' height='100%' style="display: block;margin: 0 auto;max-width: 100%;"  >
                                    </td>
                                    <td style="margin: 5px;alignment-adjust: auto;width: 400px;text-align: left;">
                                        <div><label for="Usuario" style="width: 90%;font-size: 16px;color: #58585A;font-family: 'Roboto', sans-serif;" ><strong>Usuario</strong></label></div>
                                        <div><input type="text" style="font-size: 14px;color: #58585A;width: 300px;height: 30px;" autofocus="true" maxlength="256" name="Usuario" data-name="Usuario" placeholder="Teclea tu usuario" id="txtUsuario"/></div>
                                        <br><div><label for="password" style="font-size: 16px;color: #58585A;font-family: 'Roboto', sans-serif;"><strong>Password</strong></label></div>
                                       <div> <input type="password" style="font-size: 14px;color: #58585A;width: 300px;height: 30px;"  maxlength="256" name="password" data-name="Password" placeholder="Teclea tu contraseña" id="txtPassword"/></div>
                                        <br><br><input id="btniniciar" style="font-family: 'Roboto', sans-serif;width: 300px;height: 40px;color: white;background-color:#0A4BA2;border-radius: 10px;"  type="submit" value="ENTRAR" data-wait="Espere ..."  />
                                        <br> </td>
                                </tr>

                            </tbody>
                        </table>
                        <br><br>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
