/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package babelnetwik;

import com.babelscape.util.POS;
import it.uniroma1.lcl.babelnet.BabelNet;
import it.uniroma1.lcl.babelnet.BabelNetQuery;
import it.uniroma1.lcl.babelnet.BabelSense;
import it.uniroma1.lcl.babelnet.data.BabelGloss;
import it.uniroma1.lcl.jlt.util.Language;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author akabiri
 */
public class BabelNetWiktionary_MultiThread {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        Map<Language,SyncFileWriter> outFiles = new HashMap<>();
        try{
            outFiles.put(Language.EN, new SyncFileWriter("BibelnetDic-EN2.txt"));
            outFiles.put(Language.FR, new SyncFileWriter("BibelnetDic-FR2.txt"));
            outFiles.put(Language.DE, new SyncFileWriter("BibelnetDic-DE2.txt"));
            outFiles.put(Language.FI, new SyncFileWriter("BibelnetDic-FI2.txt"));
            outFiles.put(Language.RU, new SyncFileWriter("BibelnetDic-RU2.txt"));
            outFiles.put(Language.VI, new SyncFileWriter("BibelnetDic-VI2.txt"));
            outFiles.put(Language.TR, new SyncFileWriter("BibelnetDic-TR2.txt"));
            outFiles.put(Language.FA, new SyncFileWriter("BibelnetDic-FA2.txt"));
            outFiles.put(Language.ES, new SyncFileWriter("BibelnetDic-ES2.txt"));
            outFiles.put(Language.IT, new SyncFileWriter("BibelnetDic-IT2.txt"));
        }
        catch(FileNotFoundException | UnsupportedEncodingException ex){
            Logger.getLogger(BabelNetWiktionary_MultiThread.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        List<Language> languagesList = new ArrayList<>(outFiles.keySet());
        
        BabelNet bn = BabelNet.getInstance();
        MutableInteger wordCounter=new MutableInteger(0);
        bn.lexiconStream().parallel().forEach(word->{
            
            String word_Str = word.getWord();
            Language word_lang = word.getLanguage();
            edu.mit.jwi.item.POS word_POS1 = word.getPOS();
            
            if(languagesList.contains(word_lang)){
                
                BabelNetQuery word_query = new BabelNetQuery.Builder(word_Str).from(word_lang).toSameLanguages().build();
                List<BabelSense> word_senses = bn.getSensesFrom(word_query);

                Set<DicEntry> word_definitions = new HashSet<>();
                for (BabelSense sense:word_senses){
                    POS word_POS = sense.getPOS();
                    if (sense.getFullLemma().equalsIgnoreCase(word_Str)){
                        for(BabelGloss gloss : sense.getSynset().getGlosses(word_lang)){
                            String word_def = gloss.getGloss().replaceAll("[\t\n]+", " ");
                            String word_source = gloss.getSource().getSourceName();
                            word_definitions.add(new DicEntry(word_Str, word_def, word_source, word_POS.toString()));
                        }
                    }
                    else{
                        int a=12;
                    }
                }
                if(!word_definitions.isEmpty()){
                    for(DicEntry entry:word_definitions){
                        try {
                            SyncFileWriter writer = outFiles.get(word_lang);
                            String line = entry.word+"\t"+entry.word_POS+"\t"+entry.source+"\t"+entry.definition+"\n";
                            writer.write(line);
                        } catch (IOException ex) {
                            Logger.getLogger(BabelNetWiktionary_MultiThread.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    if(wordCounter.increment()%100==0){
                        System.out.println("Dic Size so far: "+wordCounter.get());
                    }
                }
            }
        });
        
        System.out.println("done.");
        
        try{
            for(SyncFileWriter writer:outFiles.values()){
                writer.close();
            }
        }
        catch (IOException ex) {
            Logger.getLogger(BabelNetWiktionary_MultiThread.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void printWordDefs(String word){
        
        Language language = Language.EN;
        BabelNet bn = BabelNet.getInstance();
        BabelNetQuery query = new BabelNetQuery
                .Builder(word).from(language).toSameLanguages()
                .build();
        
        List<BabelSense> senses = bn.getSensesFrom(query);
        Set<String> definitions = new HashSet<>();
        for (BabelSense sense:senses){
            if (sense.getFullLemma().equalsIgnoreCase(word)){
                for( BabelGloss gloss : sense.getSynset().getGlosses(language)){
                    definitions.add(gloss.getSource().getSourceName()+": "+ gloss.getGloss());
                }
            }
        }
        
        definitions.forEach(def -> System.out.println(def));
        
    }
}