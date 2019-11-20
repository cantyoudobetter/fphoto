/******************************************************
 * File: Family.java
 * created Dec 11, 2001 9:41:06 PM by mike.bordelon
 */
package com.familyutil;


public class Family {

    private int familyID;
    private String description;
    private boolean isActive;
    private String secret;
    private String secretQuestion;
    private String authMail;
    private String messageOfTheDay;
    private String backColor;
    private String fontColor;
    
    private String fontName;

    Family() {
    }

    Family(
            int newFamilyID,
            String newDescription,
            boolean newIsActive,
            String newSecret,
            String newSecretQuestion,
            String newAuthMail,
            String newMessageOfTheDay,
            String newBackColor,
            String newFontColor,
            String newFontName
            ) {
//test            	
        this.setFamilyID(newFamilyID);
        this.setDescription(newDescription);
        this.setIsActive(newIsActive);
        this.setSecret(newSecret);
        this.setSecretQuestion(newSecretQuestion);
        this.setAuthMail(newAuthMail);
        this.setMessageOfTheDay(newMessageOfTheDay);
        this.setBackColor(newBackColor);
        this.setFontColor(newFontColor);
        this.setFontName(newFontName);
    }

    public Object clone() {
        try {
            return super.clone();
        } catch (CloneNotSupportedException e) {
            // This should never happen
            throw new InternalError(e.toString());
        }
    }

    public int getFamilyID() {
        return familyID;
    }

    public void setFamilyID(int newFamilyID) {
        familyID = newFamilyID;
    }

    public String getDescription() {
        return description.trim();
    }

    public void setDescription(String newDescription) {
        description = newDescription;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean newIsActive) {
        isActive = newIsActive;
    }

    public String getSecret() {
        return secret.trim();
    }

    public void setSecret(String newSecret) {
        secret = newSecret;
    }

    public String getSecretQuestion() {
        return secretQuestion.trim();
    }

    public void setSecretQuestion(String newSecretQuestion) {
        secretQuestion = newSecretQuestion;
    }

    public String getAuthMail() {
        return authMail.trim();
    }

    public void setAuthMail(String newAuthMail) {
        authMail = newAuthMail;
    }

    public String getMessageOfTheDay() {
        return messageOfTheDay.trim();
    }

    public void setMessageOfTheDay(String newMessageOfTheDay) {
        messageOfTheDay = newMessageOfTheDay;
    }

    public String getBackColor() {
        return backColor.trim();
    }

    public void setBackColor(String newBackColor) {
        backColor = newBackColor;
    }

    public String getFontColor() {
        return fontColor.trim();
    }

    public void setFontColor(String newFontColor) {
        fontColor = newFontColor;
    }

    public String getFontName() {
        return fontName.trim();
    }

    public void setFontName(String newFontName) {
        fontName = newFontName;
    }
}
