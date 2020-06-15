# Created by Arman Kabiri on 2020-01-28 - 4:40 p.m.
# Author's Email Address: Arman.Kabiri94@gmail.com


def read_words_inChunk(inputfile, chunk):
    with open(inputfile, 'r') as f:
        while True:
            buf = f.read(chunk)
            if not buf:
                break

            # make sure we end on a space (word boundary)
            while not str.isspace(buf[-1]):
                ch = f.read(1)
                if not ch:
                    break
                buf += ch

            words = buf.split()
            for word in words:
                yield word
        yield '' #handle the scene that the file is empty