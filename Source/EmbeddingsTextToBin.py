import gensim
import sys
import os
import numpy

unk_token = 'UNK'
unk_vector = numpy.random.uniform(-1, 1, 300)

URI_inputFile = sys.argv[1]

print("Loading embeddings...")

vectors = gensim.models.KeyedVectors.load_word2vec_format(fname=URI_inputFile, binary=False)
vectors.add([unk_token], [unk_vector], replace=False)

print("Saving embeddings...")
vectors.save_word2vec_format(fname=os.path.splitext(URI_inputFile)[0] + '.bin', binary=True)
