/******************************************************
 * File: User.java
 * created Dec 9, 2001 9:53:02 PM by mike.bordelon
 */
package com.familyutil;


public class User {

    private int userID;
    private String userName;
    private String password;
    private int userTypeID;
    private String name;
    private String email;
    private boolean notify;

    User() {
    }

    User(int newUserID,
         String newUserName,
         String newPassword,
         int newUserTypeID,
         String newName,
         String email,
         boolean notify
         ) {
        this.setUserID(newUserID);
        this.setUserName(newUserName);
        this.setPassword(newPassword);
        this.setUserTypeID(newUserTypeID);
        this.setName(newName);
        this.setEmail(email);
        this.setNotify(notify);
    }

    public Object clone() {
        try {
            return super.clone();
        } catch (CloneNotSupportedException e) {
            // This should never happen
            throw new InternalError(e.toString());
        }
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int newUserID) {
        userID = newUserID;
    }

    public String getUserName() {
        return userName.trim();
    }

    public void setUserName(String newUserName) {
        userName = newUserName;
    }

    public String getPassword() {
        return password.trim();
    }

    public void setPassword(String newPassword) {
        password = newPassword;
    }

    public int getUserTypeID() {
        return userTypeID;
    }

    public void setUserTypeID(int newUserTypeID) {
        userTypeID = newUserTypeID;
    }


    public String getName() {
        return name.trim();
    }

    public void setName(String newName) {
        name = newName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean getNotify() {
        return notify;
    }

    public void setNotify(boolean notify) {
        this.notify = notify;
    }

}