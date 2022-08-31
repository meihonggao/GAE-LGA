###################################################################################################
#思路：	对LG矩阵进行筛选获得具有组学特征的LG矩阵
		#1.读入lnc-gene-net文件
		#2.读入lnc和pcg的name文件
		#3.根据name筛选获得具有组学特征的LG矩阵
		#4.输出具有组学特征的LG矩阵
###################################################################################################



lg_path_name="/mnt/5468d/gaomeihong/LncRNA3/GMA-LGI/Datasets/Dataset1/lnc_pcg_net.txt"
LG=read.table(file = lg_path_name,
					sep = "\t", header = TRUE, 
					row.names = 1, stringsAsFactors = FALSE)
					
lnc_path_name="/mnt/5468d/gaomeihong/LncRNA3/GMA-LGI/Datasets/Dataset1/lnc_name.txt"
lnc_names=rownames(read.table(file = lnc_path_name,
					sep = "\t", header = FALSE, 
					row.names = 1, stringsAsFactors = FALSE))
					
pcg_path_name="/mnt/5468d/gaomeihong/LncRNA3/GMA-LGI/Datasets/Dataset1/pcg_name.txt"
pcg_names=rownames(read.table(file = pcg_path_name,
					sep = "\t", header = FALSE, 
					row.names = 1, stringsAsFactors = FALSE))
					
LG2=LG[which(rownames(LG) %in% lnc_names),which(colnames(LG) %in% pcg_names)]
write.table(LG2, file ="lnc_pcg_net.csv",sep="\t",row.names =FALSE, col.names =FALSE, quote =TRUE);
