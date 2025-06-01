package com.tech.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class Helper 
{
	public static boolean deleteFle(String path)
	{
			boolean f=false;
			try {
				File file=new File(path);
				f=file.delete();
				//f=true;
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return f;
			
	}
	public static boolean saveFile(InputStream is, String path) {
        boolean success = false;
        try {
            byte[] buffer = new byte[2036];
            int bytesRead;

            try (FileOutputStream fos = new FileOutputStream(path)) {
                while ((bytesRead = is.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }

            success = true;
            System.out.println("File saved successfully");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return success;
    }

}
