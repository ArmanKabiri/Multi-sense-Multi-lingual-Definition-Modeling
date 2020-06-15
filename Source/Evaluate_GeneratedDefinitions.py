import shutil
import string
from subprocess import Popen, PIPE
import os
import sys
import random
from tqdm import tqdm
from rouge import rouge_n_sentence_level
from rouge import rouge_n_summary_level
from collections import OrderedDict
import nltk
import re
import numpy as np

tmp_dir = "./temp"
bleu_path = "./sentence-bleu"

suffix = str(random.random())
URI_refDefinitions = sys.argv[1]
URI_hypDefinitions = sys.argv[2]
n_samples = int(sys.argv[3])
test_subset = sys.argv[4]  # all, monosemous, polysemous, highlyPolysemous
bleu_implementation = 'cpp'  # nltk or cpp
devnull = open(os.devnull, 'w')

MinMax_Test_Subsets = {'all': (1, 1000), 'monosemous': (1, 1), 'polysemous': (2, 1000), 'highlyPolysemous': (4, 1000)}


def main():
    if not os.path.isdir(tmp_dir):
        os.mkdir(tmp_dir)

    wordlistForEvaluation = getTestSubsetWordList(URI_refDefinitions, test_subset)
    ref_definitions = load_definitions_customized4(URI_refDefinitions, wordlistForEvaluation, 'reference')[0]
    hyp_definitions_list = load_definitions_customized4(URI_hypDefinitions, wordlistForEvaluation, 'hypothesis',
                                                        n_samples)

#    if len(ref_definitions) != len(hyp_definitions_list[0]):
#        exit("Number of words being defined mismatched!")

    words = list(ref_definitions.keys())

    final_bleu_original = 0
#    final_bleu_pairwise = 0
    final_bleu_flip = 0
#    final_rouge = np.array([0.0, 0.0, 0.0])

    for itr, hyp_definitions in enumerate(hyp_definitions_list):
        #print('Computing eval metrics over sample= {}'.format(itr + 1))
        avg_bleu_original = 0
        #avg_bleu_pairwise = 0
        avg_bleu_flip = 0
        #avg_rouge = np.array([0.0, 0.0, 0.0])
        n_words = 0

        for word in tqdm(words):
            if word not in ref_definitions or word not in hyp_definitions:
                continue
            word_ref_definitions = ref_definitions[word]
            word_hyp_definitions = hyp_definitions[word]
            bleu_original = get_bleu_original(word_ref_definitions, word_hyp_definitions)
#            bleu_pairwise = get_bleu_pairwise(word_ref_definitions, word_hyp_definitions)
            bleu_flip = get_bleu_flip(word_ref_definitions, word_hyp_definitions)
            avg_bleu_original += bleu_original
#            avg_bleu_pairwise += bleu_pairwise
            avg_bleu_flip += bleu_flip

#            avg_rouge += get_rouge_score_summaryLevel(word_ref_definitions, word_hyp_definitions)

            n_words += 1

        final_bleu_original += (avg_bleu_original / n_words)
 #       final_bleu_pairwise += (avg_bleu_pairwise / n_words)
        final_bleu_flip += (avg_bleu_flip / n_words)
 #       final_rouge += (avg_rouge / n_words)

    print('Results on ' + test_subset + ' words:\n')
    print('BLEU_Original = ' + str(final_bleu_original / n_samples) + '\n')
#    print('BLEU_variant1 = ' + str(final_bleu_pairwise / n_samples) + '\n')
    print('BLEU_Flipped = ' + str(final_bleu_flip / n_samples) + '\n')
#    print('ROUGE_Precision = ' + str(final_rouge[0] / n_samples) + '\n')
#    print('ROUGE_Recall = ' + str(final_rouge[1] / n_samples) + '\n')
#    print('ROUGE_FScore = ' + str(final_rouge[2] / n_samples) + '\n')

    devnull.close()
    #shutil.rmtree(tmp_dir)


def getTestSubsetWordList(fileName: str, test_subset: str) -> list:
    wordsDict = dict()
    lines = open(fileName, "r").readlines()
    for line in lines:
        word, *_ = line.strip("\r\n").split("\t")
        if len(word.split('#')) == 1 or word.split('#')[1] == '1':
            originalWord = word.split('#')[0]
            if originalWord in wordsDict:
                wordsDict[originalWord] += 1
            else:
                wordsDict[originalWord] = 1

    minSenses, maxSenses = MinMax_Test_Subsets[test_subset]
    wordsList = [w for w in wordsDict if minSenses <= wordsDict[w] <= maxSenses]
    return wordsList


def load_definitions_customized4(fileName: str, wordsList: list, defType: str, steps=None) -> list:
    stopRegex = ['['] + [p for p in list(string.punctuation) if p not in '[]'] + [']']
    stopRegex = '\s*' + ''.join(stopRegex) + '\s*'
    if defType == 'reference':
        definitions = OrderedDict()
        with open(fileName, 'r') as ifp:
            for line in ifp:
                parts = line.strip().split('\t')
                word = parts[0]
                word_parts = word.split('#')
                if word_parts[0] in wordsList:
                    if len(word_parts) > 1:
                        word, senseNumber = word.split('#')
                        if int(senseNumber) != 1:
                            continue
                    definition = parts[-1]
                    definition = re.sub(stopRegex, ' ', definition).strip()
                    if definition != '':
                        if word not in definitions:
                            definitions[word] = []
                        definitions[word].append(definition)
        return [definitions]
    elif defType == 'hypothesis':
        if steps is None:
            exit('Undefined steps!')
        definitionsDictList = [OrderedDict() for i in range(steps)]
        sample_counter = 0
        with open(fileName, 'r') as ifp:
            for line in ifp:
                sample_counter = sample_counter % steps
                parts = line.strip().split('\t')
                word = parts[0]
                word = word.split('#')[0]
                if word in wordsList:
                    definition = parts[-1]
                    definition = re.sub(stopRegex, ' ', definition).strip()
                    if definition != '':
                        if word not in definitionsDictList[sample_counter]:
                            definitionsDictList[sample_counter][word] = []
                        definitionsDictList[sample_counter][word].append(definition)
                    sample_counter += 1

        return definitionsDictList
    else:
        exit('Wrong DefType')


def get_bleu_original(ref_definitions: list, hyp_definitions: list):
    bleu_score_avg = 0
    for hyp_def in hyp_definitions:
        bleu = get_bleu_core(ref_definitions, hyp_def)
        bleu_score_avg += bleu
    return bleu_score_avg / len(hyp_definitions)


def get_bleu_pairwise(ref_definitions: list, hyp_definitions: list):
    bleu_avg = 0
    for ref_def in ref_definitions:
        bleu_max = 0
        for hyp_def in hyp_definitions:
            bleu = get_bleu_core([ref_def], hyp_def)
            bleu_max = max(bleu, bleu_max)
        bleu_avg += bleu_max

    return bleu_avg / len(ref_definitions)


def get_bleu_flip(ref_definitions: list, hyp_definitions: list):
    bleu_avg = 0
    for ref_def in ref_definitions:
        # Note: We are fliping definitions here!
        bleu = get_bleu_core(ref_definitions=hyp_definitions, hyp_definition=ref_def)
        bleu_avg += bleu

    return bleu_avg / len(ref_definitions)


def get_bleu_core_cpp(ref_definitions: list, hyp_definition: str):
    hyp_path = os.path.join(tmp_dir, 'hypdef_' + suffix + '.txt')
    with open(hyp_path, 'w') as file:
        file.write(hyp_definition)

    all_ref_paths = []
    for i, d in enumerate(ref_definitions):
        ref_path = os.path.join(tmp_dir, 'refdefs_' + suffix + '_' + str(i) + '.txt')
        with open(ref_path, 'w') as file:
            file.write(d)
        all_ref_paths.append(ref_path)

    read_cmd = ['cat', hyp_path]
    bleu_cmd = [bleu_path] + all_ref_paths
    rp = Popen(read_cmd, stdout=PIPE)
    bp = Popen(bleu_cmd, stdin=rp.stdout, stdout=PIPE, stderr=devnull)
    out, err = bp.communicate()
    if err is None:
        output=''
        try:
            output = out.strip()
            return float(output)
        except:
            print(output)
            exit('An error occured!')
    else:
        return None


def get_bleu_core_nltk(ref_definitions: list, hyp_definition: str):
    min_tokens = float('Inf')
    ref_definitions_tokenized = list()

    max_tokens_in_refs = float('-Inf')
    for ref_def in ref_definitions:
        ref_def = ref_def.split(' ')
        ref_definitions_tokenized.append(ref_def)
        n_tokens = len(ref_def)
        max_tokens_in_refs = max(max_tokens_in_refs, n_tokens)

    min_tokens = min(min_tokens, max_tokens_in_refs)

    hyp_definition_tokenized = hyp_definition.split(' ')
    n_tokens = len(hyp_definition_tokenized)
    min_tokens = min(min_tokens, n_tokens, 4)
    if min_tokens < 1:
        exit('This part of code needs to be fixed!')
        return None
    else:
        weights = tuple([1 / min_tokens for i in range(min_tokens)])
        score = nltk.translate.bleu_score.sentence_bleu(ref_definitions_tokenized, hyp_definition_tokenized,
                                                        weights=weights,
                                                        smoothing_function=nltk.translate.bleu_score.SmoothingFunction().method4)
#smoothing_function=nltk.translate.bleu_score.SmoothingFunction().method4
        return score


def get_rouge_score(ref_definitions: list, hyp_definition: str):
    ref_definitions = ' '.join(ref_definitions).split()
    hyp_definition = hyp_definition.split()

    recall, precision, rouge_F = rouge_n_sentence_level(hyp_definition, ref_definitions, 1)

    return rouge_F


def get_rouge_score_summaryLevel(ref_definitions: list, hyp_definitions: list) -> np.array:
    hyp_def_tokenized = [strDef.split() for strDef in hyp_definitions]
    ref_def_tokenized = [strDef.split() for strDef in ref_definitions]
    recall, precision, f_score = rouge_n_summary_level(hyp_def_tokenized, ref_def_tokenized, 1)

    return np.array([precision, recall, f_score])


if __name__ == '__main__':
    get_bleu_core = get_bleu_core_cpp if bleu_implementation == 'cpp' else get_bleu_core_nltk
    main()
