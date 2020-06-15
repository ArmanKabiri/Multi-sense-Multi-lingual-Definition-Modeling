# Created by Arman Kabiri on 2020-01-28 - 4:39 p.m.
# Author's Email Address: Arman.Kabiri94@gmail.com

import sys
from tqdm import tqdm

URI_Input_transformedEmbedding = sys.argv[1]
URI_dic = sys.argv[2]
URI_OutputEmbedding = sys.argv[3]
UNK_SYMBOL = sys.argv[4]

id2word = list()
word2id = dict()


print('Loading Dictionary')
with open(URI_dic, 'r') as file:
    for i, line in enumerate(tqdm(file)):
        word, _ = line.split(' ')
        id2word.append(word)
        word2id[word] = i


print("Calculating Vocab Size...")
n_words2Drop = 0
with open(URI_Input_transformedEmbedding, 'r') as infile:
    for i, line in enumerate(tqdm(infile)):
        if i > 0:
            indexedWord = line.split(' ')[0].strip()

            if '#' in indexedWord:
                index = indexedWord.split('#')[0]
            else:
                index = indexedWord
            try:
                if index != UNK_SYMBOL:
                    wordInDic = id2word[int(index)]
                    if '#' in wordInDic:
                        raise ValueError
            except ValueError:
                n_words2Drop += 1


print('Transforming Embeddings...')
n_words = 0
avg_senses_per_word = 0
tmp_n_senses_of_last_word = 0

with open(URI_Input_transformedEmbedding, 'r') as infile, open(URI_OutputEmbedding, 'w') as outFile:
    for i, line in enumerate(tqdm(infile)):
        if i == 0:
            vocab_size, emb_dim = line.strip().split(' ')
            outFile.write(str(int(vocab_size)-n_words2Drop) + ' ' + emb_dim + '\n')
        else:
            try:
                parts = line.rstrip().split(' ')
                indexedWord, embedding = parts[0], parts[1:]

                if '#' in indexedWord:
                    index, senseID = indexedWord.split('#')
                    wordInDic = id2word[int(index)]
                    word = wordInDic + '#' + senseID
                    tmp_n_senses_of_last_word = senseID
                else:
                    if indexedWord == UNK_SYMBOL:
                        wordInDic = UNK_SYMBOL
                    else:
                        wordInDic = id2word[int(indexedWord)]
                    word = wordInDic
                    avg_senses_per_word += int(tmp_n_senses_of_last_word)
                    n_words += 1
                    tmp_n_senses_of_last_word = 0

                if '#' not in wordInDic:
                    outFile.write(word+' '+' '.join(embedding)+'\n')
                else:
                    print(wordInDic + "is dropped.")
            except ValueError:
                print(f"one word was dropped.")

print(f"Avg of number of senses per word is {avg_senses_per_word/n_words}")
print("Done!")
