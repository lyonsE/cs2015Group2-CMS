<%-- 
    Document   : index
    Created on : 11-Feb-2014, 15:13:08
    Author     : Éanna
--%>

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
        
        <nav>
            <ul>
               <a href="index.jsp">Home</a>
               <a href="newSite.jsp">SignUp</a> 
            </ul>
            
        </nav>
        
        <section id="login">
            <form  method="POST" action="newSite.jsp">
                <label for="username" >Username</label><input type="text" name="username"/>
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
