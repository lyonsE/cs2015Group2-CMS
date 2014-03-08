<%-- 
    Document   : index
    Created on : 11-Feb-2014, 15:13:08
    Author     : Éanna
--%>
<%@page import="java.net.URI"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Group2Project.CMSadministrator.CMSError"%>
<%@page import="com.Group2Project.CMSadministrator.InputValidator"%>
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
        ServletContext sc = session.getServletContext();
        
        String file = new File(sc.getRealPath("/WEB-INF/SQLscripts/UserSite.sql")).getAbsolutePath();
         out.println(file);
            //Is logged in?
            //New Domain form
            
            //New user and Site form
        if (request.getParameterNames().hasMoreElements()) {
            try {
                DatabaseHandler db = new DatabaseHandler();    
            
            //Create a validater
            
            ArrayList<CMSError> errors = new ArrayList<CMSError>();
            InputValidator validator = new InputValidator( errors );
            String username = request.getParameter("username");
            String email = request.getParameter("email");       
            if ((username != null && ! username.equals(""))
                && (email != null && ! email.equals(""))
                && session.getAttribute("loggedIn") == null){
                //Validate input
                
                String password = request.getParameter("password");
                String repPassword = request.getParameter("reppassword");

                //New validator

                validator.validateUsername(username);
                validator.validatePassword(password, repPassword);
                validator.validateEmail( email);
                //Input is OKAY


                //EncryptPassword
                if (errors.size()==0){
                    BasicPasswordEncryptor passwordEncryptor =
                            new BasicPasswordEncryptor();
                    String passHash = passwordEncryptor.encryptPassword(password);   
                    db.executeUpdate(" INSERT INTO User (username, email, passHash)"
                        + "VALUES (\""+ username +"\",\""
                            + email +"\",\"" + passHash +"\"); ");

                    out.println("<p>New User created!</p>");
                    //Login the new user
                    LoginHandler loginHandler = new LoginHandler();
                    loginHandler.login(email, password, session);
                }

            }
            
            if (request.getParameter("domain") != null
                    && session.getAttribute("loggedIn")!= null) {
                //validate domain name

                String domain = request.getParameter("domain");
                //Create domain
                validator.validateDomainName(domain);
                if (errors.size()==0){
                    //CHECK FIRST FOR DUPLICATES
                    ResultSet results =db.executeQuery("SELECT domainName "
                    + "FROM site WHERE domainName = \"" +domain + "\";");
                    
                    if (! results.next()){
                        ServerConfigure conf = new ServerConfigure();
                        conf.addVirtualHost(domain, "UserSiteApp");
                        db.executeUpdate("INSERT INTO site( domainName ) VALUES (\""
                            + domain + "\");");
                        db.executeUpdate("INSERT INTO owns ( userId, siteId)"
                            + "VALUES ((SELECT userId from user WHERE email =\""
                            + session.getAttribute("loggedIn")+ "\" ),"
                            + "(SELECT siteId FROM site WHERE domainName =\""
                            + domain + "\"));");

                        
                        String newDatabase = "userSite"+ domain.replaceAll("\\.", "_");
                        out.println("new Database: "+ newDatabase);
                        
                        db.executeUpdate("CREATE DATABASE "+ newDatabase + ";");
                        
                        db.executeUpdate("USE " + newDatabase + ";");
                        try {
                           
                            //ContextPath returns the Web-Inf directory
                            db.executeScript(new File(sc.getRealPath("/WEB-INF/SQLscripts/UserSite.sql")));
                        } catch (FileNotFoundException e){
                            out.println("File not found");
                        }
                        
                        db.closeConnection();
                        
                        out.println("<p>New Domain Created!</p>");
                    } else {
                    errors.add(new CMSError("This domain has already been registered"));
                    }
                }
            }
            
            if (errors.size()>0){
                        out.println("<ul>");
                        for (int i=0; i<errors.size();i++){
                            out.println("<li>");
                            out.println(errors.get(i));
                            out.println("</li>");
                        }

                        out.println("</ul>");
                    }
        } catch(Exception e){
                //uh oh, database error
                out.println("<p>Bad shit!</p>");
                e.printStackTrace();
            }
        }
            //If user has filled in new User form and is not logged in
        %>
        <!--If Errors, print errors and highlight inputs!-->
        
        <%@include file="WEB-INF/jspf/newSiteForm.jspf" %>
        
           
        </section>
    </body>
</html>
