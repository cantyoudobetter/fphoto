/******************************************************
 * File: DAO.java
 * created Dec 1, 2001 12:04:32 AM by root
 */

package com.familyutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Logger;
import java.util.logging.Level;


public class DAO {
    String connectionURL = null;
    String DBUser = null;
    // Test
    String DBName = null;
    String DBPass = null;
    
    

    private static Logger logger = Logger.getLogger("com.familyutil.DAO");

    public DAO() {
        FamilyProperties zionProperties = FamilyProperties.getInstance();
        String DBServer = zionProperties.DBSERVER.trim();
        DBName = zionProperties.DBNAME.trim();
        String DBPort = zionProperties.DBPORT.trim();
        DBUser = zionProperties.DBUSER.trim();
        DBPass = zionProperties.DBPASSWORD.trim();

        //connectionURL = "jdbc:mysql://" + DBServer + ":" + DBPort + "/" + DBName;

    }

    public ArrayList getUserList() {
        Connection connection = null;
        Statement statement = null;
        ArrayList list = new ArrayList();
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from user");
            while (resultSet.next()) {
                boolean notify = false;
                User user = null;
                if (resultSet.getInt("notify") > 0) {
                    notify = true;
                }

                list.add(new User(resultSet.getInt("userid"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getInt("usertypeid"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        notify
                ));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Exception in getUserList ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Exception in getUserList connection.close ", e);
            }
        }
        return list;
    }

    public void deleteUserFamilyXref(int userID, int familyID) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection = getConnection();
            statement = connection.createStatement();
            String sql = "delete from userfamilyxref where userid=" + userID + " and familyid=" + familyID;
            statement.execute(sql);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Exception in deleteUserFamilyXref ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Exception in deleteUserFamilyXref connection.close ", e);
            }
        }
    }

    public User getUser(int userID) {
        Connection connection = null;
        Statement statement = null;
        User user = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from user where userID = " + userID);
            if (resultSet.next()) {
                boolean notify = false;
                if (resultSet.getInt("notify") > 0) {
                    notify = true;
                }

                user = new User(resultSet.getInt("userid"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getInt("usertypeid"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        notify
                );
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Exception in getUser(int userID) ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Exception in getUser(int userID) connection.close ", e);
            }
        }
        return user;
    }

    public User getUser(String userName) {
        Connection connection = null;
        Statement statement = null;
        User user = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from user where username = '" + userName + "'");
            if (resultSet.next()) {
                boolean notify = false;
                if (resultSet.getInt("notify") > 0) {
                    notify = true;
                }
                user = new User(resultSet.getInt("userid"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getInt("usertypeid"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        notify
                );
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Exception in getUser(String userName) ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Exception in getUser(String userName) connection.close ", e);
            }
        }
        return user;
    }

    public boolean checkUser(String userName, String password) {
        Connection connection = null;
        Statement statement = null;
        boolean check = false;
        if (((userName != null) && (userName.length() > 0)) && ((password != null) && (password.length() > 0))) {
            try {
                ResultSet resultSet = null;
                connection = getConnection();
                statement = connection.createStatement();
                String sql = "select * from user where username = '" + userName.trim() + "' AND password = '" + password.trim() + "'";
                resultSet = statement.executeQuery(sql);
                if (resultSet.next()) {
                    check = true;
                } else {
                    System.out.println("Login Failed for " + userName + ":" + password);
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Exception in checkUser(String userName, String password) ", e);
            } finally {
                try {
                    if (connection != null) {
                        connection.close();
                    }
                } catch (Exception e) {
                    logger.log(Level.SEVERE, "Exception in checkUser(String userName, String password) connection.close", e);
                }
            }
        }
        return check;
    }

    public ArrayList getUserListForFamily(int familyID) {
        Connection connection = null;
        Statement statement = null;
        ArrayList list = new ArrayList();
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select u.userid from user u, userfamilyxref ufx where u.userid = ufx.userid and ufx.familyid = " + familyID);
            while (resultSet.next()) {
                list.add(this.getUser(resultSet.getInt("userID")));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Exception in getUserListForFamily(int familyID) ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Exception in getUserListForFamily(int familyID) connection.close ", e);
            }
        }
        return list;
    }

    public boolean checkUser(String userName) {
        Connection connection = null;
        Statement statement = null;
        boolean check = false;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            String sql = "select * from user where username = '" + userName.trim() + "'";
            resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                check = true;
            } else {
                check = false;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in checkUser ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in checkUser ", e);
            }
        }
        return check;
    }

    public Family getFamily(int familyID) {
        Connection connection = null;
        Statement statement = null;
        Family family = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from family where familyID = " + familyID);
            if (resultSet.next()) {
                boolean isActive = false;
                if (resultSet.getInt("isActive") == 1) {
                    isActive = true;
                }
                family = new Family(resultSet.getInt("familyid"),
                        resultSet.getString("description"),
                        isActive,
                        resultSet.getString("secret"),
                        resultSet.getString("secretquestion"),
                        resultSet.getString("authmail"),
                        resultSet.getString("messageoftheday"),
                        resultSet.getString("backcolor"),
                        resultSet.getString("fontcolor"),
                        resultSet.getString("fontname")
                );
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getFamily ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getFamily ", e);
            }
        }
        return family;
    }


    public ArrayList getFamilyListForUser(int userID) {
        Connection connection = null;
        Statement statement = null;
        ArrayList list = new ArrayList();
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select F.familyid from family F, userfamilyxref UFX where UFX.familyid = F.familyid and UFX.userid = " + userID);
            while (resultSet.next()) {
                list.add(this.getFamily(resultSet.getInt("familyID")));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getFamilyListForUser ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getFamilyListForUser ", e);
            }
        }
        return list;
    }

    public ArrayList getFamilyList() {
        Connection connection = null;
        Statement statement = null;
        ArrayList list = new ArrayList();
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();

            resultSet = statement.executeQuery("select familyid from family");
            while (resultSet.next()) {
                Family family = this.getFamily(resultSet.getInt("familyid"));
                //System.out.println(family.getDescription());
                list.add(family);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getFamilyList ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getFamilyList ", e);
            }
        }
        return list;
    }

    public void createUser(String userName, String password, int userTypeID, String name, int familyid, String email, boolean notify) {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            userName = convString(userName);
            password = convString(password);
            name = convString(name);
            email = convString(email);
            int n = 0;
            if (notify) n = 1;
            String sql = "Insert into user (username,password,usertypeid,name,email,notify) values ('" + userName + "','" + password + "','" + userTypeID + "','" + name + "','" + email + "'," + n + ")";
            statement.execute(sql);
            resultSet = statement.executeQuery("CALL IDENTITY()");
            int userid = 0;
            if (resultSet.next()) {
                userid = resultSet.getInt(1);
            }
            sql = "Insert into userfamilyxref (userid,familyid) values ('" + userid + "','" + familyid + "')";
            statement.execute(sql);


        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in createUser ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in createUser ", e);
            }
        }
    }

    public void createAdminUser(String userName, String password, String name, int familyid) {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            String sql = "Insert into user (username,password,usertypeid,name) values ('" + userName + "','" + password + "'," + 0 + ",'" + name + "')";
            statement.execute(sql);
            resultSet = statement.executeQuery("CALL IDENTITY()");
            int userid = 0;
            if (resultSet.next()) {
                userid = resultSet.getInt(1);
            }
            sql = "Insert into userfamilyxref (userid,familyid) values ('" + userid + "','" + familyid + "')";
            statement.execute(sql);


        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in createAdminUser ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in createAdminUser ", e);
            }
        }
    }

    public void updateUser(int userID, String password, String name, String email, boolean notify) {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            password = convString(password);
            name = convString(name);
            email = convString(email);
            int n = 0;
            if (notify) n = 1;

            String sql = "Update user set ";
            sql = sql + "password = '" + password + "'";
            sql = sql + ", name = '" + name + "'";
            sql = sql + ", email = '" + email + "'";
            sql = sql + ", notify = " + n;
            sql = sql + " where userid = " + userID;
            statement.execute(sql);
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in updateUser ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in updateUser ", e);
            }
        }
    }

    public void createUserFamilyXref(int userID, int familyID) {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            String sql = "Insert into userfamilyxref (userid,familyid) values ('" + userID + "','" + familyID + "')";
            statement.execute(sql);

        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in createUserFamilyXref ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in createUserFamilyXref ", e);
            }
        }
    }

    public void removeUserFamilyXref(int userID, int familyID) {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            String sql = "Delete from userfamilyxref where userid = " + userID + " AND familyID = " + familyID;
            statement.execute(sql);

        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in removeUserFamilyXref ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in removeUserFamilyXref ", e);
            }
        }
    }

    public int createFamily(String description, boolean isActive, String secret, String secretQuestion, String authMail, String messageOfTheDay, String backColor, String fontColor, String fontName) {
        Connection connection = null;
        Statement statement = null;
        int familyid = 0;
        try {
            ResultSet resultSet = null;
            int isActiveint = 0;
            if (isActive) {
                isActiveint = 1;
            }
            connection = getConnection();
            statement = connection.createStatement();
            description = convString(description);
            secret = convString(secret);
            secretQuestion = convString(secretQuestion);
            messageOfTheDay = convString(messageOfTheDay);

            String sql = "Insert into family (description, isactive, secret, secretquestion, authmail, messageoftheday, backcolor, fontcolor, fontname)";
            sql = sql + "values ('" + description + "','" + isActiveint + "','" + secret + "','" + secretQuestion + "','" + authMail + "','" + messageOfTheDay + "','" + backColor + "','" + fontColor + "','" + fontName + "')";
            statement.execute(sql);
            resultSet = statement.executeQuery("CALL IDENTITY()");
            if (resultSet.next()) {
                familyid = resultSet.getInt(1);
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in createFamily ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in createFamily ", e);
            }
        }
        return familyid;
    }

    public void updateFamily(int familyID, String description, boolean isActive, String secret, String secretQuestion, String authMail, String messageOfTheDay, String backColor, String fontColor, String fontName) {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            description = convString(description);
            secret = convString(secret);
            secretQuestion = convString(secretQuestion);
            messageOfTheDay = convString(messageOfTheDay);

            String sql = "Update family set ";
            sql = sql + "description = '" + description + "'";
            sql = sql + ", secret = '" + secret + "'";
            sql = sql + ", secretquestion = '" + secretQuestion + "'";
            sql = sql + ", authmail = '" + authMail + "'";
            sql = sql + ", messageoftheday = '" + messageOfTheDay + "'";
            sql = sql + ", backcolor = '" + backColor + "'";
            sql = sql + ", fontcolor = '" + fontColor + "'";
            sql = sql + ", fontname = '" + fontName + "'";
            sql = sql + " where familyid = " + familyID;

            statement.execute(sql);
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in updateFamily ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in updateFamily ", e);
            }
        }
    }

    public void createSection(int familyID, String shortDescription, String longDescription) {
        Connection connection = null;
        Statement statement = null;
        int sectionID = 0;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            shortDescription = convString(shortDescription);
            String sql = "Insert into section (familyid, shortdescription, longdescription)";
            sql = sql + " values (" + familyID + ",'" + shortDescription + "','" + longDescription + " ')";
            statement.execute(sql);
            resultSet = statement.executeQuery("CALL IDENTITY()");
            if (resultSet.next()) {
                sectionID = resultSet.getInt(1);
            }

            this.updateSectionSortOrder(sectionID, this.getNextSectionSortOrder(familyID));
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in createSection ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in createSection ", e);
            }
        }
    }

    public void updateSection(int sectionID, String shortDescription, String longDescription) {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            shortDescription = convString(shortDescription);
            String sql = "Update section set shortdescription = '" + shortDescription + "', longdescription = '" + longDescription + "'";
            sql = sql + " where sectionid = " + sectionID;
            statement.execute(sql);
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in updateSection ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in updateSection ", e);
            }
        }
    }

    public void updateSectionSortOrder(int sectionID, int newSortOrder) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection = getConnection();
            statement = connection.createStatement();
            String sql = "Update section set sortorder = " + newSortOrder;
            sql = sql + " where sectionid = " + sectionID;
            statement.execute(sql);
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in updateSectionSortOrder ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in updateSectionSortOrder ", e);
            }
        }
    }

    public void updatePhotoSortOrder(int photoID, int newSortOrder) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection = getConnection();
            statement = connection.createStatement();
            String sql = "Update photo set sortorder = " + newSortOrder;
            sql = sql + " where photoid = " + photoID;
            statement.execute(sql);
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in updatePhotoSortOrder ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in updatePhotoSortOrder ", e);
            }
        }
    }

    public void swapPhotoSection(int photoID, int sectionID) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection = getConnection();
            statement = connection.createStatement();

            String sql = "Update photo set sectionid = " + sectionID;
            sql = sql + " where photoid = " + photoID;
            statement.execute(sql);
            this.updatePhotoSortOrder(photoID, this.getNextPhotoSortOrder(sectionID));

        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in swapPhotoSortOrder ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in swapPhotoSortOrder ", e);
            }
        }
    }

    public ArrayList getSectionsForFamily(int familyID) {
        Connection connection = null;
        Statement statement = null;
        ArrayList list = new ArrayList();
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from section where familyid = " + familyID + " order by sortorder desc");
            while (resultSet.next()) {
                list.add(this.getSection(resultSet.getInt("sectionid")));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getSectionsForFamily ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getSectionsForFamily ", e);
            }
        }
        return list;
    }

    public Section getSection(int sectionID) {
        Connection connection = null;
        Statement statement = null;
        Section section = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from section where sectionID = " + sectionID);
            if (resultSet.next()) {
                section = new Section(resultSet.getInt("sectionid"),
                        resultSet.getInt("familyid"),
                        resultSet.getString("shortdescription"),
                        resultSet.getString("longdescription"),
                        resultSet.getInt("sortorder")
                );
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getSection ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getSection ", e);
            }
        }
        return section;
    }

    public void deleteSection(int sectionID) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection = getConnection();
            statement = connection.createStatement();
            statement.execute("delete from section where sectionid = " + sectionID);

        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in deleteSection ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in deleteSection ", e);
            }
        }
    }

    public void createPhoto(int sectionID, String photoName, String thumbName) {
        Connection connection = null;
        Statement statement = null;
        int photoID = 0;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            String sql = "Insert into photo (sectionid, photoname, thumbname)";
            sql = sql + "values ('" + sectionID + "','" + photoName + "','" + thumbName + "')";
            statement.execute(sql);
            resultSet = statement.executeQuery("CALL IDENTITY()");
            if (resultSet.next()) {
                photoID = resultSet.getInt(1);
            }
            this.updatePhotoSortOrder(photoID, this.getNextPhotoSortOrder(sectionID));

        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in createPhoto ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in createPhoto ", e);
            }
        }
    }


    public ArrayList getPhotosForSection(int sectionID) {
        Connection connection = null;
        Statement statement = null;
        ArrayList list = new ArrayList();
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from photo where sectionid = " + sectionID + " order by sortorder desc");
            while (resultSet.next()) {
                list.add(this.getPhoto(resultSet.getInt("photoid")));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getPhotosForSection ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getPhotosForSection ", e);
            }
        }
        return list;
    }

    public Photo getPhoto(int photoID) {
        Connection connection = null;
        Statement statement = null;
        Photo photo = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from photo where photoID = " + photoID);
            if (resultSet.next()) {
                photo = new Photo(resultSet.getInt("photoid"),
                        resultSet.getInt("sectionid"),
                        resultSet.getString("photoname"),
                        resultSet.getString("thumbname"),
                        resultSet.getInt("sortorder")
                );
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getPhoto ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getPhoto ", e);
            }
        }
        return photo;
    }

    public int getNextSectionSortOrder(int familyID) {
        Connection connection = null;
        Statement statement = null;
        int sortOrder = 0;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select max(sortorder) as SO from section where familyID = " + familyID);
            if (resultSet.next()) {
                sortOrder = resultSet.getInt("SO");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getNextSectionSortOrder ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getNextSectionSortOrder ", e);
            }
        }
        return sortOrder + 1;
    }

    public int getNextPhotoSortOrder(int sectionID) {
        Connection connection = null;
        Statement statement = null;
        int sortOrder = 0;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select max(sortorder) as SO from photo where sectionID = " + sectionID);
            if (resultSet.next()) {
                sortOrder = resultSet.getInt("SO");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getNextPhotoSortOrder ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getNextPhotoSortOrder ", e);
            }
        }
        return sortOrder + 1;
    }


    public void deletePhoto(int photoID) {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            statement.execute("delete from photo where photoid = " + photoID);

        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in deletePhoto ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in deletePhoto ", e);
            }
        }
    }


    public void createPhotoNote(int photoID, int userID, String note) {
        Connection connection = null;
        Statement statement = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            note = convString(note);
            String sql = "Insert into photonote (photoid, userid, note)";
            sql = sql + "values ('" + photoID + "','" + userID + "','" + note + "')";
            //resultSet = statement.executeQuery(sql);
            statement.execute(sql);
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in createPhotoNote ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in createPhotoNote ", e);
            }
        }
    }


    public ArrayList getNotesForPhoto(int photoID) {
        Connection connection = null;
        Statement statement = null;
        ArrayList list = new ArrayList();
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from photonote where photoid = " + photoID);
            while (resultSet.next()) {
                list.add(this.getPhotoNote(resultSet.getInt("photonoteid")));
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getNotesForPhoto ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getNotesForPhoto ", e);
            }
        }
        return list;
    }

    public PhotoNote getPhotoNote(int photoNoteID) {
        Connection connection = null;
        Statement statement = null;
        PhotoNote photoNote = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from photonote where photonoteid = " + photoNoteID);
            if (resultSet.next()) {
                photoNote = new PhotoNote(resultSet.getInt("photonoteid"),
                        resultSet.getInt("photoid"),
                        resultSet.getString("note"),
                        resultSet.getInt("userid")
                );
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in getPhotoNote ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in getPhotoNote ", e);
            }
        }
        return photoNote;
    }

    public void deletePhotoNote(int photoNoteID) {
        Connection connection = null;
        Statement statement = null;
        Section section = null;
        try {
            ResultSet resultSet = null;
            connection = getConnection();
            statement = connection.createStatement();
            statement.execute("delete from photonote where photonoteid = " + photoNoteID);

        } catch (Exception e) {
            logger.log(Level.SEVERE, " exception in deletePhotoNote ", e);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, " exception in deletePhotoNote ", e);
            }
        }
    }

    private Connection getConnection() {
        Connection connection = null;

        try {
            //Class.forName("org.gjt.mm.mysql.Driver").newInstance();
            Class.forName("org.hsqldb.jdbcDriver");//.newInstance();
            connection = DriverManager.getConnection("jdbc:hsqldb:" + DBName, "sa", "");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Exception in getConnection() ", e);
        }

        return connection;
    }

    public String convString(String t) {

        t = replaceEscape(t, "\\", "\\\\"); // replace backslash with \\
        t = replaceEscape(t, "'", "\''");  // replace an single quote with \'
        t = replaceEscape(t, "\"", "\\\""); // replace a double quote with \"
        t = replaceEscape(t, "\r", "\\r"); // replace CR with \r;
        t = replaceEscape(t, "\n", "\\n"); // replace LF with \n;

        return t;
    }

    public static String replaceEscape(String subject, String original, String replacement) {
        StringBuffer output = new StringBuffer();

        int p = 0;
        int i;
        while ((i = subject.indexOf(original, p)) != -1) {
            output.append(subject.substring(p, i));
            output.append(replacement);
            p = i + original.length();
        }
        if (p < subject.length())
            output.append(subject.substring(p));
        return output.toString();
    }


}