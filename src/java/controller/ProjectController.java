/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import model.ProjectDAO;
import utils.AuthUtils;
import utils.DbUtils;
import java.util.Date;
import java.util.List;
import model.ProjectDTO;

/**
 *
 * @author ACER
 */
@WebServlet(name = "ProjectController", urlPatterns = {"/ProjectController"})
public class ProjectController extends HttpServlet {
    ProjectDAO pdao = new ProjectDAO();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "";
        try {
            String action = request.getParameter("action");
            if(action.equals("addProject")){
                url = handleProjectAdding(request, response);
            }else if(action.equals("searchProject")){
                url = handleProjectSearching(request, response);
            }else if(action.equals("editProject")){
                url = handleProjectEditing(request, response);
            }else if(action.equals("updateProject")){
                url = handleProjectUpdating(request, response);
            }
        } catch (Exception e) {
             e.printStackTrace();
        }finally{
            request.getRequestDispatcher(url).forward(request, response);
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

    private String handleProjectAdding(HttpServletRequest request, HttpServletResponse response) {
        if(AuthUtils.isFounder(request)){
            boolean checkAll = true;
            String checkError = "";
            String message = "";
            
            int id = pdao.getIdProjectNew();
            String projectName = request.getParameter("projectName");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String launchDate = request.getParameter("launchDate");
            
            String pNameErr = "";
            String desErr = "";
            String statusErr = "";
            String lDateErr = "";
            
            if(projectName == null || projectName.trim().isEmpty()){
                pNameErr = "Project Name cannot be empty !";
                checkAll = false;
            }else if(pdao.checkDuplicateProjectName(projectName)){
                pNameErr = "Project Name cannot dupplicated !";
                checkAll = false;
            }
            
            if(description == null || description.trim().isEmpty()){
                desErr = "Project Description cannot be empty.";
                checkAll = false;
            }
            
            if(status == null || status.trim().isEmpty()){
                statusErr = "Project Status cannot be empty.";
                checkAll = false;
            }
            
            Date launchDateFormat = null;
            try{
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                dateFormat.setLenient(false);//không cho phép những giá trị như 2025-13-40
                launchDateFormat = dateFormat.parse(launchDate);
                
                Date now = new Date();
                if(launchDateFormat.before(now)){
                    lDateErr = "Launch date must be in the future!";
                    checkAll = false;
                }
            }catch(Exception e){
                lDateErr = "Invalid Launch date format!!!";
                checkAll = false;
            }
            
            ProjectDTO project = new ProjectDTO(id,projectName, description, status, launchDateFormat);
            if(checkAll){
                message = "Add project successfully.";
                pdao.create(project);
            }else{
                checkError= "Can not add new project.";
            }
            
            request.setAttribute("project", project);
            request.setAttribute("pNameErr", pNameErr);
            request.setAttribute("desErr", desErr);
            request.setAttribute("statusErr", statusErr);
            request.setAttribute("lDateErr", lDateErr);
            request.setAttribute("checkError", checkError);
            request.setAttribute("message", message);
            
        }
        return "projectForm.jsp";
    }

    private String handleProjectSearching(HttpServletRequest request, HttpServletResponse response) {
        String keyword = request.getParameter("keyword");
        List<ProjectDTO> list = pdao.getProjectByName(keyword);
        request.setAttribute("list", list);
        request.setAttribute("keyword", keyword);
        return "projectDashboard.jsp";
    }

    private String handleProjectEditing(HttpServletRequest request, HttpServletResponse response) {
        int projectId = Integer.parseInt(request.getParameter("project_Id"));
        String keyword = request.getParameter("keyword");
        if(AuthUtils.isFounder(request)){
            ProjectDTO project = pdao.getProjectById(projectId);
            if(project != null){
                request.setAttribute("keyword", keyword);
                request.setAttribute("project", project);
                request.setAttribute("isEdit", true);
                return "projectForm.jsp";
            }
        }
        return handleProjectSearching(request, response);
    }
    
    private String handleProjectUpdating(HttpServletRequest request, HttpServletResponse response) {
        if(AuthUtils.isFounder(request)){
            boolean checkAll = true;
            String checkError = "";
            String message = "";
            
            int id = Integer.parseInt(request.getParameter("project_id"));
            String projectName = request.getParameter("projectName");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String launchDate = request.getParameter("launchDate");
            
            String pNameErr = "";
            String desErr = "";
            String statusErr = "";
            String lDateErr = "";
            
            if(projectName == null || projectName.trim().isEmpty()){
                pNameErr = "Project Name cannot be empty.";
                checkAll = false;
            }
            
            if(description == null || description.trim().isEmpty()){
                desErr = "Project Description cannot be empty.";
                checkAll = false;
            }
            
            if(status == null || status.trim().isEmpty()){
                statusErr = "Project Status cannot be empty.";
                checkAll = false;
            }
            
            Date launchDateFormat = null;
            try{
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                launchDateFormat = dateFormat.parse(launchDate);
                
                Date now = new Date();
                if(launchDateFormat.before(now)){
                    lDateErr = "Launch date must be in the future!";
                    checkAll = false;
                }
            }catch(Exception e){
                lDateErr = "Invalid Launch date format!!!";
                checkAll = false;
            }
            
            ProjectDTO project = new ProjectDTO(id, projectName, description, status, launchDateFormat);
            if(checkAll){
                if(pdao.updateProjectStatus(project)){
                    message = "Project update successfull !!!";
                }
            }else{
                checkError = "Project can not update !!!";
            }
            
            request.setAttribute("project", project);
            request.setAttribute("pNameErr", pNameErr);
            request.setAttribute("desErr", desErr);
            request.setAttribute("statusErr", statusErr);
            request.setAttribute("lDateErr", lDateErr);
            request.setAttribute("checkError", checkError);
            request.setAttribute("message", message);
            request.setAttribute("isEdit", true);
            
        }
        return "projectForm.jsp";
    }

}
