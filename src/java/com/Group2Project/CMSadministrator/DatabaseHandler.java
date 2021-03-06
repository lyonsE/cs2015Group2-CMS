/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Group2Project.CMSadministrator;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Retrieves connection objects
 * Holds default login data to the database server
 * @author Éanna
 */
public class DatabaseHandler {
    private String userName;
    private String password;
    private String serverName;
    private String serverPort;
    private String database;
    private Connection conn;
    
    public DatabaseHandler() throws Exception{
        this("java","javapass", "cmshome");//Default username & password
    }
    
    public DatabaseHandler( String database) throws Exception{
        this("java","javapass", database);//Default username & password
    }
    
    public DatabaseHandler(String userName, String password, String database) throws Exception {
        this.serverName="localhost";
        this.serverPort="3306";
        this.userName=userName;
        this.password=password;
        this.database=database;
        try {
            conn = getConnection();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new Exception();
        }
    }
    /**
     * Used for SELECT statements
     * @param query
     * @return
     * @throws Exception 
     */
    public ResultSet executeQuery( String query) throws Exception{
        ResultSet result = null;
        try {
            Statement statement = conn.createStatement();
            statement.executeQuery(query);
            result = statement.getResultSet();
            
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseHandler.class.getName()).log(Level.SEVERE, null, ex);
            throw new Exception();
        }
        
        return result;
    }
    /**
     * Removes the need for boilerplate code, used for data manipulation
     * @param query
     * @return
     * @throws SQLException 
     */
    public ResultSet executeUpdate( String query) throws Exception{
        ResultSet result = null;
        try {
            Statement statement = conn.createStatement();
            statement.executeUpdate(query);
            result = statement.getResultSet();
        } catch (SQLException e){
            e.printStackTrace();
        }
        
        return result;
    }
    public void executeScript( File script ) throws Exception{
        BufferedReader reader = new BufferedReader( new FileReader( script ) );
        
        StringBuilder builder = new StringBuilder();
        String line;
        while((line = reader.readLine()) != null){
            builder.append(line);
        }
        
        String sql = builder.toString();
        System.out.println(sql);
        try {
            executeUpdate(sql);
        } catch (SQLException e){
            e.printStackTrace();
        }
    }
    private Connection getConnection() throws SQLException {
        
        Connection connection = null;
        Properties connectionProps = new Properties();
        connectionProps.put("user", this.userName);
        connectionProps.put("password", this.password);
        connectionProps.put("allowMultiQueries", "true");
        try {
            /*
            connection = DriverManager.getConnection(
            "jdbc:" + "mysql" + "://" +
            this.serverName +
            ":" + this.serverPort + "/",
            connectionProps);
            */
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(
                       "jdbc:mysql://localhost:3306/" + database,
                       connectionProps);
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DatabaseHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        System.out.println("Connected to database");
        return connection;
    }
    
    public void closeConnection(){
        try {
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
