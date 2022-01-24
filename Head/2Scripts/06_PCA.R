Tax = read.table('C:/Users/PC/Desktop/MitoClub/MtDnaInvertebrate/Body/2Derived/MtDnaFullListTR.csv', head = TRUE, sep = ';', comment.char = "")

addcols <- which(colnames(Tax) == c('X','RefSeqID', 'SpeciesNames', 'Taxonomy', 'Group1', 'Num', 'X.C', 'X.G', 'X.T', 'GC', 'Log2Lenght'))

Tax[1:9] <- list(NULL)
Tax[5] <- list(NULL)
Tax[6] <- list(NULL)
Tax[7] <- list(NULL)

Group2 <- which(colnames(Tax) == "Group2")

plot(Tax)
Tax_pca <- prcomp(Tax[, -Group2], scale = TRUE)
print(Tax_pca)
biplot(Tax_pca, col = c("white", "black"))

Tax_pca$x
