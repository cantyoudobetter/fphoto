package com.familyutil;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.FileReader;
import java.io.BufferedReader;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: mborde
 * Date: Oct 6, 2003
 * Time: 8:45:59 PM
 */

public class SetupDB {
    String connectionURL = null;
    String connectionURLNoDB = null;
    String DBUser = null;
    // Test
    String DBPass = null;

    private static Logger logger = Logger.getLogger("com.familyutil.DAO");

    public SetupDB() {
        FamilyProperties zionProperties = FamilyProperties.getInstance();
        String DBServer = zionProperties.DBSERVER.trim();
        String DBName = zionProperties.DBNAME.trim();
        String DBPort = zionProperties.DBPORT.trim();
        DBUser = zionProperties.DBUSER.trim();
        DBPass = zionProperties.DBPASSWORD.trim();

//        connectionURL = "jdbc:mysql://" + DBServer + ":" + DBPort + "/" + DBName;
//        connectionURLNoDB = "jdbc:mysql://" + DBServer + ":" + DBPort + "/";
        connectionURL = "jdbc:hsqldb:mdb";// + DBServer + ":" + DBPort + "/" + DBName;
        connectionURLNoDB = "jdbc:hsqldb:mdb";// + DBServer + ":" + DBPort + "/";
    }

    public void createDatabase(String host, String databaseName, String user, String pass, String port) {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getDynamicConnection(host, "", user, pass, port);
            statement = connection.createStatement();
            statement.execute("CREATE DATABASE " + databaseName);
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in setupDatbaseFromSchema ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in setupDatbaseFromSchema ", e);
            }
        }

    }

    public void setupDatabaseFromSchema(String sqlFileTxt, String host, String dbName, String user, String pass, String port) throws SQLException {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getDynamicConnection(host, dbName, user, pass, port);
            statement = connection.createStatement();
            ArrayList sqlList = parseSQLFile(sqlFileTxt);
            for (int i = 0; i < sqlList.size(); i++) {
                statement.execute(sqlList.get(i).toString());
            }
        } catch (Exception e) {

            logger.log(Level.SEVERE, " exception in setupDatbaseFromSchema ", e);
            throw new SQLException(e.getMessage());
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in setupDatbaseFromSchema ", e);
            }
        }
    }

    public ArrayList parseSQLFile(String sqlFileTxt) {
        ArrayList sqlList = new ArrayList();
        String SQLString = "";
        String temp = "";
        try {
            BufferedReader br = new BufferedReader(new FileReader(sqlFileTxt));
            while ((temp = br.readLine()) != null) {
                temp.trim();
                if (temp.length() > 0 && !temp.substring(0, 1).equals("-") && !temp.substring(0, 1).equals("#")) {
                    SQLString = SQLString + " " + temp;
                    if (SQLString.endsWith(";")) {
                        sqlList.add(SQLString);
                        SQLString = "";
                    }
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in parseSQLFile ", e);
        }
        return sqlList;
    }

    private Connection getDynamicConnection(String host, String dbName, String user, String pass, String port) {
        Connection connection = null;
        //connectionURL = "jdbc:mysql://" + host + ":" + port + "/" + dbName;
        connectionURL = "jdbc:hsqldb:"+dbName;// + host + ":" + port + "/" + dbName;


        try {
            Class.forName("org.hsqldb.jdbcDriver").newInstance();
            connection = DriverManager.getConnection(connectionURL, "sa", "");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Exception in getConnection() ", e);
        }

        return connection;
    }

}
