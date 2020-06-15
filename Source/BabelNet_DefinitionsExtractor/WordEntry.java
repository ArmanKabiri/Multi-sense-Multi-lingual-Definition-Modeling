/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package babelnetwik;

import java.util.Objects;

/**
 *
 * @author akabiri
 */
public class WordEntry {
    
    public String word;
    public String source;
    
    public WordEntry(String word, String source){
        this.word = word;
        this.source = source;
    }
    
    @Override
    public boolean equals(Object o){
        
        if (o == this) { 
            return true; 
        } 

        if (!(o instanceof WordEntry)) { 
            return false; 
        } 
          
        WordEntry instance = (WordEntry) o; 
          
        return instance.word.equalsIgnoreCase(word) && instance.source.equalsIgnoreCase(source);
    }
    
    @Override
    public int hashCode() {
        int hash = 7;
        hash = 67 * hash + Objects.hashCode(this.word);
        hash = 67 * hash + Objects.hashCode(this.source);
        return hash;
    }

}
