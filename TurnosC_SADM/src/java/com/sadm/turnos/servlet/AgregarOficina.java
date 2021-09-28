
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

public class AgregarOficina extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String uuid = java.util.UUID.randomUUID().toString();
        String user = request.getParameter("user");
        String agreOfiNum = request.getParameter("agreOfiNum");
        String agreUniCom = request.getParameter("agreUniCom");
        String agreOfiNombre = request.getParameter("agreOfiNombre");
        String agreOfiDesc = request.getParameter("agreOfiDesc");
        String agreOfiDir = request.getParameter("agreOfiDir");
        String agreOfiCP = request.getParameter("agreOfiCP");
        String agreOfiMun = request.getParameter("agreOfiMun");
        String agreOfiTel = request.getParameter("agreOfiTel");
        String agreOfiCity = request.getParameter("agreOfiCity");
        String agreOfiEmail = request.getParameter("agreOfiEmail");
         String agreOfiServ = request.getParameter("agreOfiServ");
         String dbUserName =request.getParameter("dbUserName");
         String dbPass =request.getParameter("dbPass");
         String dbHost =request.getParameter("dbHost");
         String dbPort =request.getParameter("dbPort");
         String dbName =request.getParameter("dbName");
                 
         ConexionLocal ccll = new ConexionLocal();
         ccll.setIdOficina(uuid);
         ccll.setNum(agreOfiNum);
         ccll.setCodUniCom(agreUniCom);
         ccll.setNombre(agreOfiNombre);
         ccll.setDesc(agreOfiDesc);
         ccll.setDireccion(agreOfiDir);
         ccll.setCp(agreOfiCP);
         ccll.setMunicipio(agreOfiMun);
         ccll.setTel(agreOfiTel);
         ccll.setCiudad(agreOfiCity);
         ccll.setEmail1(agreOfiEmail);
         ccll.setServidor(agreOfiServ);
         ccll.setDb_username(dbUserName);
         ccll.setDb_pass(dbPass);
         ccll.setDb_host(dbHost);
         ccll.setDb_port(dbPort);
         ccll.setDb_name(dbName);
         ccll.setVideo("-");
         ccll.setPoster("-");
         ccll.setDb_tblturno_last("-");
         
        ConsultasLocal cl = new ConsultasLocal(ccll);
        ConsultasLocal c2 = new ConsultasLocal(ccll);
        
        Consultas cc = new Consultas();
        List<Servicio> lstServ = cc.slctServ(agreOfiServ);
        boolean updateLocal = cl.serv_ofi(lstServ,ccll);
        
        System.out.println("updateLocal servicio oficina ::::: "+updateLocal);
         System.out.println("desc:: "+agreOfiDesc);
        Consultas co = new Consultas();
        System.out.println("agreOfiMun:: "+agreOfiMun);
        if(co.agregarOficina(user,agreOfiNum,agreUniCom,agreOfiNombre,agreOfiDesc,agreOfiDir,agreOfiCP,agreOfiMun,agreOfiTel,agreOfiCity,agreOfiEmail,dbUserName,dbHost,dbPass,dbHost,dbPort,dbName,agreOfiServ)){
            System.out.println("Oficina Creada en Central Por ::: "+user+" ... "+agreOfiNombre);
            boolean updatelocalofi = c2.agregar_oficina_local(ccll);
            System.out.println("updateLocal oficinalocal ::::: "+updatelocalofi);
            //TODO insert to mysql sucursal oficina
            
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
