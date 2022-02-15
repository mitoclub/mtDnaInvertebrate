from Bio import SeqIO
from Bio import Seq
import tqdm
import pandas as pd

if __name__ == '__main__':
    species = []
    gene = []
    code = []
    cds = []
    sequence = []

    count_passed = 0
    count_passed_code = 0
    count_nucl = 0
    count_aminoacids = 0

    seq_reader = SeqIO.parse(f'../../Body/1Raw/mitochondrion.genomic.gbff', format='genbank')

    for record in tqdm.tqdm(seq_reader):
        try:
            for feature in record.features:
                if feature.type != 'CDS' or feature.strand != 1:
                    continue

                seq_str = str(feature.extract(record.seq))
                if len(seq_str) == 0:
                    count_passed += 1
                    continue
                if 'transl_table' not in feature.qualifiers:
                    count_passed_code += 1
                    continue

                sequence.append(seq_str)

                species.append(record.annotations['organism'].replace('/', ' ').replace('_', ' '))
                g = 'gene' if 'gene' in feature.qualifiers else 'product'
                gene.append(feature.qualifiers[g][0])
                code.append(int(feature.qualifiers['transl_table'][0]))
                cds.append(0)
                count_nucl += 1

                if 'translation' in feature.qualifiers:
                    sequence.append(str(feature.qualifiers['translation'][0]))
                    species.append(record.annotations['organism'].replace('/', ' ').replace('_', ' '))
                    p = 'protein_id' if 'protein_id' in feature.qualifiers else 'product'
                    gene.append(feature.qualifiers[p][0])
                    code.append(int(feature.qualifiers['transl_table'][0]))
                    cds.append(1)
                    count_aminoacids += 1

        except Seq.UndefinedSequenceError:
            continue

    derived_table = pd.DataFrame()
    derived_table['Species'] = species
    derived_table['Gene'] = gene
    derived_table['Code'] = code
    derived_table['CDS'] = cds
    derived_table['Sequence'] = sequence

    derived_table = derived_table.sort_values(by='Gene')

    dataframes = []
    while len(derived_table) > 10:
        ten = derived_table[:10]
        dataframes.append(ten)
        derived_table = derived_table[10:]
    else:
        dataframes.append(derived_table)

    for _, df in enumerate(dataframes):
        df.to_csv(f'../../Body/2Derived/FilesForMonster/{str(_)}.csv', index=False, sep='\t')

    print(f'Пропущено последовательностей - {count_passed}')
    print(f'Пропущено из-за отсутствия генетического кода - {count_passed_code}')
    print(f'Всего нуклеотидных последовательностей - {count_nucl}')
    print(f'Всего аминокислотных последовательностей - {count_aminoacids}')

