/******************************************************
 * File: FamUtil.java
 * created Dec 22, 2001 4:13:47 PM by mike.bordelon
 */
package com.familyutil;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import javax.swing.*;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.*;

import sun.net.smtp.SmtpClient;


public class FamUtil {


    public FamUtil() {
    }

    public static String getUniqueFileName(String outputDir) throws Exception {
        String fileName = null;
        boolean keepTrying = true;
        while (keepTrying) {  // keep going tell get a unique file name
            // generate a random number between 0 and FFFFF hex  (five hex decimals because of html graphics file names)
            fileName = Integer.toHexString((int) Math.rint(Math.random() * 1048574)) + "." + "JPG";
            for (int i = 0; i < (5 - fileName.length()); i++)
                fileName = "0" + fileName;
            File fileCheck = new File(outputDir + File.separator + fileName);
            if (fileCheck.exists())
                keepTrying = true;
            else
                keepTrying = false;
        }
        return fileName;
    }

    public static void rotateImage(String argFilename, int angle) {
        Image inImage = new ImageIcon(argFilename).getImage();
        BufferedImage outImage = new BufferedImage(inImage.getWidth(null), inImage.getHeight(null), BufferedImage.TYPE_INT_RGB);
        AffineTransform tx = new AffineTransform();
        Graphics2D g2d = outImage.createGraphics();
        tx.rotate(Math.toRadians(angle), inImage.getWidth(null) / 2, inImage.getHeight(null) / 2);
        g2d.drawImage(inImage, tx, null);
        g2d.dispose();
        try {
            OutputStream os = new FileOutputStream(argFilename);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
            encoder.encode(outImage);
            os.close();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }

    public static void createThumb(String argFileName, String newFileName, int newWidth) {
        try {
            Image inImage = new ImageIcon(argFileName).getImage();
            double maxWidth = newWidth;
            // Determine the scale.
            double scale = maxWidth / (double) inImage.getWidth(null);
            int scaledW = (int) (scale * inImage.getWidth(null));
            int scaledH = (int) (scale * inImage.getHeight(null));
            // Create an image buffer in which to paint on.
            BufferedImage outImage = new BufferedImage(scaledW, scaledH, BufferedImage.TYPE_INT_RGB);
            // Set the scale.
            AffineTransform tx = new AffineTransform();
            // If the image is smaller than the desired image size, don't bother scaling.
            if (scale < 1.0d) {
                tx.scale(scale, scale);
            }
            // Paint image.
            Graphics2D g2d = outImage.createGraphics();
            g2d.drawImage(inImage, tx, null);
            g2d.dispose();
            // JPEG-encode the image and write to file.
            OutputStream os = new FileOutputStream(newFileName);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
            encoder.encode(outImage);
            os.close();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

    public static void resizeMainPhoto(String argFileName, String newFileName, int newWidth) {
        try {
            Image inImage = new ImageIcon(argFileName).getImage();
            double maxWidth = newWidth;
            // Determine the scale.
            if (inImage.getWidth(null) <= maxWidth) {
                System.out.println("No Resize just rename to:" + newFileName + ":" + inImage.getWidth(null));
                File newFile = new File(newFileName);
                File oldFile = new File(argFileName);
                oldFile.renameTo(newFile);

            } else {
                System.out.println("Must Resize oldFileSize:" + inImage.getWidth(null));

                double scale = maxWidth / (double) inImage.getWidth(null);
                int scaledW = (int) (scale * inImage.getWidth(null));
                int scaledH = (int) (scale * inImage.getHeight(null));
                // Create an image buffer in which to paint on.
                BufferedImage outImage = new BufferedImage(scaledW, scaledH, BufferedImage.TYPE_INT_RGB);
                // Set the scale.
                AffineTransform tx = new AffineTransform();
                // If the image is smaller than the desired image size, don't bother scaling.
                if (scale < 1.0d) {
                    tx.scale(scale, scale);
                }
                // Paint image.
                Graphics2D g2d = outImage.createGraphics();
                g2d.drawImage(inImage, tx, null);
                g2d.dispose();
                // JPEG-encode the image and write to file.
                OutputStream os = new FileOutputStream(newFileName);
                //JPEGEncodeParam param = new JPEGEncodeParam();
                //param.setQuality(75,true);

                //ImageEncoder encoder = ImageCodec.createImageEncoder("JPEG",os,param);
                JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
                encoder.encode(outImage);
                os.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

    public static void fileCopy(String oldFile, String newFile) throws IOException {
        File inputFile = new File(oldFile);
        File outputFile = new File(newFile);

        FileReader in = new FileReader(inputFile);
        FileWriter out = new FileWriter(outputFile);
        int c;

        while ((c = in.read()) != -1)
            out.write(c);

        in.close();
        out.close();
    }

    public boolean sendEmail(String to, String from, String subject, String body, String familyName) {
        boolean success = true;
        FamilyProperties zionProperties = FamilyProperties.getInstance();
        try{
            SmtpClient client = new SmtpClient(zionProperties.SMTPSERVER.trim());
            client.from(from);
            client.to(to);
            PrintStream message = client.startMessage();
            message.println("To: " + to);
            message.println("Subject:  Sending email from " + familyName);
            message.println();
            message.println(body);
            message.println();
            message.println("Go to "+ zionProperties.SITEURL.trim() + "to see the photos.");
            client.closeServer();
        }
        catch (IOException e){
           System.out.println("ERROR SENDING EMAIL:"+e);
           success = false;
        }
        return success;
    }

}
