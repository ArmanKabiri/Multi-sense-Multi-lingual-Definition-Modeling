# Created by Arman Kabiri on 2019-07-22
# Author's Email Address: Arman.Kabiri94@gmail.com

import gensim
import logging
import numpy
import sys


class MyCorpus:
    """An interator that yields sentences (lists of str)."""

    def __init__(self, file_path: str, chunk: int):
        self.file_path = file_path
        self.chunk = chunk

    def __iter__(self):

        with open(self.file_path, 'r') as f:
            while True:

                buf = f.read(self.chunk)
                if not buf:
                    break

                # make sure we end on a space (word boundary)
                while not str.isspace(buf[-1]):
                    ch = f.read(1)
                    if not ch:
                        break
                    buf += ch

                words = buf.split(' ')
                yield words
            yield []  # handle the scene that the file is empty


corpus_fPath = sys.argv[1]
embeddings_out_fPath = sys.argv[2]
n_workers = int(sys.argv[3])

corpus_reader = MyCorpus(corpus_fPath, 10000000)
unk_token = 'UNK'
unk_vector = numpy.random.uniform(-1, 1, 300)

print('Training the model.')
logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)

model = gensim.models.Word2Vec(sentences=corpus_reader, min_count=5, size=300, negative=5, window=5, workers=n_workers, sg=1)
gensim.models.Word2Vec()
word_vectors = model.wv
word_vectors.add([unk_token], [unk_vector], replace=False)

print('Saving Model.')
word_vectors.save_word2vec_format(fname=embeddings_out_fPath + '.bin', binary=True)
word_vectors.save_word2vec_format(fname=embeddings_out_fPath + '.txt', binary=False)
