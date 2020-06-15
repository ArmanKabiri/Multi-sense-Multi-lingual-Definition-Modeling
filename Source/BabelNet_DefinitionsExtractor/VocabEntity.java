/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package babelnetwik;

import it.uniroma1.lcl.babelnet.data.BabelSenseSource;
import it.uniroma1.lcl.jlt.util.Language;
import java.util.Set;

/**
 *
 * @author akabiri
 */
public class VocabEntity {
    
    public Language language;
    public Set<String> wordsList;
    public BabelSenseSource source;
    public String fileName;
    
    public VocabEntity(Language language, Set<String> wordsList, BabelSenseSource source, String fileName){
        this.language = language;
        this.wordsList = wordsList;
        this.source = source;
        this.fileName = fileName;
    }
    
}
