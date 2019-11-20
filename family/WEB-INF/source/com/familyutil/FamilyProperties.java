/******************************************************
 * File: FamilyProperties.java
 * created Dec 9, 2001 5:57:12 PM by mike.bordelon
 */
package com.familyutil;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.MissingResourceException;

/**
 * Singleton class
 */
public final class FamilyProperties {


    //private variables
    private static FamilyProperties _instance = null;
    private static File propFile;
    protected Properties zionProperties;
    private static String propFileName = null;

    //Database Settings
    public static String DBSERVER;
    public static String DBNAME;
    public static String DBUSER;
    public static String DBPASSWORD;
    public static String DBPORT;
    public static String PHOTODIR;
    public static String SMTPSERVER;
    public static String SITEURL;
    public static String FROMEMAIL;

    static {
        if (_instance == null) {
            _instance = new FamilyProperties();
        }
    }

    /**
     * Retrieves values from properties file and sets static variables
     *
     */
    private void getProperties() {

        ResourceBundle rb = null;
        try {
            rb = ResourceBundle.getBundle("Family");
        } catch (MissingResourceException e) {
            System.out.println("Family.properties is missing!");
        }
        //set static variables from property file settings
        if (rb != null) {
            setStaticVariables(rb);
        } else {
            System.out.println("Family.properties is null");
        }
    }

    /**
     * Returns the only instance of this class.
     *
     * @return FamilyPropertieses The only instance of this class.
     */

    public static FamilyProperties getInstance() {
        return _instance;
    }


    /**
     * <BR>This method lists the properties and values.
     */
    public void listProperties() {
        zionProperties.list(System.out);
    }

    /**
     * Private constructor prevents others from creating
     * instances of this class.
     */
    private FamilyProperties() {
        System.out.println("In FamilyProperties constructor");
        getProperties();
    }

    /**
     * <BR>This method sets the static variables with the property file values.
     */
    protected void setStaticVariables(ResourceBundle rb) {

        DBSERVER = rb.getString("DBSERVER");
        DBNAME = rb.getString("DBNAME");
        DBUSER = rb.getString("DBUSER");
        DBPASSWORD = rb.getString("DBPASSWORD");
        DBPORT = rb.getString("DBPORT");
        PHOTODIR = rb.getString("PHOTODIR");
        SMTPSERVER = rb.getString("SMTPSERVER");
        SITEURL = rb.getString("SITEURL");
        FROMEMAIL = rb.getString("FROMEMAIL");

    }

    /**
     * This method gets a property value
     *
     */
    protected void getPropertyValue(String propertyName) {
        zionProperties.getProperty(propertyName);
    }

}
