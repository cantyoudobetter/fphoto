/******************************************************
 * File: Section.java
 * created Dec 16, 2001 7:08:14 PM by mike.bordelon
 */
package com.familyutil;


public class Section {

    private int sectionID;
    private int familyID;
    private String shortDescription;
    private String longDescription;
    private int sortOrder;

    Section() {
    }

    Section(
            int newSectionID,
            int newFamilyID,
            String newShortDescription,
            String newLongDescription,
            int newSortOrder
            ) {
        this.setSectionID(newSectionID);
        this.setFamilyID(newFamilyID);
        this.setShortDescription(newShortDescription);
        this.setLongDescription(newLongDescription);
        this.setSortOrder(newSortOrder);
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

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int newSortOrder) {
        sortOrder = newSortOrder;
    }


    public int getSectionID() {
        return sectionID;
    }

    public void setSectionID(int newSectionID) {
        sectionID = newSectionID;
    }

    public String getShortDescription() {
        return shortDescription.trim();
    }

    public void setShortDescription(String newShortDescription) {
        shortDescription = newShortDescription;
    }

    public String getLongDescription() {
        return longDescription.trim();
    }

    public void setLongDescription(String newLongDescription) {
        longDescription = newLongDescription;
    }


}