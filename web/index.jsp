<%-- 
    Document   : index
    Created on : 11-Feb-2014, 15:13:08
    Author     : Éanna
--%>

<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Group2Project.CMSadministrator.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Charity Management System</title>
    </head>
    
    
    <body>
        
        
        <%@include file="WEB-INF/jspf/header.jspf" %>
        
        
        <% if (request.getParameterNames().hasMoreElements()) {
                //Validate input
               if (request.getParameter("email")!= null
                       && request.getParameter("password") != null) {
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    //Input is OKAY
                    //CreateValidater
                    InputValidator validator = new InputValidator();
                    //Validate input
                    validator.validateEmail(email);
                    validator.validatePassword(password, password);
                    
                    ArrayList<CMSError> errors = validator.getErrors();
                    
                    if (errors.size()==0){
                        LoginHandler loginHandler = new LoginHandler(errors);
                        loginHandler.login(email,password, session);
                    
                    }
                    
                    if (errors.size()>0){
                        out.println("<ul>");
                        for (int i=0; i<errors.size();i++){
                            out.println("<li>");
                            out.println(errors.get(i));
                            out.println("</li>");
                        }

                        out.println("</ul>");
                    } else {
                        out.println("<p>Logged in successfully</p>");
                    }
                    
               }
               
               if ( request.getParameter("logout") != null){
                   session.setAttribute("loggedIn", null);
               }
                
                
            }
        File test = new File("../conf/test.txt");
        out.println(test.getCanonicalPath());
        test.createNewFile();
        %>
        <%@include file="WEB-INF/jspf/nav.jspf" %>
        <section id="login">
            <form  method="POST" action="index.jsp">
                <label for="email" >Email</label><input type="text" name="email"/>
                <label for="password" >Password</label><input type="password" name="password"/>
                <input type="submit"/>
            </form>
        </section>
        
        <section>
            <h3>Butts</h3>
            <a href="newSite.jsp"> Sign up and create a site!</a>
        </section>
        
        
        
        </section>
    </body>
</html>
