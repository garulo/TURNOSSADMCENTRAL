package com.sadm.turnos.servlet;

import com.sadm.turnos.controlador.Consultas;
import com.sadm.turnos.controlador.ConsultasLocal;
import com.sadm.turnos.dao.ConexionLocal;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author marco
 */
public class AgregarUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String txtAgregarUUsuario = request.getParameter("txtAgregarUUsuario");
        String txtAgregarUNombre = request.getParameter("txtAgregarUNombre");
        String txtAgregarUPass = request.getParameter("txtAgregarUPass");
        String txtAgregarUEmail = request.getParameter("txtAgregarUEmail");
        String txtAgregarUEPerfil = request.getParameter("txtAgregarUEPerfil");
        String txtAgregarUOfi = request.getParameter("txtAgregarUOfi");
        String txtAgregarUEstatus = request.getParameter("txtAgregarUEstatus");
        String useragr = request.getParameter("useragr");
        Consultas co = new Consultas();
        ConexionLocal conloc=co.conexionOficina(txtAgregarUOfi);
        System.out.println("conloc:: "+conloc.getDb_host()+" / "+conloc.getDb_name());
        ConsultasLocal cl = new ConsultasLocal(conloc);
        
        if (txtAgregarUEPerfil.equalsIgnoreCase("1")) {
            System.out.println("Se Agrega usuario en DB Central Perfil Admin Central");
            co = new Consultas();
            if (co.agregarUsuario(txtAgregarUUsuario, txtAgregarUNombre, txtAgregarUPass, txtAgregarUEmail, txtAgregarUEPerfil, txtAgregarUOfi, txtAgregarUEstatus, useragr)) {

                response.sendRedirect("/TurnosC_SADM/DashBoardCentral.jsp");
            } else {
                response.sendRedirect("/TurnosC_SADM/DashBoardCentral.jsp");

            }
        }else if (txtAgregarUEPerfil.equalsIgnoreCase("2")) {
            System.out.println("Se Agrega usuario en DB Central y Local Perfil Admin Local");
            co = new Consultas();
            if (co.agregarUsuario(txtAgregarUUsuario, txtAgregarUNombre, txtAgregarUPass, txtAgregarUEmail, txtAgregarUEPerfil, txtAgregarUOfi, txtAgregarUEstatus, useragr)) {
                 System.out.println("Usuario isertado en Central");
                if(cl.agregarUsuario(txtAgregarUUsuario, txtAgregarUNombre, txtAgregarUPass, txtAgregarUEmail, txtAgregarUEPerfil, txtAgregarUOfi, txtAgregarUEstatus, useragr,conloc)){
                response.sendRedirect("/TurnosC_SADM/DashBoardCentral.jsp");
                }else{
                    System.out.println("Usuario no isertado en local");
                    response.sendRedirect("/TurnosC_SADM/DashBoardCentral.jsp");
                }
            } else {
                System.out.println("Error al insertar Usuario Admin Local en DB Central:: " + txtAgregarUUsuario);
                response.sendRedirect("/TurnosC_SADM/DashBoardCentral.jsp");
            }
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
