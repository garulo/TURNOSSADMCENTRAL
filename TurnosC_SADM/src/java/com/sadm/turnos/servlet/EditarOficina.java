
package com.sadm.turnos.servlet;

import com.sadm.turnos.controlador.Consultas;
import com.sadm.turnos.controlador.ConsultasLocal;
import com.sadm.turnos.dao.ConexionLocal;
import com.sadm.turnos.dao.Servicio;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class EditarOficina extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String user = request.getParameter("user");
        String editOfiId = request.getParameter("editOfiId");
        String editOfiNum = request.getParameter("editOfiNum");
        String editOfiNombre = request.getParameter("editOfiNombre");
        String editOfiDesc = request.getParameter("editOfiDesc");
        String editOfiDir = request.getParameter("editOfiDir");
        String editOfiCP = request.getParameter("editOfiCP");
        String editOfiMun = request.getParameter("editOfiMun");
        String editOfiTel = request.getParameter("editOfiTel");
        String editOfiCity = request.getParameter("editOfiCity");
        String editOfiEmail = request.getParameter("editOfiEmail");
        String editOfiServ = request.getParameter("editOfiServ");
        String editdbUserName =request.getParameter("editdbUserName");
         String editdbPass =request.getParameter("editdbPass");
         String editdbHost =request.getParameter("editdbHost");
         String editdbPort =request.getParameter("editdbPort");
         String editdbName =request.getParameter("editdbName");
        
        //TODO
          ConexionLocal ccll = new ConexionLocal();
          
          ccll.setNum(editOfiNum);
         ccll.setNombre(editOfiNombre);
         ccll.setDesc(editOfiDesc);
         ccll.setDireccion(editOfiDir);
         ccll.setCp(editOfiCP);
         ccll.setMunicipio(editOfiMun);
         ccll.setTel(editOfiTel);
         ccll.setCiudad(editOfiCity);
         ccll.setEmail1(editOfiEmail);
         ccll.setServidor(editOfiServ);
         ccll.setDb_username(editdbUserName);
         ccll.setDb_pass(editdbPass);
         ccll.setDb_host(editdbHost);
         ccll.setDb_port(editdbPort);
         ccll.setDb_name(editdbName);
         ccll.setVideo("-");
         ccll.setPoster("-");
         ccll.setDb_tblturno_last("-");
        ConsultasLocal cl = new ConsultasLocal(ccll);
        ConsultasLocal c2 = new ConsultasLocal(ccll);
        Consultas cc = new Consultas();
        List<Servicio> lstServ = cc.slctServ(editOfiServ);
        boolean updateLocal = cl.serv_ofi(lstServ,ccll);
        System.out.println("updateLocal servicios ::::: "+updateLocal);
        
        Consultas co = new Consultas();
        if(co.editarOficina(user,editOfiId,editOfiNum,editOfiNombre,editOfiDesc,editOfiDir,editOfiCP,editOfiMun,editOfiTel,editOfiCity,editOfiEmail,editOfiServ,editdbUserName,editdbPass,editdbHost,editdbPort,editdbName)){
            boolean updateLocaloficina = c2.editar_oficina_local(ccll);
            System.out.println("updateLocaloficina ::::: "+updateLocaloficina);
            response.sendRedirect("/TurnosC_SADM/DashBoardCentral.jsp");
        }else{
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
