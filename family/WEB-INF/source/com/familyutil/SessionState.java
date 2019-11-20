package com.familyutil;

import javax.servlet.http.HttpServletRequest;

public class SessionState {

    /***********************************************************************************
     Contains methods to access and mutate 'context' variables that are stored
     in each session
     ************************************************************************************/

    public static int getUserID(HttpServletRequest request) {
        return getContextID(request, "UserID");
    }

    public static void setUserID(HttpServletRequest request, int value) {
        setContextID(request, "UserID", value);
    }


    //**********************************************************************************
    //  Internal Methods
    //**********************************************************************************

    private static int getContextID(HttpServletRequest request, String attributeName) {

        Object obj = request.getSession(false).getAttribute(attributeName);

        if (obj != null && obj instanceof Integer)
            return ((Integer) obj).intValue();
        else
            return -1;
    }

    private static void setContextID(HttpServletRequest request, String attributeName, int attributeValue) {
        request.getSession(false).setAttribute(attributeName, new Integer(attributeValue));
    }

    private static boolean getContextValue(HttpServletRequest request, String attributeName) {
        boolean bReturn = true;
        Object obj = request.getSession(false).getAttribute(attributeName);

        if (obj != null && obj instanceof Boolean) {
            bReturn = ((Boolean) obj).booleanValue();
        }

        return bReturn;
    }

    private static void setContextValue(HttpServletRequest request, String attributeName, boolean attributeValue) {
        request.getSession(false).setAttribute(attributeName, new Boolean(attributeValue));
    }

    private static String getContextDesc(HttpServletRequest request, String attributeName) {

        String sReturn = null;
        Object obj = request.getSession(false).getAttribute(attributeName);

        if (obj != null && obj instanceof String) sReturn = (String) obj;

        return sReturn;
    }

    private static void setContextDesc(HttpServletRequest request, String attributeName, String attributeValue) {
        request.getSession(false).setAttribute(attributeName, attributeValue);
    }
}
