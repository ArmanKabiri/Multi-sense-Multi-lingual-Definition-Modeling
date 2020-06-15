# Created by Arman Kabiri on 2020-01-28 - 10:04 a.m.
# Author's Email Address: Arman.Kabiri94@gmail.com

import sys
from tqdm import tqdm
from read_words import read_words_inChunk

URI_corpus = sys.argv[1]
URI_dic = sys.argv[2]
URI_transformedCorpus = sys.argv[3]
URI_transformedDictionary = sys.argv[4]


if __name__ == "__main__":

    id2word = list()
    word2id = dict()

    print('Saving Transformed Dictionary')
    with open(URI_dic, 'r') as infile, open(URI_transformedDictionary, 'w') as outFile:
        for i, line in enumerate(tqdm(infile)):
            word, freq = line.rstrip().split(' ')
            id2word.append(word)
            word2id[word] = i
            outFile.write(str(i)+' '+str(freq)+'\n')

    counter = 0
    typesNotInDic, tokensNotInDic = set(), 0
    print('Transforming the Corpus')
    with open(URI_transformedCorpus, 'w') as out_file:
        for word in tqdm(read_words_inChunk(URI_corpus, 1024000)):
            try:
                wordTransformed = word2id[word]
                out_file.write(str(wordTransformed)+' ')
                counter += 1
            except KeyError:
                typesNotInDic.add(word)
                tokensNotInDic += 1

    print('count = {}'.format(counter))
    print('types not in Dic = {}'.format(len(typesNotInDic)))
    print('tokens not in Dic = {}'.format(tokensNotInDic))

