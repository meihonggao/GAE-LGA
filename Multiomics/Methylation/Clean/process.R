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


METHY_ALL_LIST=list()
METHY_LNC_LIST=list()
METHY_PCG_LIST=list()
METHY_ALL_LIST[33+1]=NULL
METHY_LNC_LIST[33+1]=NULL
METHY_PCG_LIST[33+1]=NULL
names(METHY_ALL_LIST)=cancer_names	#未用到
names(METHY_LNC_LIST)=cancer_names
names(METHY_PCG_LIST)=cancer_names

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


#for(i in 1:length(cancer_names))
for(i in c(1:6,10,13,14,18,20,24))
{
	print(i)
	methy_path_name=paste("./New/TCGA/TCGA-", cancer_names[i], sep = "", collapse = "")
	methy_out_name=paste(methy_path_name, ".merge.dnamethy.uni.txt", sep = "", collapse = "")
	methy_out_lnc_name=paste(methy_path_name, ".merge.dnamethy.uni.lncRNA.txt", sep = "", collapse = "")
	methy_out_pcg_name=paste(methy_path_name, ".merge.dnamethy.uni.pcg.txt", sep = "", collapse = "")
	methy_path_name=paste(methy_path_name, ".merge.dnamethy.txt", sep = "", collapse = "")

	METHY=read.table(file = methy_path_name,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)
	print(nrow(METHY))
	
	METHY=subset(METHY, select = -X )
	METHY=na.omit(METHY)
	METHY=METHY[!duplicated(METHY$Gene_Symbol),] #delete the duplicate item
	print(nrow(METHY))
	
	METHY=METHY[METHY$Beta_value!='Beta_value',] #delete the duplicate row (column name) which is prodeced by cat
	print(nrow(METHY))
	
	lnc_name=intersect(intersect(METHY$Gene_Symbol,LNC$gene_name),LP$Gene_name)
	pcg_name=intersect(intersect(METHY$Gene_Symbol,PCG$gene_name),colnames(LP))
	LP2=LP[which(LP$Gene_name %in% lnc_name),which(colnames(LP) %in% pcg_name)]
	print(sum(LP==1))
	print(sum(LP2==1))
	METHY_LNC=METHY[which(METHY$Gene_Symbol %in% lnc_name),]
	METHY_PCG=METHY[which(METHY$Gene_Symbol %in% pcg_name),]
	
	METHY_LNC_LIST[[i]]=METHY_LNC	
	METHY_PCG_LIST[[i]]=METHY_PCG
	METHY_ALL_LIST[[i]]=METHY
		
	write.table(METHY, file =methy_out_name,sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);
	write.table(METHY_LNC, file =methy_out_lnc_name,sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);
	write.table(METHY_PCG, file =methy_out_pcg_name,sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);	

	#METHY_ALL=rbind(METHY_ALL,METHY)	
}

#write.table(METHY_ALL, file ="METHY.process.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);


lnc_names=intersect(LP$Gene_name,LNC$gene_name)
pcg_names=intersect(colnames(LP),PCG$gene_name)
					
LNC_FEAT=matrix(0,length(lnc_names),4*12+1)
PCG_FEAT=matrix(0,length(pcg_names),4*12+1)
rownames(LNC_FEAT)=lnc_names
rownames(PCG_FEAT)=pcg_names
LNC_FEAT[,1]=lnc_names
PCG_FEAT[,1]=pcg_names

feat_names=c("Gene_Symbol")
for(i in c(1:6,10,13,14,18,20,24))
{
	feat_name_temp=paste("METHY_",cancer_names[i], sep = "", collapse = "")
	feat_name1=paste(feat_name_temp,"_BETA", sep = "", collapse = "")
	feat_name2=paste(feat_name_temp,"_CHR", sep = "", collapse = "")
	feat_name3=paste(feat_name_temp,"_START", sep = "", collapse = "")
	feat_name4=paste(feat_name_temp,"_END", sep = "", collapse = "")
	feat_names=c(feat_names,feat_name1,feat_name2,feat_name3,feat_name4)
}
colnames(LNC_FEAT)=feat_names
colnames(PCG_FEAT)=feat_names

#对每个lnc_names项，计算其特征值
index=0
for(i in c(1:6,10,13,14,18,20,24))
{
	index=index+1
	LNC_FEAT[METHY_LNC_LIST[[i]][,5],4*index-2]=METHY_LNC_LIST[[i]][,1]
	LNC_FEAT[METHY_LNC_LIST[[i]][,5],4*index-1]=METHY_LNC_LIST[[i]][,2]
	LNC_FEAT[METHY_LNC_LIST[[i]][,5],4*index]=METHY_LNC_LIST[[i]][,3]
	LNC_FEAT[METHY_LNC_LIST[[i]][,5],4*index+1]=METHY_LNC_LIST[[i]][,4]
	
	PCG_FEAT[METHY_PCG_LIST[[i]][,5],4*index-2]=METHY_PCG_LIST[[i]][,1]
	PCG_FEAT[METHY_PCG_LIST[[i]][,5],4*index-1]=METHY_PCG_LIST[[i]][,2]
	PCG_FEAT[METHY_PCG_LIST[[i]][,5],4*index]=METHY_PCG_LIST[[i]][,3]
	PCG_FEAT[METHY_PCG_LIST[[i]][,5],4*index+1]=METHY_PCG_LIST[[i]][,4]
}

write.table(LNC_FEAT, file ="METHY_lnc_feature3.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);
write.table(PCG_FEAT, file ="METHY_pcg_feature3.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);	


