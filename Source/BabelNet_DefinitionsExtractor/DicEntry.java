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
public class DicEntry {
    
    public String word;
    public String definition;
    public String word_POS;
    public String source;
    
    public DicEntry(String word, String definition,String source, String word_POS){
        this.word=word;
        this.definition=definition;
        this.word_POS=word_POS;
        this.source=source;
    }
    
    @Override
    public boolean equals(Object o){
        
        if (o == this) { 
            return true; 
        } 

        if (!(o instanceof DicEntry)) { 
            return false; 
        } 
          
        DicEntry instance = (DicEntry) o; 
          
        // Compare the data members and return accordingly  
        return instance.word.equalsIgnoreCase(word) && instance.definition.equalsIgnoreCase(definition);
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 23 * hash + Objects.hashCode(this.word);
        hash = 23 * hash + Objects.hashCode(this.definition);
        return hash;
    }
}