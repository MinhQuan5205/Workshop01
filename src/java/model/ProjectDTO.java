/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.SimpleDateFormat;
import java.util.Date;



/**
 *
 * @author ACER
 */
public class ProjectDTO {
    private int project_Id;
    private String project_Name;
    private String description;
    private String status;
    private Date estimated_launch;

    public ProjectDTO() {
    }

    public ProjectDTO(int project_Id, String project_Name, String description, String status, Date estimated_launch) {
        this.project_Id = project_Id;
        this.project_Name = project_Name;
        this.description = description;
        this.status = status;
        this.estimated_launch = estimated_launch;
    }

    
    public int getProject_Id() {
        return project_Id;
    }

    public void setProject_Id(int project_Id) {
        this.project_Id = project_Id;
    }

    public String getProject_Name() {
        return project_Name;
    }

    public void setProject_Name(String project_Name) {
        this.project_Name = project_Name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEstimated_launchString() {
        if(this.estimated_launch == null) return "";
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(estimated_launch);
        return dateString;
    }
    
    public Date getEstimated_launch(){
        return estimated_launch;
    }
    
    public java.sql.Date getEstimated_launchSqlDate() {
        return new java.sql.Date(estimated_launch.getTime());
    }
    
    public void setEstimated_launch(Date estimated_launch) {
        this.estimated_launch = estimated_launch;
    }
}
