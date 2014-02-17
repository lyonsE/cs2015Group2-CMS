<%-- 
    Document   : index
    Created on : 11-Feb-2014, 15:13:08
    Author     : Éanna
--%>
<!-- IF Post not null
    Verify Data

            If ErrorCount==0
                Call function Create Site(user, pword, domain)
                Go to confirm.jsp
            else 
                Errors=true!-->
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
        <!--If Errors, print errors and highlight inputs!-->
        <section id="login">
            <form  method="POST" action="newSite.jsp">
                <label for="username" >Username</label>
                <input type="text" name="username"/>
                <label for="password" >Password</label>
                <input type="password" name="password"/>
                <label for="reppassword" >Repeat Password</label>
                <input type="password" name="reppassword"/>
                
                <label for="domain" >Domain</label>
                <input type="text" name="domain"/>
                
                
                <p>TEMPLATE PICKER</p>
                <p>You can change template at a later date</p>
                
            </form>
        </section>
        
        
        
        </section>
    </body>
</html>
