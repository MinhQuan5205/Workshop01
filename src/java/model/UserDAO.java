/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;
/**
 *
 * @author ACER
 */
public class UserDAO {
    //Cau Truy Van
    private static final String GET_ALL_USERS = "SELECT * FROM tblUsers";
    private static final String GET_USER_BY_USERNAME = "SELECT * FROM tblUsers WHERE Username=?";
    
    ArrayList<UserDTO> userList;

    public UserDAO() {
    }
    
    public UserDTO getUserByUserName(String username){
        UserDTO user = null;
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement pr = conn.prepareStatement(GET_USER_BY_USERNAME);
            pr.setString(1, username);
            ResultSet rs = pr.executeQuery();
            while(rs.next()){
                String userName = rs.getString("Username");
                String name = rs.getString("Name");
                String password = rs.getString("Password");
                String role = rs.getString("Role");
                
                user = new UserDTO(userName, name, password, role);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return user;
    }
    
    public boolean login(String userName, String password){
        UserDTO user = getUserByUserName(userName);
        if(user != null){
            if(user.getPassword().equals(password)){
                 return true;
            }
        }
        return false;
    }
    
    public List<UserDTO> getAllUsers(){
        List<UserDTO> userList = new ArrayList<>();
        
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(GET_ALL_USERS);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                UserDTO user = new UserDTO();
                user.setUserName(rs.getString("Username"));
                user.setName(rs.getString("Name"));
                user.setPassword(rs.getString("Password"));
                user.setRole(rs.getString("Role"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }
    
    public boolean updatePassword(String userName, String newPassword){
        String query = "UPDATE tblUsers SET Password = ? WHERE Username = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setString(2, userName);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
//    public static void main(String[] args) {
//        UserDAO udao = new UserDAO();
//        List<UserDTO> list = udao.getAllUsers();
//
//        for (UserDTO user : list) {
//            System.out.println(user.getPassword());
//        }
//    }
}
