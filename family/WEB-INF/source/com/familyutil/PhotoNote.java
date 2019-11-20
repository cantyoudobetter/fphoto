/******************************************************
 * File: PhotoNote.java
 * created Dec 16, 2001 8:00:25 PM by mike.bordelon
 */
package com.familyutil;

public class PhotoNote {

    private int noteID;
    private int photoID;
    private String note;
    private int userID;

    PhotoNote() {
    }

    PhotoNote(
            int newNoteID,
            int newPhotoID,
            String newNote,
            int newUserID
            ) {
        this.setNoteID(newNoteID);
        this.setPhotoID(newPhotoID);
        this.setNote(newNote);
        this.setUserID(newUserID);
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

    public int getNoteID() {
        return noteID;
    }

    public void setNoteID(int newNoteID) {
        noteID = newNoteID;
    }

    public String getNote() {
        return note.trim();
    }

    public void setNote(String newNote) {
        note = newNote;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int newUserID) {
        userID = newUserID;
    }


}

