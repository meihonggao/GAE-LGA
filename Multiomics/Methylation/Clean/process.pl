#!/usr/bin/perl -w
use strict;
use warnings;
###################################################################################################
#思路：	对DNA Methy数据进行处理
		#1.对甲基化矩阵进行出处理，提取有用信息
		#2.将33种癌症的甲基化表达数据进行整理，获得33个表达矩阵
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
my $cancer_name;
foreach $cancer_name (@cancer_names)
{
	my $new_path="./New/TCGA-".$cancer_name;
	my $cmd = "if [ ! -d $new_path ]; then mkdir $new_path; fi";
	#print "$cmd\n";
	system($cmd);
}

my $DIR_PATH="/mnt/5468d/gaomeihong/LncRNA3/TCGA/Methylation/Clean/Raw";
my $file;
my $count=0;
opendir DIR, ${DIR_PATH} or die "Can not open $DIR_PATH\n";
my@filelist = readdir DIR;

foreach $file (@filelist)
{
	#print "$count\n";
	
	my$index = index ($file, '.gdc_hg38.txt'); 
	if($index>0)
	{
		print "$index\t$file\n";
		my @cnv;
		open CNV, "./Raw/".$file or die "Can not open $file\n";
		$count=0;
		while(<CNV>)
		{
			my @temp=split /\t/, $_ ;
			$cnv[$count][0]=$temp[1];
			$cnv[$count][1]=$temp[2];
			$cnv[$count][2]=$temp[3];
			$cnv[$count][3]=$temp[4];
			
			my @temp2=split /;/, $temp[5] ;
			$cnv[$count][4]=$temp2[0];
			$count=$count+1;
		}
		close(CNV);
		
		my @temp2=split /jhu-usc.edu_/, $file;
		my @temp3=split /\./, $temp2[1];
		my $new_path2="./New/TCGA-".$temp3[0]."/";
		my $res_file=$new_path2.$file.".core.txt";
		open RESULT,">$res_file" or die "Can't open $res_file";	
		
		for my $i (0 .. $#cnv)
		{
			
			for my $j (0 .. $#{$cnv[$i]})
			{
					print RESULT "$cnv[$i][$j]\t";
			}
			print RESULT "\n";
		}
		close(RESULT);;	
	}
}

closedir(DIR);

