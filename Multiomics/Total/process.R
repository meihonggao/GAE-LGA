###################################################################################################
#思路：	#将lncRNA与pcg的特征矩阵整理并输出
		#1.读入lncRNA与pcg的特征矩阵
		#2.合并lncRNA特征矩阵
		#3.合并pcg特征矩阵
		#4.输出lncRNA与pcg的特征矩阵
###################################################################################################

snv_lnc_path_name="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/SNV_lnc_feature.txt"
snv_pcg_path_name="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/SNV_pcg_feature.txt"

cnv_lnc_path_name="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/CNV_lnc_feature.txt"
cnv_pcg_path_name="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/CNV_pcg_feature.txt"

methy_lnc_path_name="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/METHY_lnc_feature.txt"
methy_pcg_path_name="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/METHY_pcg_feature.txt"

tp_lnc_path_name="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/TP_lnc_feature.txt"
tp_pcg_path_name="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/TP_pcg_feature.txt"

snv_lnc_path_name2="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/SNV_lnc_feature2.txt"
snv_pcg_path_name2="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/SNV_pcg_feature2.txt"

cnv_lnc_path_name2="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/CNV_lnc_feature2.txt"
cnv_pcg_path_name2="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/CNV_pcg_feature2.txt"

methy_lnc_path_name2="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/METHY_lnc_feature2.txt"
methy_pcg_path_name2="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/METHY_pcg_feature2.txt"

tp_lnc_path_name2="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/TP_lnc_feature2.txt"
tp_pcg_path_name2="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/TP_pcg_feature2.txt"

snv_lnc_path_name3="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/SNV_lnc_feature3.txt"
snv_pcg_path_name3="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/SNV_pcg_feature3.txt"

cnv_lnc_path_name3="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/CNV_lnc_feature3.txt"
cnv_pcg_path_name3="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/CNV_pcg_feature3.txt"

methy_lnc_path_name3="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/METHY_lnc_feature3.txt"
methy_pcg_path_name3="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/METHY_pcg_feature3.txt"

tp_lnc_path_name3="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/TP_lnc_feature3.txt"
tp_pcg_path_name3="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/Raw/TP_pcg_feature3.txt"


SNV_LNC_FEAT=read.table(file = snv_lnc_path_name,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
SNV_PCG_FEAT=read.table(file = snv_pcg_path_name,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
					
CNV_LNC_FEAT=read.table(file = cnv_lnc_path_name,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
CNV_PCG_FEAT=read.table(file = cnv_pcg_path_name,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)

METHY_LNC_FEAT=read.table(file = methy_lnc_path_name,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
METHY_PCG_FEAT=read.table(file = methy_pcg_path_name,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)

TP_LNC_FEAT=read.table(file = tp_lnc_path_name,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
TP_PCG_FEAT=read.table(file = tp_pcg_path_name,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
					

SNV_LNC_FEAT2=read.table(file = snv_lnc_path_name2,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)

SNV_PCG_FEAT2=read.table(file = snv_pcg_path_name2,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
					
CNV_LNC_FEAT2=read.table(file = cnv_lnc_path_name2,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
CNV_PCG_FEAT2=read.table(file = cnv_pcg_path_name2,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)

METHY_LNC_FEAT2=read.table(file = methy_lnc_path_name2,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
METHY_PCG_FEAT2=read.table(file = methy_pcg_path_name2,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)

TP_LNC_FEAT2=read.table(file = tp_lnc_path_name2,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
TP_PCG_FEAT2=read.table(file = tp_pcg_path_name2,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)


SNV_LNC_FEAT3=read.table(file = snv_lnc_path_name3,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
SNV_PCG_FEAT3=read.table(file = snv_pcg_path_name3,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
					
CNV_LNC_FEAT3=read.table(file = cnv_lnc_path_name3,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
CNV_PCG_FEAT3=read.table(file = cnv_pcg_path_name3,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)

METHY_LNC_FEAT3=read.table(file = methy_lnc_path_name3,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
METHY_PCG_FEAT3=read.table(file = methy_pcg_path_name3,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)

TP_LNC_FEAT3=read.table(file = tp_lnc_path_name3,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
TP_PCG_FEAT3=read.table(file = tp_pcg_path_name3,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)


#Normalizing each column
for(i in 1:ncol(SNV_LNC_FEAT))
{
	if((max(SNV_LNC_FEAT[,i])-min(SNV_LNC_FEAT[,i]))>0)
	{
		SNV_LNC_FEAT[,i]=(SNV_LNC_FEAT[,i]-min(SNV_LNC_FEAT[,i]))/(max(SNV_LNC_FEAT[,i])-min(SNV_LNC_FEAT[,i]))
	}
	
}
for(i in 1:ncol(SNV_PCG_FEAT))
{
	if((max(SNV_PCG_FEAT[,i])-min(SNV_PCG_FEAT[,i]))>0)
	{
		SNV_PCG_FEAT[,i]=(SNV_PCG_FEAT[,i]-min(SNV_PCG_FEAT[,i]))/(max(SNV_PCG_FEAT[,i])-min(SNV_PCG_FEAT[,i]))
	}
}

for(i in 1:ncol(CNV_LNC_FEAT))
{
	if((max(CNV_LNC_FEAT[,i])-min(CNV_LNC_FEAT[,i]))>0)
	{
		CNV_LNC_FEAT[,i]=(CNV_LNC_FEAT[,i]-min(CNV_LNC_FEAT[,i]))/(max(CNV_LNC_FEAT[,i])-min(CNV_LNC_FEAT[,i]))
	}
}
for(i in 1:ncol(CNV_PCG_FEAT))
{
	if((max(CNV_PCG_FEAT[,i])-min(CNV_PCG_FEAT[,i]))>0)
	{
		CNV_PCG_FEAT[,i]=(CNV_PCG_FEAT[,i]-min(CNV_PCG_FEAT[,i]))/(max(CNV_PCG_FEAT[,i])-min(CNV_PCG_FEAT[,i]))
	}
}

for(i in 1:ncol(METHY_LNC_FEAT))
{
	if((max(METHY_LNC_FEAT[,i])-min(METHY_LNC_FEAT[,i]))>0)
	{
		METHY_LNC_FEAT[,i]=(METHY_LNC_FEAT[,i]-min(METHY_LNC_FEAT[,i]))/(max(METHY_LNC_FEAT[,i])-min(METHY_LNC_FEAT[,i]))
	}	
}
for(i in 1:ncol(METHY_PCG_FEAT))
{
	if((max(METHY_PCG_FEAT[,i])-min(METHY_PCG_FEAT[,i]))>0)
	{
		METHY_PCG_FEAT[,i]=(METHY_PCG_FEAT[,i]-min(METHY_PCG_FEAT[,i]))/(max(METHY_PCG_FEAT[,i])-min(METHY_PCG_FEAT[,i]))
	}
}

for(i in 1:ncol(TP_LNC_FEAT))
{
	if((max(TP_LNC_FEAT[,i])-min(TP_LNC_FEAT[,i])))
	{
		TP_LNC_FEAT[,i]=(TP_LNC_FEAT[,i]-min(TP_LNC_FEAT[,i]))/(max(TP_LNC_FEAT[,i])-min(TP_LNC_FEAT[,i]))
	}	
}
for(i in 1:ncol(TP_PCG_FEAT))
{
	if((max(TP_PCG_FEAT[,i])-min(TP_PCG_FEAT[,i])))
	{
		TP_PCG_FEAT[,i]=(TP_PCG_FEAT[,i]-min(TP_PCG_FEAT[,i]))/(max(TP_PCG_FEAT[,i])-min(TP_PCG_FEAT[,i]))
	}
}


for(i in 1:ncol(SNV_LNC_FEAT2))
{
	if((max(SNV_LNC_FEAT2[,i])-min(SNV_LNC_FEAT2[,i]))>0)
	{
		SNV_LNC_FEAT2[,i]=(SNV_LNC_FEAT2[,i]-min(SNV_LNC_FEAT2[,i]))/(max(SNV_LNC_FEAT2[,i])-min(SNV_LNC_FEAT2[,i]))
	}
	
}
for(i in 1:ncol(SNV_PCG_FEAT2))
{
	if((max(SNV_PCG_FEAT2[,i])-min(SNV_PCG_FEAT2[,i]))>0)
	{
		SNV_PCG_FEAT2[,i]=(SNV_PCG_FEAT2[,i]-min(SNV_PCG_FEAT2[,i]))/(max(SNV_PCG_FEAT2[,i])-min(SNV_PCG_FEAT2[,i]))
	}
}

for(i in 1:ncol(CNV_LNC_FEAT2))
{
	if((max(CNV_LNC_FEAT2[,i])-min(CNV_LNC_FEAT2[,i]))>0)
	{
		CNV_LNC_FEAT2[,i]=(CNV_LNC_FEAT2[,i]-min(CNV_LNC_FEAT2[,i]))/(max(CNV_LNC_FEAT2[,i])-min(CNV_LNC_FEAT2[,i]))
	}
}
for(i in 1:ncol(CNV_PCG_FEAT2))
{
	if((max(CNV_PCG_FEAT2[,i])-min(CNV_PCG_FEAT2[,i]))>0)
	{
		CNV_PCG_FEAT2[,i]=(CNV_PCG_FEAT2[,i]-min(CNV_PCG_FEAT2[,i]))/(max(CNV_PCG_FEAT2[,i])-min(CNV_PCG_FEAT2[,i]))
	}
}

for(i in 1:ncol(METHY_LNC_FEAT2))
{
	if((max(METHY_LNC_FEAT2[,i])-min(METHY_LNC_FEAT2[,i]))>0)
	{
		METHY_LNC_FEAT2[,i]=(METHY_LNC_FEAT2[,i]-min(METHY_LNC_FEAT2[,i]))/(max(METHY_LNC_FEAT2[,i])-min(METHY_LNC_FEAT2[,i]))
	}	
}
for(i in 1:ncol(METHY_PCG_FEAT2))
{
	if((max(METHY_PCG_FEAT2[,i])-min(METHY_PCG_FEAT2[,i]))>0)
	{
		METHY_PCG_FEAT2[,i]=(METHY_PCG_FEAT2[,i]-min(METHY_PCG_FEAT2[,i]))/(max(METHY_PCG_FEAT2[,i])-min(METHY_PCG_FEAT2[,i]))
	}
}

for(i in 1:ncol(TP_LNC_FEAT2))
{
	if((max(TP_LNC_FEAT2[,i])-min(TP_LNC_FEAT2[,i])))
	{
		TP_LNC_FEAT2[,i]=(TP_LNC_FEAT2[,i]-min(TP_LNC_FEAT2[,i]))/(max(TP_LNC_FEAT2[,i])-min(TP_LNC_FEAT2[,i]))
	}	
}
for(i in 1:ncol(TP_PCG_FEAT2))
{
	if((max(TP_PCG_FEAT2[,i])-min(TP_PCG_FEAT2[,i])))
	{
		TP_PCG_FEAT2[,i]=(TP_PCG_FEAT2[,i]-min(TP_PCG_FEAT2[,i]))/(max(TP_PCG_FEAT2[,i])-min(TP_PCG_FEAT2[,i]))
	}
}


for(i in 1:ncol(SNV_LNC_FEAT3))
{
	if((max(SNV_LNC_FEAT3[,i])-min(SNV_LNC_FEAT3[,i]))>0)
	{
		SNV_LNC_FEAT3[,i]=(SNV_LNC_FEAT3[,i]-min(SNV_LNC_FEAT3[,i]))/(max(SNV_LNC_FEAT3[,i])-min(SNV_LNC_FEAT3[,i]))
	}
	
}
for(i in 1:ncol(SNV_PCG_FEAT3))
{
	if((max(SNV_PCG_FEAT3[,i])-min(SNV_PCG_FEAT3[,i]))>0)
	{
		SNV_PCG_FEAT3[,i]=(SNV_PCG_FEAT3[,i]-min(SNV_PCG_FEAT3[,i]))/(max(SNV_PCG_FEAT3[,i])-min(SNV_PCG_FEAT3[,i]))
	}
}

for(i in 1:ncol(CNV_LNC_FEAT3))
{
	if((max(CNV_LNC_FEAT3[,i])-min(CNV_LNC_FEAT3[,i]))>0)
	{
		CNV_LNC_FEAT3[,i]=(CNV_LNC_FEAT3[,i]-min(CNV_LNC_FEAT3[,i]))/(max(CNV_LNC_FEAT3[,i])-min(CNV_LNC_FEAT3[,i]))
	}
}
for(i in 1:ncol(CNV_PCG_FEAT3))
{
	if((max(CNV_PCG_FEAT3[,i])-min(CNV_PCG_FEAT3[,i]))>0)
	{
		CNV_PCG_FEAT3[,i]=(CNV_PCG_FEAT3[,i]-min(CNV_PCG_FEAT3[,i]))/(max(CNV_PCG_FEAT3[,i])-min(CNV_PCG_FEAT3[,i]))
	}
}

for(i in 1:ncol(METHY_LNC_FEAT3))
{
	if((max(METHY_LNC_FEAT3[,i])-min(METHY_LNC_FEAT3[,i]))>0)
	{
		METHY_LNC_FEAT3[,i]=(METHY_LNC_FEAT3[,i]-min(METHY_LNC_FEAT3[,i]))/(max(METHY_LNC_FEAT3[,i])-min(METHY_LNC_FEAT3[,i]))
	}	
}
for(i in 1:ncol(METHY_PCG_FEAT3))
{
	if((max(METHY_PCG_FEAT3[,i])-min(METHY_PCG_FEAT3[,i]))>0)
	{
		METHY_PCG_FEAT3[,i]=(METHY_PCG_FEAT3[,i]-min(METHY_PCG_FEAT3[,i]))/(max(METHY_PCG_FEAT3[,i])-min(METHY_PCG_FEAT3[,i]))
	}
}

for(i in 1:ncol(TP_LNC_FEAT3))
{
	if((max(TP_LNC_FEAT3[,i])-min(TP_LNC_FEAT3[,i])))
	{
		TP_LNC_FEAT3[,i]=(TP_LNC_FEAT3[,i]-min(TP_LNC_FEAT3[,i]))/(max(TP_LNC_FEAT3[,i])-min(TP_LNC_FEAT3[,i]))
	}	
}
for(i in 1:ncol(TP_PCG_FEAT3))
{
	if((max(TP_PCG_FEAT3[,i])-min(TP_PCG_FEAT3[,i])))
	{
		TP_PCG_FEAT3[,i]=(TP_PCG_FEAT3[,i]-min(TP_PCG_FEAT3[,i]))/(max(TP_PCG_FEAT3[,i])-min(TP_PCG_FEAT3[,i]))
	}
}



LNC_FEAT=cbind(SNV_LNC_FEAT,CNV_LNC_FEAT)
LNC_FEAT=cbind(LNC_FEAT,METHY_LNC_FEAT)
LNC_FEAT=cbind(LNC_FEAT,TP_LNC_FEAT)

PCG_FEAT=cbind(SNV_PCG_FEAT,CNV_PCG_FEAT)
PCG_FEAT=cbind(PCG_FEAT,METHY_PCG_FEAT)
PCG_FEAT=cbind(PCG_FEAT,TP_PCG_FEAT)


LNC_FEAT2=cbind(SNV_LNC_FEAT2,CNV_LNC_FEAT2)
LNC_FEAT2=cbind(LNC_FEAT2,METHY_LNC_FEAT2)
LNC_FEAT2=cbind(LNC_FEAT2,TP_LNC_FEAT2)

PCG_FEAT2=cbind(SNV_PCG_FEAT2,CNV_PCG_FEAT2)
PCG_FEAT2=cbind(PCG_FEAT2,METHY_PCG_FEAT2)
PCG_FEAT2=cbind(PCG_FEAT2,TP_PCG_FEAT2)


LNC_FEAT3=cbind(SNV_LNC_FEAT3,CNV_LNC_FEAT3)
LNC_FEAT3=cbind(LNC_FEAT3,METHY_LNC_FEAT3)
LNC_FEAT3=cbind(LNC_FEAT3,TP_LNC_FEAT3)

PCG_FEAT3=cbind(SNV_PCG_FEAT3,CNV_PCG_FEAT3)
PCG_FEAT3=cbind(PCG_FEAT3,METHY_PCG_FEAT3)
PCG_FEAT3=cbind(PCG_FEAT3,TP_PCG_FEAT3)


write.table(LNC_FEAT, file ="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/New/lnc_feature.txt",sep="\t",row.names =TRUE, col.names =TRUE, quote =TRUE);
write.table(PCG_FEAT, file ="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/New/pcg_feature.txt",sep="\t",row.names =TRUE, col.names =TRUE, quote =TRUE);	

write.table(LNC_FEAT2, file ="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/New/lnc_feature2.txt",sep="\t",row.names =TRUE, col.names =TRUE, quote =TRUE);
write.table(PCG_FEAT2, file ="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/New/pcg_feature2.txt",sep="\t",row.names =TRUE, col.names =TRUE, quote =TRUE);	

write.table(LNC_FEAT3, file ="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/New/lnc_feature3.txt",sep="\t",row.names =TRUE, col.names =TRUE, quote =TRUE);
write.table(PCG_FEAT3, file ="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Multiomics/New/pcg_feature3.txt",sep="\t",row.names =TRUE, col.names =TRUE, quote =TRUE);	
