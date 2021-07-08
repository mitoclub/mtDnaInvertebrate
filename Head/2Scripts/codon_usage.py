import numpy as np
import pandas as pd
from Bio import Seq
from Bio.Data import CodonTable
from Bio import SeqIO
from Bio import Entrez
from itertools import product
import re
import tqdm
import time

dna_codons =[''.join(c) for c in product('ACGT', repeat = 3)]

def get_taxonomy_by_name(query):
    id_query = Entrez.read(Entrez.esearch(db='taxonomy', term=query))['IdList']
    answer = Entrez.read(Entrez.efetch(db='taxonomy', id=id_query))[0]['Lineage']
    time.sleep(0.33)
    return(answer)


def get_table_code(sequence):
    if sequence.annotations['organism'].isalpha() == 'TRUE':
        print(sequence.annotations['organism'])
        taxonomy = get_taxonomy_by_name(sequence.annotations['organism'])

        if 'Vertebrata' in taxonomy:
            table_number = 2
        elif 'Saccharomyces cerevisiae' or 'Candida glabrata' or 'Hansenula saturnus' or 'Kluyveromyces thermotolerans' in taxonomy:
            table_number = 3
        elif 'Emericella nidulans' or 'Neurospora crassa' or 'Podospora anserina' or 'Acremonium' or 'Candida parapsilosis' or 'Trichophyton rubrum' or 'Dekkera' or 'Brettanomyces' or 'Eeniella' or 'Ascobolus immersus' or 'Aspergillus amstelodami' or 'Claviceps purpurea' or 'Cochliobolus heterostrophus' or 'Trypanosoma brucei' or 'Leishmania tarentolae' or 'Paramecium tetraurelia' or 'Tetrahymena pyriformis' or 'Plasmodium gallinaceum' or 'Ctenophora' or 'Cnidaria' in taxonomy:
            table_number = 4
        elif 'Ascaris' or 'Caenorhabditis' or 'Bivalvia' or 'Polyplacophora' or 'Artemia' or 'Drosophila' in taxonomy:
            table_number = 5
        elif 'Asterozoa' or 'Echinozoa' or 'Rhabditophora' in taxonomy:
            table_number = 9
        else:
            table_number = 1
    else:
        table_number = 1

    return table_number


def codon_usage(table_code, sequence: Seq, normalize = True):

    table = CodonTable.unambiguous_dna_by_id[table_code]

    codon_list = list(table.forward_table.keys()) + table.stop_codons
    sequence = str(sequence)
    if len(set(sequence).difference(set(['A','C', 'G', 'T'])))>0:
        return None

    codons = []
    translated = []
    for p in range(0, len(sequence), 3):
        codon = sequence[p:p+3]
        if codon not in dna_codons:
            continue

        codons.append(codon)

        if codon in table.stop_codons:
            break
        translated.append(table.forward_table[codon])

    codons, counts = np.unique(codons, return_counts=True, axis=0)
    codons = [''.join(c) for c in codons]

    ret = pd.Series(index=codon_list, data=0)
    ret[codons] = counts
    if normalize:
        ret = ret / ret.sum()
    return ret, ''.join(translated)

def cds_codon_usage(seq:Seq):
    cds_stats = []
    cds_col_names = []

    aa = []
    aa_table = pd.DataFrame()

    for feature in seq.features:
        if feature.type != 'CDS' or feature.strand != 1:
            continue

        if 'transl_table' in feature.qualifiers:
            table_code = int(feature.qualifiers['transl_table'][0])
        else:
            table_code = get_table_code(seq)

        nucl = feature.extract(seq.seq)
        cu = codon_usage(table_code, nucl, normalize=False)
        if cu is not None:
            cu, translated = cu
            cds_stats.append(cu)

            aa.append(seq.annotations['organism'].replace('/', '_'))

            k = 'protein_id' if 'protein_id' in feature.qualifiers else 'label'
            if 'gene' in feature.qualifiers:
                cds_col_names.append(feature.qualifiers[k][0] + '|' + feature.qualifiers['gene'][0])
                aa.append(feature.qualifiers['gene'][0])
                aa.append(feature.qualifiers[k][0])
            elif 'label' in feature.qualifiers:
                cds_col_names.append(feature.qualifiers[k][0])
                aa.append(feature.qualifiers['label'][0])
                aa.append(feature.qualifiers[k][0])
            else:
                cds_col_names.append(feature.qualifiers[k][0])
                aa.append(feature.qualifiers['product'][0])
                aa.append(feature.qualifiers[k][0])

            if translated is not None:
                aa.append(translated)
            else:
                aa.append('None')
            if 'translation' in feature.qualifiers:
                aa.append(feature.qualifiers['translation'][0])
            else:
                aa.append('None')
            aa_table = aa_table.append(pd.Series(aa), ignore_index=True)
            aa = []

    if len(cds_stats) == 0:
        return None, None
    cds_stat_table = pd.concat(cds_stats, axis=1)
    cds_stat_table.columns = cds_col_names

    aa_table.columns = ['OrganismName', 'GenName', 'GenID', 'TranslatedAminoAcids', 'GenBankAminoAcids']

    return cds_stat_table, aa_table


if __name__ == '__main__':
    seq_reader = SeqIO.parse(f'../../Body/1Raw/mitochondrion.genomic.gbff', format='genbank')

    for sequence in tqdm.tqdm(seq_reader):
        stat_tbl, aa_tbl = cds_codon_usage(sequence)

        orgname = sequence.annotations['organism'].replace('/', '_')
        if stat_tbl is not None:
            stat_tbl.to_csv(f'../../Body/2Derived/codon_usage/{sequence.name}_{orgname}.tsv', sep='\t')
        if aa_tbl is not None:
            aa_tbl.to_csv(f'../../Body/2Derived/aminoacids/{sequence.name}_{orgname}.tsv', sep='\t')
