/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Group2Project.CMSadministrator;

import java.util.ArrayList;

/**
 * Used to Validate input from the user
 *
 * @author Éanna
 */
public class InputValidator {
    private ArrayList<CMSError> errors;
    private int maxUsernameLength;
    public InputValidator( ArrayList<CMSError> errors){
        maxUsernameLength=50;
        this.errors = errors;
    }
    
    public InputValidator(){
        this(new ArrayList<CMSError>());
    }
    /**
     * Validates that string consists of alphanumeric characters and is within a
     * minimum and maximum length
     * @param username
     * @return 
     */
    public boolean validateUsername(String username){
        boolean valid = true;
        String regex = "^[A-Za-z0-9_.,!$]{3,"+ maxUsernameLength +"}$";
        if ( ! username.matches( regex )){
            valid=false;
            errors.add( new CMSError( "Username must consist of alphanumeric characters"
                    + " and must contain at least 3 characters and less than "
                    + maxUsernameLength + " characters"));
        }
        return valid;
    }
    /**
     * 
     * @param password
     * @param repeatPassword
     * @return 
     */
    public boolean validatePassword( String password, String repeatPassword){
        boolean valid = true;
        //This regex checks for alphanumeric characters, spaces and some
        // specific, common punctuation characters
        String regex = "^[A-Za-z0-9 _.,!$]{4,}$";
        if (! password.equals(repeatPassword)){
            valid=false;
            errors.add(new CMSError("Passwords do not match"));
        }
        
        if (! password.matches(regex)){
            errors.add(new CMSError("Password must be at least 4 characters "
                    + "long and consist only of alphanumeric"
                    + " characters, spaces or the characters  ' _ . ' , ! $ ' "));
        }
        
        return valid;
    }
    /**
     * 
     * @param email
     * @return 
     */
    public boolean validateEmail( String email){
        
        boolean valid = true;
        //regex taken from the aptly named
        //http://www.regular-expressions.info/email.html
        //slightly modified to add case-insensitivity
        String regex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$";
        if (! email.matches( regex )){
            valid = false;
            errors.add(new CMSError("Invalid E-mail address"));
        }
        
        return valid;
    }
    
    public boolean validateDomainName( String domain ){
        boolean valid = true;
        String regex = "^.*$";
        if (! domain.matches(regex)){
            valid = false;
            errors.add(new CMSError("Invalid Domain name"));
        }
        return valid;
    }
    
    public ArrayList<CMSError> getErrors(){
        return errors;
    }
}
