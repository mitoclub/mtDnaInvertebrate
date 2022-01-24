###################################
###### 
###################################

rm(list=ls(all=TRUE))
Tax = read.table('C:/Users/e_mulciber/Desktop/MitoClub/mtDnaInvertebrate/Body/2Derived/MtDnaFullList.csv', head = TRUE, sep = ';', comment.char = "") # because there is '#' in 4422	NW_003307477.1	Coprinopsis cinerea okayama7#130	['Eukaryota', 'Fungi', 'Dikarya', 'Basidiomycota', 'Agaricomycotina', 'Agaricomycetes', 'Agaricomycetidae', 'Agaricales', 'Psathyrellaceae', 'Coprinopsis']
Tax$Group3 = 'Eukaryota:Other'
  
  for (i in 1:nrow(Tax))
  { # i = 16
    if (length(grep('Fungi',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Fungi:Other'}
      if (length(grep('Ascomycota',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Fungi:Ascomycota'}
      if (length(grep('Basidiomycota',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Fungi:Basidiomycota'}
    if (length(grep('Viridiplantae',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Viridiplantae:Other'}
      if (length(grep('Chlorophyta',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Viridiplantae:Chlorophyta'}
      if (length(grep('Streptophyta',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Viridiplantae:Streptophyta:Other'}
      if (length(grep('Bryophyta',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Viridiplantae:Streptophyta:Bryophyta'}
      if (length(grep('Marchantiophyta',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Viridiplantae:Streptophyta:Marchantiophyta'}
      if (length(grep('Tracheophyta',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Viridiplantae:Streptophyta:Tracheophyta'}
    if (length(grep('Stramenopiles',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Stramenopiles'}
    if (length(grep('Rhodophyta',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Rhodophyta'}
    if (length(grep('Metazoa',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Metazoa'}
      if (length(grep('Cnidaria',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Invertebrata'} 
      if (length(grep('Ecdysozoa',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Invertebrata'}
      if (length(grep('Echinodermata',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Invertebrata'}
      if (length(grep('Lophotrochozoa',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Invertebrata'}
      if (length(grep('Platyhelmintes',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Invertebrata'}
      if (length(grep('Porifera',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Invertebrata'}
      if (length(grep('Spiralia',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Invertebrata'}
      if (length(grep('Vertebrata',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Vertebrata:Other'}
        if (length(grep('Vertebrata.*Chondrichthyes',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Chondrychthyes'}
        if (length(grep('Vertebrata.*Actinopterygii',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Actinopterygii'}
        if (length(grep('Vertebrata.*Amphibia',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Amphibia'}
        if (length(grep('Vertebrata.*Archelosauria',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Archelosauria'}
          if (length(grep('Vertebrata.*Crocodilia',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Crocodilia'}
          if (length(grep('Vertebrata.*Aves',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Aves'}
          if (length(grep('Vertebrata.*Testudines',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Turtles'}
        if (length(grep('Vertebrata.*Lepidosauria',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Lepidosauria'}
        if (length(grep('Vertebrata.*Mammalia',Tax$Taxonomy[i]))) {Tax$Group3[i] ='Mammalia'}

}


table(Tax$Group3)

write.table(file="C:/Users/e_mulciber/Desktop/MitoClub/MtDnaInvertebrate/Body/2Derived/AA_GenomeLenghtWithTax.csv", Tax, row.names=FALSE, sep=";")





