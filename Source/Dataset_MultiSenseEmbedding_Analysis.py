# Created by Arman Kabiri on 2020-04-24 - 3:58 p.m.
# Author's Email Address: Arman.Kabiri94@gmail.com

import gensim
import sys

URI_dataset = sys.argv[1]
URI_SenseEmbeddings_binfile = sys.argv[2]

def count_embeddings_per_word() -> dict:

    print('Loading embeddings\n')
    model = gensim.models.KeyedVectors.load_word2vec_format(fname=URI_SenseEmbeddings_binfile, binary=True)

    embeddings_dic = dict()
    vectors = model.vectors
    vocabs = model.index2word

    for word, vector in zip(vocabs, vectors):
        if '#' in word:
            word = word.split('#')[0]
            if word in embeddings_dic:
                embeddings_dic[word]+=1
            else:
                embeddings_dic[word] = 1

    print('Embeddings are loaded\n')
    return embeddings_dic


def count_definitions_per_word() -> dict:

    print('loading definitions\n')
    definitions = dict()
    lines = open(URI_dataset, "r").readlines()

    for line in lines:
        word, _, _, _ = line.strip("\r\n").split("\t")
        if word in definitions:
            definitions[word] += 1
        else:
            definitions[word] = 1

    print('definitions are loaded\n')
    return definitions

# Main Script:
embeddings = count_embeddings_per_word()
definitions = count_definitions_per_word()
vocab = set(definitions.keys()).intersection(set(embeddings.keys()))

embeddings = {word:count for word,count in embeddings.items() if word in vocab}
definitions = {word:count for word,count in definitions.items() if word in vocab}
assert len(embeddings)==len(definitions)

print(f"Number of target words: {len(vocab)}\n")
print(f"Total number of definitions: {sum([c for _,c in definitions.items()])}")
print(f"Total number of senses: {sum([c for _,c in embeddings.items()])}\n")
print(f"Number of definitions per word: {sum([c for _,c in definitions.items()])/len(vocab)}")
print(f"Number of senses per word: {sum([c for _,c in embeddings.items()])/len(vocab)}")