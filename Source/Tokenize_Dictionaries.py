# Author's Email Address: Arman.Kabiri94@gmail.com
# Author's Name: Arman Kabiri

import sys
import io
import os
from nltk.tokenize import word_tokenize

URI_INPUT_DIRECTORY = sys.argv[1]
URI_OUTPUT_DIRECTORY = sys.argv[2]
language = sys.argv[3]
files_to_process = ['train.txt', 'test.txt', 'valid.txt']
vocab = set()

for file in files_to_process:
    output = io.StringIO()
    with open(os.path.join(URI_INPUT_DIRECTORY, file), 'r') as oFile:
        for line in oFile:
            if line!= '\n':
                parts = line.split('\t')
                tokenizedDef = word_tokenize(parts[3], language, False)
                parts[3] = ' '.join(tokenizedDef)
                output.write('\t'.join(parts))
                output.write('\n')
                vocab.update(tokenizedDef)
                vocab.add(parts[0])

    with open(os.path.join(URI_OUTPUT_DIRECTORY, file), 'w') as oFile:
        print(output.getvalue().strip(), file=oFile)

with open(os.path.join(URI_OUTPUT_DIRECTORY, 'vocab.txt'), 'w') as oFile:
    oFile.write('\n'.join(vocab))
