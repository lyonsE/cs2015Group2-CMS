<%-- 
    Document   : index
    Created on : 11-Feb-2014, 15:13:08
    Author     : Éanna
--%>
<%@page import="com.Group2Project.CMSadministrator.ServerConfigure"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@page import="com.Group2Project.CMSadministrator.LoginHandler"%>
<%@page import="org.jasypt.util.password.BasicPasswordEncryptor"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.Group2Project.CMSadministrator.DatabaseHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Charity Management System</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        
        <%@include file="WEB-INF/jspf/nav.jspf" %>
        
        <% 
            //Is logged in?
            //New Domain form
            
            //New user and Site form
        if (request.getParameterNames().hasMoreElements()) {
            /*
            File test = new File("TEST.txt");
            test.setWritable(true);
            FileWriter writer = new FileWriter("TEST.txt");
            writer.append("Hell no");
            */
            //Create a validater
                if ((!( request.getParameter("email").equals(""))
                    || ! request.getParameter("username").equals(""))
                    && session.getAttribute("loggedIn") == null){
                //Validate input
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String repPassword = request.getParameter("reppassword");
                
                //New validator
                //validator.validatePassword
                //validator.validateEmail
                //Input is OKAY
                //EncryptPassword
                
                BasicPasswordEncryptor passwordEncryptor = new BasicPasswordEncryptor();
                String passHash = passwordEncryptor.encryptPassword(password);
                
                try {
                    DatabaseHandler db = new DatabaseHandler();
                    db.executeUpdate(" INSERT INTO User (username, email, passHash)"
                        + "VALUES (\""+ username +"\",\""+ email +"\",\"" + passHash +"\"); ");
                } catch(Exception e){
                    //uh oh, database error
                    out.println("<p>Bad shit!</p>");
                }
                out.println("<p>New User created!</p>");
                //Login the new user
                LoginHandler loginHandler = new LoginHandler();
                loginHandler.login(email, password, session);
            }
                if (request.getParameter("domain") != null
                        && session.getAttribute("loggedIn")!= null) {
                    //validate domain name
                    String domain = request.getParameter("domain");
                    //Create domain
                    
                    ServerConfigure conf = new ServerConfigure();
                    conf.addVirtualHost(domain, "UserSiteApp");
                    out.println("<p>New Domain Created!</p>");
                }
            }
        
            //If user has filled in new User form and is not logged in
            
        
        
            
        %>
        <!--If Errors, print errors and highlight inputs!-->
        
        <%@include file="WEB-INF/jspf/newSiteForm.jspf" %>
        
           
        </section>
    </body>
</html>
