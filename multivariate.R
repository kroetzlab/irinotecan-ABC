##### Multivariate analysis
### For a trait in pheno, perform backward step-wise selection by P-value of
### the SNPs with P<0.15 in the univariate analysis using the genotype data provided in geno
###
### *** inputs ***
### pheno: matrix of trait values
###     rows: samples
###     columns: traits
### geno: matrix of genotypes coded as 0,1,2,NA (number of minor alleles)
###     rows: samples
###     columns: markers, with colnames(geno) being SNP IDs
###              covariates
### snplist: vector of SNP IDs for which P<0.15 in the previous univariate analysis
###
### *** output ***
### fit: fastbw object containing
###     Matrix of statistics with rows in order of deletion
###     Approximate estimates after deleting factors
###     Factors in final model

require(rms)
formula <- as.formula(paste("pheno$traitname ~ ", paste(snplist, collapse=" + "), sep="")) #replace traitname with trait in colnames(pheno) being tested
fit.full <- ols(formula, data=geno)
fit <- fastbw(fit.full, rule="p", sls=.05)
fit
