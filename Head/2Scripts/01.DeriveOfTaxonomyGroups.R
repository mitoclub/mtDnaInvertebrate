###################################
###### 
###################################

rm(list=ls(all=TRUE))
Tax = read.table('../../Body/2Derived/MtDnaFullList.csv', head = TRUE, sep = '\t', comment.char = "") # because there is '#' in 4422	NW_003307477.1	Coprinopsis cinerea okayama7#130	['Eukaryota', 'Fungi', 'Dikarya', 'Basidiomycota', 'Agaricomycotina', 'Agaricomycetes', 'Agaricomycetidae', 'Agaricales', 'Psathyrellaceae', 'Coprinopsis']
Tax$Group1 = 'NotAssigned'
Tax$Group2 = 'NotAssigned'
for (i in 1:nrow(Tax))
{ # i = 16
  if (length(grep('Vertebrata',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Vertebrata'}
  if (length(grep('Fungi',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Fungi'}
    if (length(grep('Basidiomycota',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Fungi:Basidiomycota'}
    if (length(grep('Mucoromycota',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Fungi:Mucoromycota'}
    if (length(grep('Ascomycota',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Fungi:Ascomycota'}
  
  if (length(grep('Arthropoda',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Arthropoda'}
    if (length(grep('Hexapoda',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Arthropoda:Hexapoda'}
}

table(Tax$Group1)

# to see 'NotAssigned'

NotAssigned = Tax[Tax$Group1 == 'NotAssigned',]
Arthropoda = Tax[Tax$Group1 == 'Arthropoda',]
table(Arthropoda$Group2)

Fungi = Tax[Tax$Group1 == 'Fungi',]
table(Fungi$Group2)




