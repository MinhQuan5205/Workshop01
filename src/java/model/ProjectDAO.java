/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

/**
 *
 * @author ACER
 */
public class ProjectDAO {

    //Cau Truy Van
    private static final String GET_ALL_PROJECT = "SELECT * FROM tblStartupProjects";
    private static final String CREATE_PROJECT = "INSERT INTO tblStartupProjects(project_id,project_name,Description,Status,estimated_launch) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE_PROJECT_STATUS = "UPDATE tblStartupProjects SET Status = ? WHERE project_id = ?";

    public ProjectDAO() {
    }

    public List<ProjectDTO> getAll() {
        List<ProjectDTO> projectsList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_PROJECT);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProjectDTO project = new ProjectDTO();
                project.setProject_Id(rs.getInt("project_id"));
                project.setProject_Name(rs.getString("project_name"));
                project.setDescription(rs.getString("Description"));
                project.setStatus(rs.getString("Status"));
                project.setEstimated_launch(rs.getDate("estimated_launch"));

                projectsList.add(project);
            }
        } catch (Exception e) {
            System.err.println("Error in getAll(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return projectsList;
    }

    public boolean create(ProjectDTO project) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(CREATE_PROJECT);

            ps.setInt(1, project.getProject_Id());
            ps.setString(2, project.getProject_Name());
            ps.setString(3, project.getDescription());
            ps.setString(4, project.getStatus());
            ps.setDate(5, project.getEstimated_launchSqlDate());

            int rowsChange = ps.executeUpdate();
            success = (rowsChange > 0);
        } catch (Exception e) {
            System.err.println("Error in create(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }

        return success;
    }
    
    public boolean updateProjectStatus(ProjectDTO project){
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(UPDATE_PROJECT_STATUS);
            ps.setString(1, project.getStatus());
            ps.setInt(2, project.getProject_Id());
            
            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);
            
        } catch (Exception e) {
            System.err.println("Error in update(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }
    public List<ProjectDTO> getProjectByName(String name){
        List<ProjectDTO> projectsList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = GET_ALL_PROJECT + " WHERE project_name LIKE ?";
        
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%"+name+"%");
            rs = ps.executeQuery();
            
            while(rs.next()){
                ProjectDTO project = new ProjectDTO();
                project.setProject_Id(rs.getInt("project_id"));
                project.setProject_Name(rs.getString("project_name"));
                project.setDescription(rs.getString("Description"));
                project.setStatus(rs.getString("Status"));
                project.setEstimated_launch(rs.getDate("estimated_launch"));
                
                projectsList.add(project);
            }
            
        } catch (Exception e) {
            System.err.println("Error in getProjectByName(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return projectsList;
    }
    
    public int getIdProjectNew(){
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT COUNT(*) as total FROM tblStartupProjects";
        int count = 0;
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while(rs.next()){
                count = rs.getInt("total");
            }
        }catch(Exception e){
            System.err.println("Error in getIdProjectNew(): " + e.getMessage());
            e.printStackTrace();
        }finally{
            closeResources(conn, ps, rs);
        }
        return ++count;
    }
    
    public ProjectDTO getProjectById(int id){
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ProjectDTO project= null;
        
        String query = "SELECT * FROM tblStartupProjects WHERE project_id = ?";
        
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            while(rs.next()){
                project = new ProjectDTO();
                project.setProject_Id(rs.getInt("project_id"));
                project.setProject_Name(rs.getString("project_name"));
                project.setDescription(rs.getString("Description"));
                project.setStatus(rs.getString("status"));
                project.setEstimated_launch(rs.getDate("estimated_launch"));
            }
            
        } catch (Exception e) {
        } finally {
            closeResources(conn, ps, rs);
        }
        return project;
    }
    
    public boolean checkDuplicateProjectName(String projectName){
        List<ProjectDTO> projectList = new ArrayList<>();
        projectList = getAll();
        
        for (ProjectDTO project : projectList) {
            if(project.getProject_Name().equals(projectName)){
                return true;
            }
        }
        return false;
    }
    
    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing resources: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        ProjectDAO pdao = new ProjectDAO();
        int newId = pdao.getIdProjectNew();
        System.out.println(newId);
    }
}
