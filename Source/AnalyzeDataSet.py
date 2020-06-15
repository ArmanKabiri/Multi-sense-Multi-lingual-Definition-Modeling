#!/usr/bin/env python
# coding: utf-8

# In[1]:


import sys


# In[8]:


file_URI = sys.argv[1]   # input dataSet file (Before Mapping)


# In[4]:


words_set = set()
last_word = ''
n_lastword_defs = 0
n_wordsWithMoreThan1Def = 0


# In[ ]:


with open(file_URI) as file:
    
    for line in file:
        try:
            word,_,_,word_def,*_ = line.strip().split('\t')
        except :
            print(line)
        words_set.add(word)   

        if word==last_word:
            n_lastword_defs += 1
        else:
            if n_lastword_defs > 1:
                n_wordsWithMoreThan1Def += 1
            last_word = word
            n_lastword_defs=1
    
    print(f"Portion of words having more than one definition : {n_wordsWithMoreThan1Def/len(words_set)}\n")
            
        
        
        

