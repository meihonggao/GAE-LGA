#!/usr/bin/perl -w
use strict;
use warnings;
###################################################################################################
#思路：	对SNV数据进行处理，将33个文件分别读入，并进行计算
		#1.读入33个文件，将其可用信息筛选出来
		#2.将33个文件进行整合
###################################################################################################

#所有的癌症名
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



my $DIR_PATH="/mnt/5468d/gaomeihong/LncRNA3/TCGA/SNV/Clean/somaticsniper/Raw";
my @filelist;
my $file;

my $count=0;
opendir DIR, ${DIR_PATH} or die "Can not open $DIR_PATH\n";
@filelist = readdir DIR;

foreach $file (@filelist)
{
	my$index = index ($file, '.somatic.maf'); 
	if($index>0)
	{
		print "$index\n";
		my $snv_path_name="./somaticsniper/Raw/$file";
		#print "$snv_path_name\n";
		
		open SNV, $snv_path_name or die "Can't open SNV";
		my $count=0;
		my @snv;
		while(<SNV>)
		{
			if($count==5)
			{
				$snv[$count-5][0]="Hugo_Symbol";
				$snv[$count-5][1]="Chromosome";
				$snv[$count-5][2]="Chr_Position";
			}
			if($count>5)
			{
				my @temp=split /\s+/, $_ ;
				$snv[$count-5][0]=$temp[0];
				
				my @temp2=split /chr/, $temp[4];
				#print "$temp2[1]\n";
				$snv[$count-5][1]=$temp2[1];
				$snv[$count-5][2]=($temp[5]+$temp[6])/2;
			}	
			$count=$count+1;
		}
		close(SNV);
		#print "count : $count\n";

		my @temp3=split /\./, $file;
		print "$temp3[0]\t$temp3[1]\t$temp3[2]\n";
		my $snv_res_name=$temp3[1];
		open RESULT,">./somaticsniper/New/TCGA.$snv_res_name.somaticsniper.somatic.maf.txt" or die "Can't open RESULT";	

		$count=0;
		#计算overlap
		for my $i (0 .. $#snv)
		{
			
			for my $j (0 .. $#{$snv[$i]})
			{
					print RESULT "$snv[$i][$j]\t";
			}
			print RESULT "\n";
		}
	}
	

}























=cut

