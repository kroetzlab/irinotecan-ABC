##### Univariate analysis
### For a trait in pheno, perform linear regression using the genotype data provided in geno
###
### *** input ***
### pheno: matrix of trait values
###     rows: samples
###     columns: traits, with colnames(pheno) being names of the traits
### geno: matrix of genotypes coded as 0,1,2,NA (number of minor alleles)
###     rows: samples
###     columns: markers, with colnames(geno) being SNP IDs
###
### *** output ***
### results: m-by-5 matrix
###     rows: markers
###     columns: "snp", "Estimate", "Std. Error", "t value", "P"
### top: subset of results matrix, listing only markers for which P<0.15

snplist <- names(geno)[1:length(names(geno))]
out <- lapply(snplist, function(x) {
        fit <- lm(substitute(pheno$traitname ~ i, list(i = as.name(x))), data=geno) #replace traitname with trait in colnames(pheno) being tested
        coef(summary(fit))[2,]
        })

results <- data.frame(snplist = snplist,
                      do.call(rbind, out))
names(results) <- c("snp", "Estimate", "Std. Error", "t value", "P")
results
        
top <- results[which(results[,"P"]<0.15),]
top

