/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Group2Project.CMSadministrator;

/**
 * Represents an Error message that should be displayed to the user
 * @author Éanna
 */
public class CMSError {
    private String errorMessage;
    
    public CMSError( String errorMessage){
        this.errorMessage=errorMessage;
    }
    
    @Override
    public String toString(){
        return errorMessage;
    }
}
