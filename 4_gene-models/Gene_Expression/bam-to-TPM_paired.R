library(methods)
library(Rsubread)
library(edgeR)

wd=getwd()

fc <- featureCounts(files = grep("Aligned.sortedByCoord.out.bam", list.files(path = wd, 
                   full.names = TRUE, recursive = TRUE, include.dirs = TRUE), value = TRUE), 
                   annot.ext="/data/prj/urchin/red-urchin-genome/TPM_gene-expression/Mfran-CDS_v3.gtf" ,
                    isGTFAnnotationFile=TRUE, genome="/data/prj/urchin/red-urchin-genome/MFR_genome_v2-renamed.fa", 
                    isPairedEnd=TRUE, GTF.featureType="CDS", GTF.attrType="transcript_id", nthread=16, 
                    maxFragLength=100000, allowMultiOverlap=TRUE, countMultiMappingReads=TRUE, minOverlap=0,
                     requireBothEndsMapped=FALSE)

fc_x <- DGEList(counts=fc$counts, genes=fc$annotation[,c("GeneID", "Length")])
fc_rpkm <- edgeR::rpkm(fc_x, fc_x$genes$Length)
fc_ColumnSumforTPM <-1000000/colSums(fc_rpkm)
fc_tpm <- sweep(fc_rpkm, 2, fc_ColumnSumforTPM, '*')

save.image("pr_TPMs.RData")
write.csv(fc_tpm,"pr_TPMs.csv")

