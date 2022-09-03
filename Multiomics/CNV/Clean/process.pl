#!/usr/bin/perl -w
use strict;
use warnings;
###################################################################################################
#思路：	对CNV数据进行处理，将所有文件读入，修改其名字，并输出到每种癌症对应的单独的文件夹中
		#1.读入文件夹内的所有cnv文件
		#2.读入sanple sheet文件
		#3.比较获得癌症类型,修改文件名并输出到对应癌症的文件夹内
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


#CHEEP_p_TCGA_b120_121_SNP_N_GenomeWideSNP_6_B08_777630.nocnv_grch38.seg.v2.txt
my $DIR_PATH="/mnt/5468d/gaomeihong/LncRNA3/TCGA/CNV/Clean/Raw";
my @filelist;
my $file;
my $count=0;
opendir DIR, ${DIR_PATH} or die "Can not open $DIR_PATH\n";
@filelist = readdir DIR;

foreach $file (@filelist) {
	$count=$count+1;
	print "$count\n";
	my$index = index ($file, '.nocnv_grch38.seg.v2.txt'); 
	if($index>10)
	{
		my $sample_sheet_file="../Clinical/gdc_sample_sheet.TCGA.2022-01-15.tsv";
		my @SS;
		
		open SS, $sample_sheet_file or die "Can not open $sample_sheet_file\n";
		while(<SS>)
		{
			my @temp=split /\t/, $_ ;
			if($file eq $temp[1])
			{
				#print "$file****\n";
				my $new_file=$temp[4]."_".$file;
				#print "$new_file\n";
				
				my $new_path="./New/".$temp[4];
				my $cmd = "if [ ! -d $new_path ]; then mkdir $new_path; fi; cp ./Raw/$file ./New/$temp[4]/$new_file";
				##";
				#print "$cmd\n";
				system($cmd);
				last;
			}
		}
		close(SS);
	}
}

closedir(DIR);




=cut

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

