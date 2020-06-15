/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package babelnetwik;

import it.uniroma1.lcl.babelnet.BabelNet;
import it.uniroma1.lcl.babelnet.BabelSense;
import it.uniroma1.lcl.babelnet.data.BabelSenseSource;
import it.uniroma1.lcl.jlt.util.Language;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author akabiri
 */
public class Extract_WordsAndSources {

    private Map<Language,String> wordlist_fileNames = new HashMap<>();
    private String directory = "wordslist/Dutch";
    
    private final BabelSenseSource[] allowedSources={
//        BabelSenseSource.BABELNET,	// BabelNet senses, not available as of version 3.0
//	BabelSenseSource.WN,		// WordNet senses
//	BabelSenseSource.OMWN,		// Open Multilingual WordNet (deprecate)
//	BabelSenseSource.IWN,		// Italian  WordNet
//	BabelSenseSource.WONEF,		// WordNet du Francais
//	BabelSenseSource.WIKI,		// Wikipedia page
//	BabelSenseSource.WIKIDIS,	// Wikipedia disambiguation pages
//	BabelSenseSource.WIKIDATA,	// Wikidata senses
	BabelSenseSource.OMWIKI,	        // OmegaWiki senses
//	BabelSenseSource.WIKICAT,	// Wikipedia category, not available as of version 3.0
//	BabelSenseSource.WIKIRED,	// Wikipedia redirections
	BabelSenseSource.WIKT,		// Wiktionary senses
//	BabelSenseSource.WIKIQU,        // Wikiquote page
//	BabelSenseSource.WIKIQUREDI,	// Wikiquote redirections
//	BabelSenseSource.WIKTLB,    	// Wiktionary translation label
//	BabelSenseSource.VERBNET,	// VerbNet senses
//	BabelSenseSource.FRAMENET,	// FrameNet senses
//	BabelSenseSource.MSTERM,        // Microsoft Terminology items
//	BabelSenseSource.GEONM,		// GeoNames items
//	BabelSenseSource.WNTR,		// Translations of WordNet senses
//	BabelSenseSource.WIKITR,        // Translations of Wikipedia links
//	BabelSenseSource.MCR_EU,    	// Open Multilingual WordNet (Basque)
//	BabelSenseSource.OMWN_HR,	// Open Multilingual WordNet (Croatian)
//	BabelSenseSource.SLOWNET,	// Open Multilingual WordNet (Slovenian)
//	BabelSenseSource.OMWN_ID,	// Open Multilingual WordNet (Indonesian)
//	BabelSenseSource.OMWN_IT,	// Open Multilingual WordNet (Italian)
//	BabelSenseSource.MCR_GL,    	// Open Multilingual WordNet (Galician)
//	BabelSenseSource.ICEWN,		// Open Multilingual WordNet (Icelandic)
//	BabelSenseSource.OMWN_ZH,	// Open Multilingual WordNet (Chinese)
//	BabelSenseSource.OMWN_NO,	// Open Multilingual WordNet (Norwegian (Bokmï¿½l))
//	BabelSenseSource.OMWN_NN,	// Open Multilingual WordNet (Norwegian (Nynorsk))
//	BabelSenseSource.SALDO,		// Open Multilingual WordNet (Swedish)
//	BabelSenseSource.OMWN_JA,	// Open Multilingual WordNet (Japanese)
//	BabelSenseSource.MCR_CA,        // Open Multilingual WordNet (Catalan)
//	BabelSenseSource.OMWN_PT,	// Open Multilingual WordNet (Portuguese)
//	BabelSenseSource.OMWN_FI,	// Open Multilingual WordNet (Finnish)
//	BabelSenseSource.OMWN_PL,	// Open Multilingual WordNet (Polish)
//	BabelSenseSource.OMWN_TH,	// Open Multilingual WordNet (Thai)
//	BabelSenseSource.OMWN_SK,	// Open Multilingual WordNet (Slovak)
//	BabelSenseSource.OMWN_LT,	// Open Multilingual WordNet (Lithuanian)
//	BabelSenseSource.OMWN_NL,	// Open Multilingual WordNet (Dutch)
//	BabelSenseSource.OMWN_AR,	// Open Multilingual WordNet (Arabic)
//	BabelSenseSource.OMWN_FA,	// Open Multilingual WordNet (Persian)
//	BabelSenseSource.OMWN_EL,	// Open Multilingual WordNet (Greek)
//	BabelSenseSource.MCR_ES,	// Open Multilingual WordNet (Spanish)
//	BabelSenseSource.OMWN_RO,	// Open Multilingual WordNet (Romanian)
//	BabelSenseSource.OMWN_SQ,	// Open Multilingual WordNet (Albanian)
//	BabelSenseSource.OMWN_DA,	// Open Multilingual WordNet (Danish)
//	BabelSenseSource.OMWN_FR,	// Open Multilingual WordNet (French)
//	BabelSenseSource.OMWN_MS,	// Open Multilingual WordNet (Malay)
//	BabelSenseSource.OMWN_BG,	// Open Multilingual WordNet (Bulgarian)
//	BabelSenseSource.OMWN_HE,	// Open Multilingual WordNet (Hebrew)
//	BabelSenseSource.OMWN_KO,	// Korean WordNet
//	BabelSenseSource.MCR_PT,        // Open Multilingual WordNet (Portuguese)
//	BabelSenseSource.OMWN_GAE,	// Irish WordNet (GAWN)
//	BabelSenseSource.WORD_ATLAS	// WordAtlas
    };
    

    public Extract_WordsAndSources(){
        
        wordlist_fileNames.put(Language.NL, directory+"BibelnetDic-NL");
//        wordlist_fileNames.put(Language.EN, directory+"BibelnetDic-EN");
//        wordlist_fileNames.put(Language.FR, directory+"BibelnetDic-FR");
//        wordlist_fileNames.put(Language.DE, directory+"BibelnetDic-DE");
//        wordlist_fileNames.put(Language.FI, directory+"BibelnetDic-FI");
//        wordlist_fileNames.put(Language.RU, directory+"BibelnetDic-RU");
//        wordlist_fileNames.put(Language.VI, directory+"BibelnetDic-VI");
//        wordlist_fileNames.put(Language.TR, directory+"BibelnetDic-TR");
//        wordlist_fileNames.put(Language.FA, directory+"BibelnetDic-FA");
//        wordlist_fileNames.put(Language.ES, directory+"BibelnetDic-ES");
//        wordlist_fileNames.put(Language.IT, directory+"BibelnetDic-IT");
    }
    public static void main(String[] args) {
        
        Extract_WordsAndSources ew = new Extract_WordsAndSources();
        ew.extract();
        
    }
    
    
    public void extract(){
        
        Map<String,Writer> outFiles = new HashMap<>();
        
        List<Language> languagesList = new ArrayList<>(wordlist_fileNames.keySet());
        Map<Language,Set<WordEntry>> wordslist = new ConcurrentHashMap<>();
        
        languagesList.forEach((lang) -> {
            wordslist.put(lang, new HashSet());
        });
        
        BabelNet bn = BabelNet.getInstance();
        MutableInteger wordCounter = new MutableInteger(0);
               
        //////////////////////////////////////////////
        //Extracting words
        bn.lexiconStream().parallel().forEach(word->{
            
            String word_Str = word.getWord();
            Language word_lang = word.getLanguage();
            
            if(languagesList.contains(word_lang)){
                List<BabelSense> word_senses = bn.getSenses(word_Str, word_lang, null, Arrays.asList(word_lang), allowedSources);
                
                for(BabelSense sense : word_senses){
                    String word_source = sense.getSource().name();
                    wordslist.get(word_lang).add(new WordEntry(sense.getSimpleLemma(), word_source));
                }
                
                if(wordCounter.increment()%1000==0){
                    System.out.println(wordCounter.get() + "\t" + word_lang.getName() + " DicSize= " + wordslist.get(word_lang).size());
                }
            }
        });
        ///////////////////////////////////////////////
        
        System.out.println("Writing to file.");
        
        for (Map.Entry<Language,Set<WordEntry>> entry:wordslist.entrySet()){
            try{
                Language language = entry.getKey();
                for(WordEntry entryWord : entry.getValue()){
                    String source = entryWord.source;
                    if(!outFiles.containsKey(language.getName()+"-"+source)){
                        outFiles.put(language.getName()+"-"+source, new BufferedWriter(new OutputStreamWriter(
                                new FileOutputStream(wordlist_fileNames.get(language)+"-"+source+".words"), "utf-8")));
                    }
                    outFiles.get(language.getName()+"-"+source).write(entryWord.word+"\n");
                }
            }
            catch(Exception ex){
                Logger.getLogger(Extract_WordsAndSources.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        ////////////////////
        //Closing Files
        outFiles.forEach((lang,writer)->{
            try {
                writer.close();
            } catch (IOException ex) {
                Logger.getLogger(Extract_WordsAndSources.class.getName()).log(Level.SEVERE, null, ex);
            }
        });
        
        System.out.println("Done.");

    }
    
    public List<VocabEntity> loadWordsLists(){
        
        List<VocabEntity> result = new ArrayList<>();
        Map<String,BabelSenseSource> sourcesMap = getSourcesMap();
        Iterator<File> files = FileUtils.iterateFiles(new File(directory), new String[]{"words"}, true);
        files.forEachRemaining(file->{
            try {
                String name = file.getName().replaceAll("[.].+", "");
                String[] parts = name.split("-");
                BabelSenseSource source = sourcesMap.get(parts[2]);        
                Language lang = Language.valueOf(parts[1]);
                Set<String> words = new HashSet<>(FileUtils.readLines(file, "utf-8"));
                result.add(new VocabEntity(lang, words, source, name));
            } catch (IOException ex) {
                Logger.getLogger(Extract_WordsAndSources.class.getName()).log(Level.SEVERE, null, ex);
            }
        });
        
        return result;
    }
    
    private Map<String,BabelSenseSource> getSourcesMap(){
        Map<String,BabelSenseSource> results = new HashMap<>();
        List<BabelSenseSource> sources = Arrays.asList(BabelSenseSource.values());
        sources.forEach(source->{
            results.put(source.name(), source);
        });
        return results;
    }
    
}