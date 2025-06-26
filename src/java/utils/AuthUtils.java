/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.UserDTO;

/**
 *
 * @author ACER
 */
public class AuthUtils {
    public static UserDTO getCurrentUser(HttpServletRequest request){
        HttpSession sesstion = request.getSession();
        if(sesstion != null){
            return (UserDTO)sesstion.getAttribute("user");
        }
        return null;
    }
    
    public static boolean isLoggedIn(HttpServletRequest request){
        return AuthUtils.getCurrentUser(request) != null;
    }
    
    public static boolean hasRole(HttpServletRequest request, String userRole){
        UserDTO user = getCurrentUser(request);
        if(user != null){
            String role = user.getRole();
           return role.equals(userRole);
        }
        return false;
    }
    public static boolean isFounder(HttpServletRequest request){
        return hasRole(request, "Founder");
    }
    
    public static String getAccessDeniedMessage(String action){
        return "You don't have permission to "+action+". Please contact Founder"; 
    }
}
