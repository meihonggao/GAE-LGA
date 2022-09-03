#!/usr/bin/perl -w
use strict;
use warnings;
###################################################################################################
#思路：	对TP数据进行处理，将其处理成表达矩阵
		#1.读入文件夹内的所有TP文件
		#2.将其整理成TP矩阵
		#3.读入gencode.txt文件
		#4.比较并输出lncRNA与pc的表达矩阵,需要将ENSG转换为gene symbol
###################################################################################################

my @cancer_names=(
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
);


my %lnc_hash;
my %pc_hash;
#读入genecode中的lncRNA.txt数据
my $lnc_file="/mnt/5468d/gaomeihong/LncRNA3/GENCODE/Decompression/lncRNA.txt";
open LNC, $lnc_file or die "Can not open $lnc_file\n";
while(<LNC>)
{
	chomp;
	my @temp=split /\t/, $_ ;
	#print "$temp[0]\t$temp[1]\n";
	$lnc_hash{$temp[0]}=$temp[1];
}
close(LNC);
#读入genecode中的pc.txt数据
my $pc_file="/mnt/5468d/gaomeihong/LncRNA3/GENCODE/Decompression/pc.txt";
open PC, $pc_file or die "Can not open $pc_file\n";
while(<PC>)
{
	chomp;
	my @temp=split /\t/, $_ ;
	#print "$temp[0]\t$temp[1]\n";
	$pc_hash{$temp[0]}=$temp[1];
}
close(PC);


#构建哈希，存储文件名到样本名的映射


for my $i (0 .. $#cancer_names)
#for my $i (0 .. 0)
{
	print "$cancer_names[$i]\n";
	my $DIR_PATH="./Raw/TCGA-".$cancer_names[$i];
	my @filelist;
	opendir DIR, ${DIR_PATH} or die "Can not open $DIR_PATH\n";
	@filelist = readdir DIR;
	closedir(DIR);
	my $file;
	my $count=0;
	my @tp;
	my @lnc;
	my @pcg;
	foreach $file (@filelist)
	{
		my $tmep_index=index($file,".FPKM.txt");
		if(index($file,".FPKM.txt")>0)
		{
			#print "$file\n";
			open TP, "$DIR_PATH/$file" or die "Can not open $file\n";
			my $idx=0;
			my $lnc_idx=0;
			my $pcg_idx=0;
			while(<TP>)
			{
				chomp;
				my @temp=split /\t/, $_ ;
				if($count==0)
				{
					$tp[$idx][0]=$temp[0];
					$tp[$idx][1]=$temp[1];
					if(exists($lnc_hash{$temp[0]}))
					{
						#$lnc[$lnc_idx][0]=$temp[0];
						$lnc[$lnc_idx][0]=$lnc_hash{$temp[0]};
						
						$lnc[$lnc_idx][1]=$temp[1];
						$lnc_idx=$lnc_idx+1;
					}
					if(exists($pc_hash{$temp[0]}))
					{
						#$pcg[$pcg_idx][0]=$temp[0];
						$pcg[$pcg_idx][0]=$pc_hash{$temp[0]};
						
						$pcg[$pcg_idx][1]=$temp[1];
						$pcg_idx=$pcg_idx+1;
					}
				}
				else
				{
					$tp[$idx][$count+1]=$temp[1];
					if(exists($lnc_hash{$temp[0]}))
					{
						$lnc[$lnc_idx][$count+1]=$temp[1];
						$lnc_idx=$lnc_idx+1;
					}
					if(exists($pc_hash{$temp[0]}))
					{
						$pcg[$pcg_idx][$count+1]=$temp[1];
						$pcg_idx=$pcg_idx+1;
					}
				}
				$idx=$idx+1;
			}
			close TP;
			$count=$count+1;
		}
	}
	
	print "$#tp\n";
	print "$#lnc\n";
	print "$#pcg\n";
	my $res_tp_name="./New/".$cancer_names[$i].".tp.txt";
	open RES_TP, ">$res_tp_name" or die "Can not open $res_tp_name\n";
	for my $j (0 .. $#tp)
	{
		for my $k (0 .. $#{$tp[$j]})
		{
			print RES_TP "$tp[$j][$k]\t";
		}
		print RES_TP "\n";
	}
	close(RES_TP);
	
	my $res_lnc_name="./New/".$cancer_names[$i].".lncRNA.txt";
	open RES_LNC, ">$res_lnc_name" or die "Can not open $res_lnc_name\n";
	for my $j (0 .. $#lnc)
	{
		for my $k (0 .. $#{$lnc[$j]})
		{
			print RES_LNC "$lnc[$j][$k]\t";
		}
		print RES_LNC "\n";
	}
	close(RES_LNC);
	
	my $res_pcg_name="./New/".$cancer_names[$i].".pcg.txt";
	open RES_PCG, ">$res_pcg_name" or die "Can not open $res_pcg_name\n";
	for my $j (0 .. $#pcg)
	{
		for my $k (0 .. $#{$pcg[$j]})
		{
			print RES_PCG "$pcg[$j][$k]\t";
		}
		print RES_PCG "\n";
	}
	close(RES_PCG);
}