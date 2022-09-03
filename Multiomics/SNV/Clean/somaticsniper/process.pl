#!/usr/bin/perl -w
use strict;
use warnings;
###################################################################################################
#思路：	对SNV数据进行处理，将33个文件分别读入，并进行计算
		#1.读入33个文件，将其可用信息筛选出来
		#2.将33个文件进行整合，
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


for my $k (0 .. 32)
{
	my $snv_path_name="TCGA.".$cancer_names[$k].".somaticsniper.somatic.maf";
	print "$snv_path_name\n";
	
	open SNV, $snv_path_name or die "Can't open SNV";
	my $count=0;
	my @snv;
	while(<SNV>)
	{
		if($count>=5)
		{
			my @temp=split /\s+/, $_ ;
			$snv[$count-5][0]=$temp[0];
			$snv[$count-5][1]=$temp[1];
			$snv[$count-5][2]=$temp[4];
			$snv[$count-5][3]=$temp[5];
			$snv[$count-5][4]=$temp[6];
		}	
		$count=$count+1;
	}
	close(SNV);
	print "count : $count\n";

	my $snv_res_name=">TCGA.".$cancer_names[$k].".somaticsniper.somatic.maf.txt";
	open RESULT,$snv_res_name or die "Can't open RESULT";	
	#print RESULT "ID\tname\n";
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























=cut

