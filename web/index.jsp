<%-- 
    Document   : index
    Created on : 11-Feb-2014, 15:13:08
    Author     : Éanna
--%>

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
        
        
        <header>
            <h1>Charity Management System</h1>
            <h3>I like sausages</h3>
        </header>
        <% if (request.getParameterNames().hasMoreElements()) {
                //Validate input
               
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                //Input is OKAY
                //CreateValidater
                //Validate input
                LoginHandler loginHandler = new LoginHandler();
                ArrayList<CMSError> errors = loginHandler.login(email,password, session);
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
        
        %>
        <nav>
            <ul>
               <a href="index.jsp">Home</a>
               <a href="newSite.jsp">SignUp</a> 
            </ul>
            
        </nav>
        
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
