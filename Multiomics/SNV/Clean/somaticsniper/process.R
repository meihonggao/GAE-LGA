cancer_names=c(	#33 cancers
"BRCA",
"GBM",
"OV",
"LUAD",
"UCEC",
"KIRC",
"HNSC",
"LGG",
"THCA",
"LUSC",
"PRAD",
"SKCM",
"COAD",
"STAD",
"BLCA",
"LIHC",		#i=16
"CESC",
"KIRP",
"SARC",
"LAML",
"PAAD",
"ESCA",
"PCPG",
"READ",
"TGCT",
"THYM",
"KICH",
"ACC",
"MESO",
"UVM",
"DLBC",
"UCS",
"CHOL"
)

SNV_ALL=c()

for(i in 1:length(cancer_names))
{
	print(i)
	snv_path_name=paste("TCGA.", cancer_names[i], sep = "", collapse = "")
	snv_path_name=paste(snv_path_name, ".somaticsniper.somatic.maf.txt", sep = "", collapse = "")

	SNV=read.table(file = snv_path_name,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)
	print(nrow(SNV))
	SNV=subset(SNV, select = -X )
	SNV=SNV[order(SNV[,1]),]
	SNV=SNV[!duplicated(SNV$Hugo_Symbol),] #delete the duplicate gene item
	print(nrow(SNV))
	SNV$data_type=i
	SNV_ALL=rbind(SNV_ALL,SNV)	
}
write.table(SNV_ALL, file ="SNV.process.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);


