/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.Group2Project.CMSadministrator;

import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.xml.sax.SAXException;

/**
 *
 * @author Éanna
 */
public class ServerConfigure {
    public void addVirtualHost(String domainName, String webapp){
        try {
            //open document
            String filepath = "../conf/server.xml";
            DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
            Document doc = docBuilder.parse(filepath);
            
            
            //get Root
            Node engine = doc.getElementsByTagName("Engine").item(0);
            Element newHost = doc.createElement("Host");
            newHost.setAttribute("name", domainName);
            newHost.setAttribute("appBase", webapp);
            newHost.setAttribute("unpackWARs", "true");
            newHost.setAttribute("autoDeploy", "true");
            
            engine.appendChild(newHost);
            
            
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
		Transformer transformer = transformerFactory.newTransformer();
		DOMSource source = new DOMSource(doc);
		StreamResult result = new StreamResult(new File(filepath));
		transformer.transform(source, result);
            //add attributes
            //add attributes
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(ServerConfigure.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(ServerConfigure.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ServerConfigure.class.getName()).log(Level.SEVERE, null, ex);
        } catch (TransformerException ex) {
            Logger.getLogger(ServerConfigure.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
