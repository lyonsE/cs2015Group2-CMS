/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Group2Project.CMSadministrator;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.jasypt.util.password.*;

/**
 * Handles login input
 * Using this class allows any page to log the user in.
 * @author Éanna
 */
public class LoginHandler {
    private DatabaseHandler db;
    
    public LoginHandler(){
        db = null;
        try {
            db = new DatabaseHandler();
        } catch (Exception ex) {
            //Fuck
        }
    }
    
    public ArrayList<CMSError> login(String email,
            String password, HttpSession session){
        ArrayList<CMSError> errors = new ArrayList<CMSError>();
        try {
            //Check user exists and get passHash
            ResultSet results =db.executeQuery("SELECT passHash "
                    + "FROM User WHERE email = \"" +email + "\";");
            String storedPass = null;
            //Check if any results
            if (results.next()) {
                storedPass = results.getString("passHash");
                //get PassHash
                BasicPasswordEncryptor passwordEncryptor = new BasicPasswordEncryptor();
                
                //Check against plain password
                if (passwordEncryptor.checkPassword(password, storedPass)){
                    session.setAttribute("loggedIn", true);
                } else {
                    errors.add( new CMSError("Wrong password"));
                }
            } else {
                //TODO SECURITY FLAW
                errors.add( new CMSError("User not found"));
            }
        } catch (Exception ex) {
            errors.add(  new CMSError("DatabaseError"));
            ex.printStackTrace();
            System.out.println("Something is fucking wrong");
        }

        return errors;
    }
    
    
}

