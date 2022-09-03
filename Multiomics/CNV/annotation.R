library(biomaRt)
library(dplyr)
library(GenomicRanges)

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

CNV_ALL_LIST=list()
CNV_LNC_LIST=list()
CNV_PCG_LIST=list()
CNV_ALL_LIST[33+1]=NULL
CNV_LNC_LIST[33+1]=NULL
CNV_PCG_LIST[33+1]=NULL
names(CNV_ALL_LIST)=cancer_names	#未用到
names(CNV_LNC_LIST)=cancer_names
names(CNV_PCG_LIST)=cancer_names

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
	cnv_path_name=paste("./New/TCGA/TCGA-", cancer_names[i], sep = "", collapse = "")
	cnv_path_name=paste(cnv_path_name, ".merge.nocnv.uni.txt", sep = "", collapse = "")

	CNV=read.table(file = cnv_path_name,
					sep = "\t", header = TRUE, 
					row.names = NULL, stringsAsFactors = FALSE)
					
	CNV %<>%
	  filter(abs(Segment_Mean) > 0.3) %>%
	  mutate(label = if_else(Segment_Mean < -0.3, 0, 1)) %>%
	  dplyr::select(-Segment_Mean) %>%
	  `names<-`(c("Chromosome", "Start", "End", "Num.of.Markers", "Aberration")) %>%
	  mutate(Chromosome = ifelse(Chromosome == "X", 23, Chromosome),
			 Chromosome = ifelse(Chromosome == "Y", 24, Chromosome),
			 Chromosome = as.integer(Chromosome)) %>%
			 as.data.frame()# 注意要转换为 data.frame 格式

	CNV <- CNV[!duplicated(CNV, fromLast=TRUE), ]
	CNV_GR <- makeGRangesFromDataFrame(CNV, keep.extra.columns = TRUE)	# 转换为 GenomicRanges 格式

	genes <- TCGAbiolinks:::get.GRCh.bioMart(genome = "hg19") %>%
	  filter(external_gene_name != "" & chromosome_name %in% c(1:22, "X", "Y")) %>%
	  mutate(
		chromosome_name = ifelse(
		  chromosome_name == "X", 23, ifelse(chromosome_name == "Y", 24, chromosome_name)
		),
		chromosome_name = as.integer(chromosome_name)
	  ) %>%
	  arrange(chromosome_name, start_position) %>%
	  dplyr::select(c("external_gene_name", "chromosome_name", "start_position","end_position")) %>%
	  `names<-`(c("GeneSymbol","Chr","Start","End"))
	genes_GR <- makeGRangesFromDataFrame(genes,keep.extra.columns = TRUE)
	
	# 寻找交叠区间
	hits <- findOverlaps(genes_GR, CNV_GR, type = "within")
	CNV_ann <- cbind(CNV[subjectHits(hits),], genes[queryHits(hits),])

	CNV_ann = CNV_ann[,c(6,1:5)]
	CNV_ann=CNV_ann[!duplicated(CNV_ann$GeneSymbol),] #delete the duplicate gene item

	lnc_name=intersect(intersect(CNV_ann$GeneSymbol,LNC$gene_name),LP$Gene_name)
	pcg_name=intersect(intersect(CNV_ann$GeneSymbo,PCG$gene_name),colnames(LP))
	LP2=LP[which(LP$Gene_name %in% lnc_name),which(colnames(LP) %in% pcg_name)]
	print(sum(LP==1))
	print(sum(LP2==1))
	CNV_LNC=CNV_ann [which(CNV_ann $GeneSymbol %in% lnc_name),]
	CNV_PCG=CNV_ann [which(CNV_ann $GeneSymbol %in% pcg_name),]
	
	CNV_LNC_LIST[[i]]=CNV_LNC	
	CNV_PCG_LIST[[i]]=CNV_PCG

	CNV_ALL_LIST[[i]]=CNV_ann
	#write.table(CNV_ann, file ="CNV.process.ann.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);
	#216544
}

lnc_names=intersect(LP$Gene_name,LNC$gene_name)
pcg_names=intersect(colnames(LP),PCG$gene_name)
					
LNC_FEAT=matrix(0,length(lnc_names),4*33+1)
PCG_FEAT=matrix(0,length(pcg_names),4*33+1)
rownames(LNC_FEAT)=lnc_names
rownames(PCG_FEAT)=pcg_names
LNC_FEAT[,1]=lnc_names
PCG_FEAT[,1]=pcg_names

feat_names=c("GeneSymbol")
for(i in 1:33)
{
	feat_name_temp=paste("CNV_",cancer_names[i], sep = "", collapse = "")
	feat_name1=paste(feat_name_temp,"_CHR", sep = "", collapse = "")
	feat_name2=paste(feat_name_temp,"_START", sep = "", collapse = "")
	feat_name3=paste(feat_name_temp,"_END", sep = "", collapse = "")
	feat_name4=paste(feat_name_temp,"_ABERATION", sep = "", collapse = "")
	feat_names=c(feat_names,feat_name1,feat_name2,feat_name3,feat_name4)
}
colnames(LNC_FEAT)=feat_names
colnames(PCG_FEAT)=feat_names

#对每个lnc_names项，计算其特征值
for(i in 1:33)
{
	LNC_FEAT[CNV_LNC_LIST[[i]][,1],4*i-2]=CNV_LNC_LIST[[i]][,2]
	LNC_FEAT[CNV_LNC_LIST[[i]][,1],4*i-1]=CNV_LNC_LIST[[i]][,3]
	LNC_FEAT[CNV_LNC_LIST[[i]][,1],4*i]=CNV_LNC_LIST[[i]][,4]
	LNC_FEAT[CNV_LNC_LIST[[i]][,1],4*i+1]=CNV_LNC_LIST[[i]][,6]
	
	PCG_FEAT[CNV_PCG_LIST[[i]][,1],4*i-2]=CNV_PCG_LIST[[i]][,2]
	PCG_FEAT[CNV_PCG_LIST[[i]][,1],4*i-1]=CNV_PCG_LIST[[i]][,3]
	PCG_FEAT[CNV_PCG_LIST[[i]][,1],4*i]=CNV_PCG_LIST[[i]][,4]
	PCG_FEAT[CNV_PCG_LIST[[i]][,1],4*i+1]=CNV_PCG_LIST[[i]][,6]
}

write.table(LNC_FEAT, file ="CNV_lnc_feature3.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);
write.table(PCG_FEAT, file ="CNV_pcg_feature3.txt",sep="\t",row.names =FALSE, col.names =TRUE, quote =TRUE);	


 
