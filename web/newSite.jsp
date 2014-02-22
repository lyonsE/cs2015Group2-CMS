<%-- 
    Document   : index
    Created on : 11-Feb-2014, 15:13:08
    Author     : Éanna
--%>
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
        <header>
            <h1>Charity Management System</h1>
            <h3>I like sausages</h3>
        </header>
        
        <% 
            //Is logged in?
            //New Domain form
            
            //New user and Site form
            
            if (request.getParameterNames().hasMoreElements()) {
                //Validate input
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String repPassword = request.getParameter("reppassword");
                String domain = request.getParameter("domain");
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
            }
        %>
        <!--If Errors, print errors and highlight inputs!-->
        <section id="signUp">
            <form  method="POST" action="newSite.jsp">
                
                <label for="username" >Username</label>
                <input type="text" name="username"/>
                <label for="email" >Email</label>
                <input type="text" name="email"/>
                <label for="password" >Password</label>
                <input type="password" name="password"/>
                <label for="reppassword" >Repeat Password</label>
                <input type="password" name="reppassword"/>
                
                <label for="domain" >Domain</label>
                <input type="text" name="domain"/>
                <input type="submit"/>;
                
                
                <p>TEMPLATE PICKER</p>
                <p>You can change template at a later date</p>
                
            </form>
        </section>
        
        
        
        </section>
    </body>
</html>
