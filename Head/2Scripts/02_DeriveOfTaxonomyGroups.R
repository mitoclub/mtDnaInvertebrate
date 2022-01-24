###################################
###### 
###################################

rm(list=ls(all=TRUE))
Tax = read.table('/home/emulciber/MitoClub/mtDnaInvertebrate/Body/2Derived/01_MtDnaFullList.csv', head = TRUE, sep = ';', comment.char = "") # because there is '#' in 4422	NW_003307477.1	Coprinopsis cinerea okayama7#130	['Eukaryota', 'Fungi', 'Dikarya', 'Basidiomycota', 'Agaricomycotina', 'Agaricomycetes', 'Agaricomycetidae', 'Agaricales', 'Psathyrellaceae', 'Coprinopsis']
Tax$Group1 = 'Eukaryota'
Tax$Group2 = 'Eukaryota:Other'
for (i in 1:nrow(Tax))
{ # i = 16
  if (length(grep('Fungi',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Fungi'}
    if (length(grep('Fungi',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Fungi:Other'}
    if (length(grep('Ascomycota',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Fungi:Ascomycota'}
    if (length(grep('Basidiomycota',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Fungi:Basidiomycota'}
  if (length(grep('Viridiplantae',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Viridiplantae'}
  if (length(grep('Viridiplantae',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Viridiplantae:Other'}
    if (length(grep('Chlorophyta',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Viridiplantae:Chlorophyta'}
    if (length(grep('Streptophyta',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Viridiplantae:Streptophyta:Other'}
    if (length(grep('Bryophyta',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Viridiplantae:Streptophyta:Bryophyta'}
    if (length(grep('Marchantiophyta',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Viridiplantae:Streptophyta:Marchantiophyta'}
    if (length(grep('Tracheophyta',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Viridiplantae:Streptophyta:Tracheophyta'}
  if (length(grep('Stramenopiles',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Stramenopiles'}
    if (length(grep('Stramenopiles',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Stramenopiles'}
  if (length(grep('Rhodophyta',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Rhodophyta'}
   if (length(grep('Rhodophyta',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Rhodophyta'}
  if (length(grep('Metazoa',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Metazoa'}
    if (length(grep('Metazoa',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Metazoa:Other'}
    if (length(grep('Chordata',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Chordata:Other'}
  if (length(grep('Cnidaria',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Cnidaria'} 
    if (length(grep('Cnidaria',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Cnidaria'} 
  if (length(grep('Ecdysozoa',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Ecdysozoa'}
    if (length(grep('Ecdysozoa.*Chelicerata',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Ecdysozoa:Chelicerata'}
    if (length(grep('Ecdysozoa.*Crustacea',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Ecdysozoa:Crustacea'}
    if (length(grep('Ecdysozoa.*Hexapoda',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Ecdysozoa:Hexapoda'}
    if (length(grep('Ecdysozoa.*Nematoda',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Ecdysozoa:Nematoda'}
  if (length(grep('Echinodermata',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Echinodermata'}
    if (length(grep('Echinodermata',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Echinodermata'}
  if (length(grep('Lophotrochozoa',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Lophotrochozoa'}
    if (length(grep('Lophotrochozoa.*Mollusca',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Lophotrochozoa:Mollusca'}
  if (length(grep('Platyhelminthes',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Platyhelmintes'}
    if (length(grep('Platyhelminthes',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Platyhelmintes'}
  if (length(grep('Porifera',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Porifera'}
    if (length(grep('Porifera',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Porifera'}
  if (length(grep('Vertebrata',Tax$Taxonomy[i]))) {Tax$Group1[i] ='Vertebrata'}
    if (length(grep('Vertebrata',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Vertebrata:Other'}
      if (length(grep('Vertebrata.*Chondrichthyes',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Vertebrata:Chondrychthyes'}
      if (length(grep('Vertebrata.*Actinopterygii',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Vertebrata:Actinopterygii'}
      if (length(grep('Vertebrata.*Amphibia',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Vertebrata:Amphibia:Other'}
        if (length(grep('Amphibia.*Anura',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Vertebrata:Amphibia:Anura'}
        if (length(grep('Amphibia.*Caudata',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Vertebrata:Amphibia:Caudata'}
      if (length(grep('Vertebrata.*Archelosauria',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Vertebrata:Archelosauria'}
      if (length(grep('Vertebrata.*Dinosauria',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Vertebrata:Dinosauria'}
      if (length(grep('Vertebrata.*Lepidosauria',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Vertebrata:Lepidosauria'}
      if (length(grep('Vertebrata.*Mammalia',Tax$Taxonomy[i]))) {Tax$Group2[i] ='Vertebrata:Mammalia'}
  
}

table(Tax$Group1)
table(Tax$Group2)

write.table(file="/home/emulciber/MitoClub/mtDnaInvertebrate/Body/2Derived/02_DeriveOfTaxonomyGroups.csv", Tax, row.names=FALSE, sep=";")

# to see 'NotAssigned'

NotAssigned = Tax[Tax$Group1 == 'NotAssigned',]
Arthropoda = Tax[Tax$Group1 == 'Arthropoda',]
table(Arthropoda$Group2)

Fungi = Tax[Tax$Group1 == 'Fungi',]
table(Fungi$Group2)




