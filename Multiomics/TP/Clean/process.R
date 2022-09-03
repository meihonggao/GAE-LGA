###################################################################################################
#思路：	将表达数据处理为特征矩阵
		#1.读入lncRNA和pc文件
		#2.读入lnc和pcg的tp文件
		#3.将每行取均值
		#4.比较并输出lncRNA与pc的表达矩阵
###################################################################################################
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


TP_LNC_LIST=list()
TP_PCG_LIST=list()

TP_LNC_LIST[33+1]=NULL
TP_PCG_LIST[33+1]=NULL

names(TP_LNC_LIST)=cancer_names
names(TP_PCG_LIST)=cancer_names

lnc_path_name="/mnt/5468d/gaomeihong/LncRNA3/GENCODE/Decompression/lncRNA.txt"
pc_path_name="/mnt/5468d/gaomeihong/LncRNA3/GENCODE/Decompression/pc.txt"
LNC=read.table(file = lnc_path_name,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)
PCG=read.table(file = pc_path_name,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)

lp_path_name="/mnt/5468d/gaomeihong/LncRNA3/GAE_LGA/Datasets/Dataset3/lnc_pcg_net.txt"
LP=read.table(file = lp_path_name,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)	

lnc_names=intersect(LP$Gene_name,LNC$gene_name)
pcg_names=intersect(colnames(LP),PCG$gene_name)

TP_LNC_FEAT=matrix(0,length(lnc_names),2*33+1)
TP_PCG_FEAT=matrix(0,length(pcg_names),2*33+1)
rownames(TP_LNC_FEAT)=lnc_names
rownames(TP_PCG_FEAT)=pcg_names	
TP_LNC_FEAT[,1]=lnc_names
TP_PCG_FEAT[,1]=pcg_names
				
feat_names=c("GeneSymbol")
for(i in 1:33)
{
	feat_name_temp=paste("TP_",cancer_names[i], sep = "", collapse = "")
	feat_name1=paste(feat_name_temp,"_MEAN", sep = "", collapse = "")
	feat_name2=paste(feat_name_temp,"_STD", sep = "", collapse = "")
	feat_names=c(feat_names,feat_name1,feat_name2)
}
colnames(TP_LNC_FEAT)=feat_names
colnames(TP_PCG_FEAT)=feat_names


#获取lnc_names和pcg_names的值
for(i in 1:length(cancer_names))
{
	print(i)
	tp_lnc_path_name=paste("./New/", cancer_names[i], ".lncRNA.txt", sep = "", collapse = "")
	tp_pcg_path_name=paste("./New/", cancer_names[i], ".pcg.txt", sep = "", collapse = "")
	
	TP_LNC=read.table(file = tp_lnc_path_name,
					sep = "\t", header = FALSE, 
					row.names = NULL, stringsAsFactors = FALSE)
	TP_PCG=read.table(file = tp_pcg_path_name,
					sep = "\t", header = FALSE, 
					row.names = NULL, stringsAsFactors = FALSE)
					
	TP_LNC<-TP_LNC[,-which(apply(TP_LNC,2,function(x) all(is.na(x))))]
	TP_PCG<-TP_PCG[,-which(apply(TP_PCG,2,function(x) all(is.na(x))))]
	
	
	TP_LNC=TP_LNC [which(TP_LNC[,1] %in% lnc_names),]
	TP_PCG=TP_PCG [which(TP_PCG[,1] %in% pcg_names),]
	
	TP_LNC=TP_LNC[!duplicated(TP_LNC[,1]),] #delete the duplicate lncRNA item
	TP_PCG=TP_PCG[!duplicated(TP_PCG[,1]),] #delete the duplicate gene item
	
	rownames(TP_LNC)=TP_LNC[,1]
	rownames(TP_PCG)=TP_PCG[,1]
	
	TP_LNC=TP_LNC[,-1]
	TP_PCG=TP_PCG[,-1]
	
	for(j in 1:length(lnc_names))
	{
		TP_LNC_FEAT[j,2*i]=mean(as.numeric(TP_LNC[j,]))
		TP_LNC_FEAT[j,2*i+1]=sd(as.numeric(TP_LNC[j,]))
	}


	for(j in 1:length(pcg_names))
	{
		TP_PCG_FEAT[j,2*i]=mean(as.numeric(TP_PCG[j,]))
		TP_PCG_FEAT[j,2*i+1]=sd(as.numeric(TP_PCG[j,]))
	}
	
	#未用到
	TP_LNC_LIST[[i]]=TP_LNC	
	TP_PCG_LIST[[i]]=TP_PCG
}

write.table(TP_LNC_FEAT, file ="TP_lnc_feature3.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);
write.table(TP_PCG_FEAT, file ="TP_pcg_feature3.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);	