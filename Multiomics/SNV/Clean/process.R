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

SNV_ALL_LIST=list()
SNV_LNC_LIST=list()
SNV_PCG_LIST=list()
SNV_ALL_LIST[33+1]=NULL
SNV_LNC_LIST[33+1]=NULL
SNV_PCG_LIST[33+1]=NULL
names(SNV_ALL_LIST)=cancer_names	#未用到
names(SNV_LNC_LIST)=cancer_names
names(SNV_PCG_LIST)=cancer_names

lnc_path_name1="/mnt/5468d/gaomeihong/LncRNA3/GENCODE/Decompression/lncRNA.txt"
pc_path_name1="/mnt/5468d/gaomeihong/LncRNA3/GENCODE/Decompression/pc.txt"
LNC=read.table(file = lnc_path_name1,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)
PCG=read.table(file = pc_path_name1,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)
lp_path_name="/mnt/5468d/gaomeihong/LncRNA3/GAE_LGA/Datasets/Dataset3/lnc_pcg_net.txt"
LP=read.table(file = lp_path_name,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)		


for(i in 1:length(cancer_names))
{
	print(i)
	snv_path_name=paste("./somaticsniper/New/TCGA.", cancer_names[i], sep = "", collapse = "")
	snv_out_name=paste(snv_path_name, ".somaticsniper.somatic.maf.uni.txt", sep = "", collapse = "")
	snv_out_lnc_name=paste(snv_path_name, ".somaticsniper.somatic.maf.uni.lncRNA.txt", sep = "", collapse = "")
	snv_out_pcg_name=paste(snv_path_name, ".somaticsniper.somatic.maf.uni.pcg.txt", sep = "", collapse = "")
	snv_path_name=paste(snv_path_name, ".somaticsniper.somatic.maf.txt", sep = "", collapse = "")

	SNV=read.table(file = snv_path_name,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)
	print(nrow(SNV))
	SNV=subset(SNV, select = -X )
	SNV=SNV[order(SNV[,1]),]
	
	SNV=SNV[!duplicated(SNV$Hugo_Symbol),] #delete the duplicate gene item
	print(nrow(SNV))

	lnc_name=intersect(intersect(SNV$Hugo_Symbol,LNC$gene_name),LP$Gene_name)
	pcg_name=intersect(intersect(SNV$Hugo_Symbol,PCG$gene_name),colnames(LP))
	LP2=LP[which(LP$Gene_name %in% lnc_name),which(colnames(LP) %in% pcg_name)]
	print(sum(LP==1))
	print(sum(LP2==1))
	SNV_LNC=SNV[which(SNV$Hugo_Symbol %in% lnc_name),]
	SNV_PCG=SNV[which(SNV$Hugo_Symbol %in% pcg_name),]
	
	SNV_LNC_LIST[[i]]=SNV_LNC	
	SNV_PCG_LIST[[i]]=SNV_PCG
	SNV_ALL_LIST[[i]]=SNV
		
	write.table(SNV, file =snv_out_name,sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);
	write.table(SNV_LNC, file =snv_out_lnc_name,sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);
	write.table(SNV_PCG, file =snv_out_pcg_name,sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);	
}

lnc_names=intersect(LP$Gene_name,LNC$gene_name)
pcg_names=intersect(colnames(LP),PCG$gene_name)
#pcg_names=c()
#lnc_names=c()
#for (i in 1:33)
#{
#	lnc_names=union(lnc_names,SNV_LNC_LIST[[i]]$Hugo_Symbol)
#	pcg_names=union(pcg_names,SNV_PCG_LIST[[i]]$Hugo_Symbol)
#}

LNC_FEAT=matrix(0,length(lnc_names),2*33+1)
PCG_FEAT=matrix(0,length(pcg_names),2*33+1)
rownames(LNC_FEAT)=lnc_names
rownames(PCG_FEAT)=pcg_names
LNC_FEAT[,1]=lnc_names
PCG_FEAT[,1]=pcg_names

feat_names=c("Hugo_Symbol")
for(i in 1:33)
{
	feat_name_temp=paste("SNV_",cancer_names[i], sep = "", collapse = "")
	feat_name1=paste(feat_name_temp,"_CHR", sep = "", collapse = "")
	feat_name2=paste(feat_name_temp,"_POS", sep = "", collapse = "")
	feat_names=c(feat_names,feat_name1,feat_name2)

}
colnames(LNC_FEAT)=feat_names
colnames(PCG_FEAT)=feat_names

#对每个lnc_names项，计算其特征值
for(i in 1:33)
{
	LNC_FEAT[SNV_LNC_LIST[[i]][,1],2*i]=SNV_LNC_LIST[[i]][,2]
	LNC_FEAT[SNV_LNC_LIST[[i]][,1],2*i+1]=SNV_LNC_LIST[[i]][,3]
	
	PCG_FEAT[SNV_PCG_LIST[[i]][,1],2*i]=SNV_PCG_LIST[[i]][,2]
	PCG_FEAT[SNV_PCG_LIST[[i]][,1],2*i+1]=SNV_PCG_LIST[[i]][,3]
}

write.table(LNC_FEAT, file ="SNV_lnc_feature3.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);
write.table(PCG_FEAT, file ="SNV_pcg_feature3.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);	
