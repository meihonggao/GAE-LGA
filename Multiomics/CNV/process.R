#将33个文件读入，处理好之后进行输出

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

for(i in 1:length(cancer_names))
#for(i in 1:3)
{
	print(i)
	cnv_path_name=paste("./New/TCGA/TCGA-", cancer_names[i], sep = "", collapse = "")
	cnv_out_name=paste(cnv_path_name, ".merge.nocnv.uni.txt", sep = "", collapse = "")
	cnv_path_name=paste(cnv_path_name, ".merge.nocnv.txt", sep = "", collapse = "")

	CNV=read.table(file = cnv_path_name,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)
	CNV=CNV[,2:ncol(CNV)]
	print(nrow(CNV))
	#CNV=subset(CNV, select = -X )
	CNV=CNV[!duplicated(CNV),] #delete the duplicate gene item
	print(nrow(CNV))
	CNV= CNV[CNV$Chromosome !='Chromosome',]
	print(nrow(CNV))
		
	write.table(CNV, file =cnv_out_name,sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);	
}