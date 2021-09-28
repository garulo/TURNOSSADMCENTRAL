
package com.sadm.turnos.servlet;

import com.sadm.turnos.controlador.Consultas;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class EditarServicio extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String user = request.getParameter("user");
        String editServId = request.getParameter("editServId");
        String editServNombre = request.getParameter("editServNombre");
        String editServPrefijo = request.getParameter("editServPrefijo");
        String txtEditarSEstatus = request.getParameter("txtEditarSEstatus");
        String colorselectorE = request.getParameter("colorselectorE");
        Consultas co = new Consultas();
        if (co.editarServicio(user, editServId, editServNombre, txtEditarSEstatus, colorselectorE,editServPrefijo)) {
            System.out.println("Servicio Editado ::: " + editServNombre + " : Por :" + user);
            response.sendRedirect("/TurnosC_SADM/DashBoardCentral.jsp");
        } else {
            System.out.println("Servicio No Editado ::: " + editServNombre + " : Por :" + user);
            response.sendRedirect("/TurnosC_SADM/DashBoardCentral.jsp");

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
