/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package babelnetwik;

import com.babelscape.util.POS;
import it.uniroma1.lcl.babelnet.BabelNet;
import it.uniroma1.lcl.babelnet.BabelSense;
import it.uniroma1.lcl.babelnet.data.BabelGloss;
import it.uniroma1.lcl.babelnet.data.BabelSenseSource;
import it.uniroma1.lcl.jlt.util.Language;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author akabiri
 */
public class Extract_Definitions {

    /**
     * @param args the command line arguments
     */
    String directory = "Generated_Dics--IG--/";
    public static void main(String[] args) {
        
        Extract_Definitions ed = new Extract_Definitions();
        ed.run();
//        ed.test_def();
        
    }
    
    public void test_def(){
        Language lang = Language.FA;
        BabelNet bn = BabelNet.getInstance();
        String word = "خواب";
        List<BabelSense> senses = bn.getSensesFrom(word);
        Set<String> defs=new HashSet<>();
        for(BabelSense sense : senses){
            for(BabelGloss gloss : sense.getSynset().getGlosses(lang)){
                defs.add(gloss.getGloss());
            }
        }
        defs.forEach(d->System.out.println(d));
    }
    
    public void test_WikT(){
        BabelNet bn = BabelNet.getInstance();
        bn.lexiconStream().forEach(word->{
            if(word.getLanguage()==Language.RU){
                String w = word.getWord();
                List<BabelSense> senses = bn.getSensesContaining(w, Language.RU);
                senses.forEach(sense->{
                    List<BabelGloss> glosses = sense.getSynset().getGlosses(Language.RU);
                    glosses.forEach(gloss->{
                        BabelSenseSource source = gloss.getSource();
                        if(source==BabelSenseSource.WIKT){
                            System.out.println("FOUND!");
                        }
                    });
                });
            }
        });

    }
    
    public void run(){
        BabelNet bn = BabelNet.getInstance();
        Extract_WordsAndSources ew = new Extract_WordsAndSources();
        List<VocabEntity> vocabsList = ew.loadWordsLists();
        
        for(VocabEntity vocab : vocabsList){
            try {
                String fileName=directory+vocab.fileName+".txt";
                if(!new File(fileName).exists()){
                    System.out.println("Extracting Definitions ("+vocab.language.getName()+" - "+vocab.source.getSourceName()+")");
                    SyncFileWriter writer = new SyncFileWriter(fileName);
                    MutableInteger counter=new MutableInteger(0);
                    MutableInteger def_counter=new MutableInteger(0);
                    MutableInteger foundWord_counter = new MutableInteger(0);
                    Map<String,Set<DicEntry>> definitions=new ConcurrentHashMap<>();
                   
                    
                    //It only extracts the definitions from Wikipedia (the words list comes from Wiktionary)
                    vocab.wordsList.parallelStream().forEach(word->{
                        if(!definitions.containsKey(word)){
                            definitions.put(word, new HashSet<>());
                        }
                        boolean hasGloss=false;
                        List<BabelSense> word_senses = bn.getSenses(word, vocab.language, null, Arrays.asList(vocab.language),vocab.source);
                        for (BabelSense sense:word_senses){
                            if (sense.getSimpleLemma().equalsIgnoreCase(word)){
                                POS word_POS = sense.getPOS();
                                for(BabelGloss gloss : sense.getSynset().getGlosses(vocab.source)){
                                    String word_def = gloss.getGloss().replaceAll("[\t\n]+", " ");
                                    String word_source = gloss.getSource().getSourceName();
                                    definitions.get(word).add(new DicEntry(word, word_def, word_source, word_POS.toString()));
                                    hasGloss=true;
                                }
                            }
                            else{
                                int a=12;
                            }
                        }
                        if(hasGloss)
                            foundWord_counter.increment();
                        if(counter.increment()%1000==0){
                            System.out.println("steps: "+counter.get()+",    words: "+foundWord_counter.get()+",    defs: "+def_counter.get());
                        }
                        def_counter.increment(definitions.get(word).size());
                    });
                    for(Entry<String,Set<DicEntry>> entry:definitions.entrySet()){
                        for(DicEntry dicEntry : entry.getValue()){
                            writer.write(dicEntry.word+"\t"+dicEntry.word_POS+"\t"+dicEntry.source+"\t"+dicEntry.definition+"\n");
                        }
                    }
                    System.out.println("Done: ("+vocab.language.getName()+" - "+vocab.source.getSourceName()+")");
                    System.out.println("words= "+foundWord_counter.get()+",  definitions= "+def_counter.get());
                    System.out.println("#senses/#words = " + ((float)def_counter.get())/foundWord_counter.get());
                    System.out.println("------------------------------------");
                    writer.close();
                }
            } catch (UnsupportedEncodingException | FileNotFoundException ex) {
                Logger.getLogger(Extract_Definitions.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(Extract_Definitions.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
    }
    
}