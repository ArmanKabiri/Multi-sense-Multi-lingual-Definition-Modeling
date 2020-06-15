/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package babelnetwik;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;

/**
 *
 * @author akabiri
 */
public class SyncFileWriter {
    
    private Writer writer=null;
    private String filePath;
    
    public SyncFileWriter(String filePath) throws FileNotFoundException, UnsupportedEncodingException{
        this.filePath=filePath;
        writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath), "utf-8"));
    }
    
    public synchronized void write(String line) throws IOException{
        writer.write(line);
    }
    public synchronized void close() throws IOException{
        writer.close();
    }
    
    public synchronized boolean exists(){
        return new File(filePath).exists();
    }
}
