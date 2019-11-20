/******************************************************
 * File: Photo.java
 * created Dec 16, 2001 7:47:22 PM by mike.bordelon
 */
package com.familyutil;

public class Photo {

    private int sectionID;
    private int photoID;
    private String photoName;
    private String thumbName;
    private int sortOrder;

    Photo() {
    }

    Photo(
            int newPhotoID,
            int newSectionID,
            String newPhotoName,
            String newThumbName,
            int newSortOrder
            ) {
        this.setPhotoID(newPhotoID);
        this.setSectionID(newSectionID);
        this.setPhotoName(newPhotoName);
        this.setThumbName(newThumbName);
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

    public int getPhotoID() {
        return photoID;
    }

    public void setPhotoID(int newPhotoID) {
        photoID = newPhotoID;
    }

    public int getSectionID() {
        return sectionID;
    }

    public void setSectionID(int newSectionID) {
        sectionID = newSectionID;
    }

    public String getPhotoName() {
        return photoName.trim();
    }

    public void setPhotoName(String newPhotoName) {
        photoName = newPhotoName;
    }

    public String getThumbName() {
        return thumbName.trim();
    }

    public void setThumbName(String newThumbName) {
        thumbName = newThumbName;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int newSortOrder) {
        sortOrder = newSortOrder;
    }

}
