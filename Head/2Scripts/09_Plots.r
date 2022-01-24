library(ggplot2)
cu <- read.csv('/home/emulciber/MitoClub/mtDnaInvertebrate/Body/2Derived/08_CodonUsageDerived.csv', sep=';')

cu$Group1 <- factor(cu$Group1 , levels=c('Eukaryota:Other', 'Fungi', 'Plants', 'Invertebrates', 'Vertebrata', 'Actinopterygii', 'Amphibia', 'Reptilia', 'Mammalia', 'Aves'))
cu$Group2 <- factor(cu$Group2, levels=c("NotAssigned","Fungi:Other","Fungi:Ascomycota","Fungi:Basidiomycota","Stramenopiles","Rhodophyta","Viridiplantae:Chlorophyta","Viridiplantae:Streptophyta:Other","Viridiplantae:Streptophyta:Bryophyta","Viridiplantae:Streptophyta:Marchantiophyta","Viridiplantae:Streptophyta:Tracheophyta","Metazoa:Other","Porifera","Cnidaria","Echinodermata","Ecdysozoa:Other","Ecdysozoa:Hexapoda","Ecdysozoa:Chelicerata","Ecdysozoa:Crustacea","Ecdysozoa:Nematoda","Spiralia","Lophotrochozoa","Lophotrochozoa:Mollusca","Chordata:Other","Vertebrata:Other","Vertebrata:Chondrychthyes","Vertebrata:Actinopterygii","Vertebrata:Amphibia:Other","Vertebrata:Amphibia:Anura","Vertebrata:Amphibia:Caudata","Vertebrata:Archelosauria","Vertebrata:Lepidosauria","Vertebrata:Mammalia","Vertebrata:Aves"))


boxplot(Gainers ~ Group1, data=cu)
boxplot(Gainers ~ Group2, data=cu, subset=GenName %in% c('ND1', 'ND2', 'ND3', 'ND4', 'ND4L', 'ND5', 'COX1', 'COX2', 'COX3', 'CYTB', 'ATP6', 'ATP8'))

boxplot(Losers ~ Group1, data=cu, subset=GenName %in% c('ND1', 'ND2', 'ND3', 'ND4', 'ND4L', 'ND5', 'COX1', 'COX2', 'COX3', 'CYTB', 'ATP6', 'ATP8'))
boxplot(Losers ~ Group2, data=cu, subset=GenName %in% c('ND1', 'ND2', 'ND3', 'ND4', 'ND4L', 'ND5', 'COX1', 'COX2', 'COX3', 'CYTB', 'ATP6', 'ATP8'))

#sorted by y

ggplot(subset(cu, GenName %in% c('ND1', 'ND2', 'ND3', 'ND4', 'ND4L', 'ND5', 'COX1', 'COX2', 'COX3', 'CYTB', 'ATP6', 'ATP8')), aes(y = Gainers, x = reorder(Group2, Gainers)))+
  geom_boxplot(fill='red')+
  theme(axis.text.x = element_text(angle=90, hjust=1))

ggplot(subset(cu, GenName %in% c('ND1', 'ND2', 'ND3', 'ND4', 'ND4L', 'ND5', 'COX1', 'COX2', 'COX3', 'CYTB', 'ATP6', 'ATP8')), aes(y = Losers, x = reorder(Group2, Losers)))+
  geom_boxplot(fill='grey')+
  theme(axis.text.x = element_text(angle=90, hjust=1))  

ggplot(subset(cu, GenName %in% 'ND6'), aes(y = Gainers, x = reorder(Group2, Gainers)))+
  geom_boxplot(fill='red')+
  theme(axis.text.x = element_text(angle=90, hjust=1))

ggplot(subset(cu, GenName %in% 'ND6'), aes(y = Losers, x = reorder(Group2, Losers)))+
  geom_boxplot(fill='grey')+
  theme(axis.text.x = element_text(angle=90, hjust=1))

# not sorted

ggplot(subset(cu, GenName %in% c('ND1', 'ND2', 'ND3', 'ND4', 'ND4L', 'ND5', 'COX1', 'COX2', 'COX3', 'CYTB', 'ATP6', 'ATP8')), aes(y = Gainers, x = Group2))+
  geom_boxplot(fill='red')+
  theme(axis.text.x = element_text(angle=90, hjust=1))

ggplot(subset(cu, GenName %in% c('ND1', 'ND2', 'ND3', 'ND4', 'ND4L', 'ND5', 'COX1', 'COX2', 'COX3', 'CYTB', 'ATP6', 'ATP8')), aes(y = Losers, x = Group2))+
  geom_boxplot(fill='grey')+
  theme(axis.text.x = element_text(angle=90, hjust=1))  

ggplot(subset(cu, GenName %in% 'ND6'), aes(y = Gainers, x = Group2))+
  geom_boxplot(fill='red')+
  theme(axis.text.x = element_text(angle=90, hjust=1))

ggplot(subset(cu, GenName %in% 'ND6'), aes(y = Losers, x = Group2))+
  geom_boxplot(fill='grey')+
  theme(axis.text.x = element_text(angle=90, hjust=1))

ggplot(subset(cu, GenName %in% 'ND6'), aes(y = Losers, x = Group2))+
  geom_boxplot(fill='grey')+
  theme(axis.text.x = element_text(angle=90, hjust=1))

### correlation

g_atp6 <- unique(cu[cu$GenName == 'ATP6', c('OrganismName', 'Gainers')])
names(g_atp6)[2] <- 'ATP6'
g_atp8 <- unique(cu[cu$GenName == 'ATP8', c('OrganismName', 'Gainers')])
names(g_atp8)[2] <- 'ATP8'
g_cox1 <- unique(cu[cu$GenName == 'COX1', c('OrganismName', 'Gainers')])
names(g_cox1)[2] <- 'COX1'
g_cox2 <- unique(cu[cu$GenName == 'COX2', c('OrganismName', 'Gainers')])
names(g_cox2)[2] <- 'COX2'
g_cox3 <- unique(cu[cu$GenName == 'COX3', c('OrganismName', 'Gainers')])
names(g_cox3)[2] <- 'COX3'
g_cytb <- unique(cu[cu$GenName == 'CYTB', c('OrganismName', 'Gainers')])
names(g_cytb)[2] <- 'CYTB'
g_nd1 <- unique(cu[cu$GenName == 'ND1', c('OrganismName', 'Gainers')])
names(g_nd1)[2] <- 'ND1'
g_nd2 <- unique(cu[cu$GenName == 'ND2', c('OrganismName', 'Gainers')])
names(g_nd2)[2] <- 'ND2'
g_nd3 <- unique(cu[cu$GenName == 'ND3', c('OrganismName', 'Gainers')])
names(g_nd3)[2] <- 'ND3'
g_nd4 <- unique(cu[cu$GenName == 'ND4', c('OrganismName', 'Gainers')])
names(g_nd4)[2] <- 'ND4'
g_nd4l <- unique(cu[cu$GenName == 'ND4L', c('OrganismName', 'Gainers')])
names(g_nd4l)[2] <- 'ND4L'
g_nd5 <- unique(cu[cu$GenName == 'ND5', c('OrganismName', 'Gainers')])
names(g_nd5)[2] <- 'ND5'
g_nd6 <- unique(cu[cu$GenName == 'ND6', c('OrganismName', 'Gainers')])
names(g_nd6)[2] <- 'ND6'

l_atp6 <- cu[cu$GenName == 'ATP6', c('OrganismName', 'Losers')]
l_atp8 <- cu[cu$GenName == 'ATP8', c('OrganismName', 'Losers')]
l_cox1 <- cu[cu$GenName == 'COX1', c('OrganismName', 'Losers')]
l_cox2 <- cu[cu$GenName == 'COX2', c('OrganismName', 'Losers')]
l_cox3 <- cu[cu$GenName == 'COX3', c('OrganismName', 'Losers')]
l_cytb <- cu[cu$GenName == 'CYTB', c('OrganismName', 'Losers')]
l_nd1 <- cu[cu$GenName == 'ND1', c('OrganismName', 'Losers')]
l_nd2 <- cu[cu$GenName == 'ND2', c('OrganismName', 'Losers')]
l_nd3 <- cu[cu$GenName == 'ND3', c('OrganismName', 'Losers')]
l_nd4 <- cu[cu$GenName == 'ND4', c('OrganismName', 'Losers')]
l_nd4l <- cu[cu$GenName == 'ND4L', c('OrganismName', 'Losers')]
l_nd5 <- cu[cu$GenName == 'ND5', c('OrganismName', 'Losers')]
l_nd6 <- cu[cu$GenName == 'ND6', c('OrganismName', 'Losers')]



golden_subset <- merge(merge(merge(merge(merge(merge(merge(merge(merge(merge(merge(merge(
  g_atp6, 
  g_atp8, all=FALSE, by='OrganismName'),
  g_cox1, all=FALSE, by='OrganismName'),
  g_cox2, all=FALSE, by='OrganismName'),
  g_cox3, all=FALSE, by='OrganismName'),
  g_cytb, all=FALSE, by='OrganismName'),
  g_nd1, all=FALSE, by='OrganismName'),
  g_nd2, all=FALSE, by='OrganismName'),
  g_nd3, all=FALSE, by='OrganismName'),
  g_nd4, all=FALSE, by='OrganismName'),
  g_nd4l, all=FALSE, by='OrganismName'),
  g_nd5, all=FALSE, by='OrganismName'),
  g_nd6, all=FALSE, by='OrganismName')


all_set <- merge(merge(merge(merge(merge(merge(merge(merge(merge(merge(merge(merge(
  g_atp6, 
  g_atp8, all=TRUE, by='OrganismName'),
  g_cox1, all=TRUE, by='OrganismName'),
  g_cox2, all=TRUE, by='OrganismName'),
  g_cox3, all=TRUE, by='OrganismName'),
  g_cytb, all=TRUE, by='OrganismName'),
  g_nd1, all=TRUE, by='OrganismName'),
  g_nd2, all=TRUE, by='OrganismName'),
  g_nd3, all=TRUE, by='OrganismName'),
  g_nd4, all=TRUE, by='OrganismName'),
  g_nd4l, all=TRUE, by='OrganismName'),
  g_nd5, all=TRUE, by='OrganismName'),
  g_nd6, all=TRUE, by='OrganismName')


set_rcorr <- as.matrix(all_set[, 2:14])
mat1 <- rcorr(set_rcorr, type='pearson')
p_value <- round(mat1[['P']], 3)
p_value

ggcorr(set_rcorr, method=c('pairwise', 'spearman'))
