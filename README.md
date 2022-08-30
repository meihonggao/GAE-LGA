# GAE-LGA: Integration of multi-omics data with graph autoencoders to identify lncRNA-PCG associations
> If you have any questions in using the program, please feel free to contact us by email: meihonggao@mail.nwpu.edu.cn.

## Requirements
GAE-LGA is tested in the conda environment. It is also recommended that you use this method to test the program. Of course, you can also execute the program using your own familiar environment. Before using GAE-LGA, users first need to install the following environments on their computers：
  * Python 3.6.2
  * PyTrorch 1.9.1
  * NumPy 1.19.2
  * scikit-learn 0.24.1

## Code
This directory stores the python code of the model
  * main_cpu_1.py
  >It is used to compute the performance of the model for lncRNA-PCG association prediction on the LncRNA2Target dataset (CPU environment)
  * main_gpu_1.py
  >It is used to compute the performance of the model for lncRNA-PCG association prediction on the LncRNA2Target dataset (GPU environment)
  * main_cpu_2.py
  >It is used to compute the performance of the model for lncRNA-PCG association prediction on the LncTarD dataset (CPU environment)
  * main_gpu_2.py
  >It is used to compute the performance of the model for lncRNA-PCG association prediction on the LncTarD dataset (GPU environment)
  * main_cpu_3.py
  >It is used to compute the performance of the model for lncRNA-PCG association prediction on the NPInter dataset (CPU environment)
  * main_gpu_3.py
  >It is used to compute the performance of the model for lncRNA-PCG association prediction on the NPInter dataset (GPU environment)
  * model.py
  >It is used to define the encoder and decoder of the model.
  * train.py
  >It is used to train the parameters of the model.
  * utils.py
  >It is used to define the functions that need to be used in the model.

## Usage
Here, we provide the usage of GAE-LGA on three datasets. Note: Go to the /GAE-LGA/Code/ directory before using this model.
### Usage on LncRNA2Target dataset
  * If you are using CPU environment, please run the following python command：```python main_cpu_1.py```
  > Note: The input data includes lnc_feat.csv, pcg_feat.csv, and lncRNA_pcg_net.csv in the GAE/LGA/Datasets/Dataset1 directory, and users can replace them with their own data.
  * If you are using GPU environment, please run the following python command：```python main_gpu_1.py```
  > Note: The input data includes lnc_feat.csv, pcg_feat.csv, and lncRNA_pcg_net.csv in the GAE/LGA/Datasets/Dataset1 directory, and users can replace them with their own data.
### Usage on LncTarD dataset
  * If you are using CPU environment, please run the following python command：```python main_cpu_2.py```
  > Note: The input data includes lnc_feat.csv, pcg_feat.csv, and lncRNA_pcg_net.csv in the GAE/LGA/Datasets/Dataset2 directory, and users can replace them with their own data.
  * If you are using GPU environment, please run the following python command：```python main_gpu_2.py```
  > Note: The input data includes lnc_feat.csv, pcg_feat.csv, and lncRNA_pcg_net.csv in the GAE/LGA/Datasets/Dataset2 directory, and users can replace them with their own data.
### Usage on NPInter dataset
  * If you are using CPU environment, please run the following python command：```python main_cpu_3.py```
  > Note: The input data includes lnc_feat.csv, pcg_feat.csv, and lncRNA_pcg_net.csv in the GAE/LGA/Datasets/Dataset3 directory, and users can replace them with their own data.
  * If you are using GPU environment, please run the following python command：```python main_gpu_3.py```
  > Note: The input data includes lnc_feat.csv, pcg_feat.csv, and lncRNA_pcg_net.csv in the GAE/LGA/Datasets/Dataset3 directory, and users can replace them with their own data.

## Datasets
This directory stores the datasets used by the model
### Dataset1: LncRNA2Target dataset
  * feat_name.txt   
  >Attribute names for multi-omics features, consisting of attributes from single nucleotide variants, copy number variants, gene expression data, and DNA methylation data.
  * lnc_feat.csv
  > Multi-omics features of lncRNAs
  * lnc_name.txt
  > Names of lncRNAs in lnc_feat.csv
  * lnc_pcg_net.txt
  > LncRNA-PCG associations from the LncRNA2Target dataset
  * lnc_pcg_net.csv
  > LncRNA-PCG associations in which lncRNAs and PCGs have multi-omics features
  * pcg_feat.csv
  > Multi-omics features of  protein-coding genes
  * pcg_name.txt
  > Names of protein-coding genes in pcg_feat.csv
  * process.R
  > Process lnc_pcg_net.txt to lnc_pcg_net.csv
### Dataset2: LncTarD dataset
  * feat_name.txt   
  > Attribute names for multi-omics features, consisting of attributes from single nucleotide variants, copy number variants, gene expression data, and DNA methylation data.
  * lnc_feat.csv
  > Multi-omics features of lncRNAs
  * lnc_name.txt
  > Names of lncRNAs in lnc_feat.csv
  * lnc_pcg_net.txt
  > LncRNA-PCG associations from the LncTarD dataset
  * lnc_pcg_net.csv
  > LncRNA-PCG associations in which lncRNAs and PCGs have multi-omics features
  * pcg_feat.csv
  > Multi-omics features of  protein-coding genes
  * pcg_name.txt
  > Names of protein-coding genes in pcg_feat.csv
  * process.R
  > Process lnc_pcg_net.txt to lnc_pcg_net.csv
### Dataset3: NPInter dataset
  * feat_name.txt   
  >Attribute names for multi-omics features, consisting of attributes from single nucleotide variants, copy number variants, gene expression data, and DNA methylation data.
  * lnc_feat.csv
  > Multi-omics features of lncRNAs
  * lnc_name.txt
  > Names of lncRNAs in lnc_feat.csv
  * lnc_pcg_net.txt
  > LncRNA-PCG associations from the NPInter dataset
  * lnc_pcg_net.csv
  > LncRNA-PCG associations in which lncRNAs and PCGs have multi-omics features
  * pcg_feat.csv
  > Multi-omics features of  protein-coding genes
  * pcg_name.txt
  > Names of protein-coding genes in pcg_feat.csv
  * process.R
  > Process lnc_pcg_net.txt to lnc_pcg_net.csv

## Results
This directory shows the output of the model
### 1: This directory is used to store the experimental results of the LncRNA2Target dataset.
  * train_rec_pre.txt 
  > Changes in recall and precision on the training set.
  * train_perform.txt 
  > Model performance on the training set
  * train_fpr_tpr.txt
  > Changes in true positive rate and false positive rates on the training set.
  * test_rec_pre.txt
  > Changes in recall and precision on the test set.
  * test_perform.txt
  > Model performance on the test set
  * test_fpr_tpr.txt
  > Changes in true positive and false positive rates on the test set.
  * test_new_assoc.txt
  > New lncRNA-PCG associations identified on the test set.
### 2: This directory is used to store the experimental results of the LncTarD dataset
  * train_rec_pre.txt 
  > Changes in recall and precision on the training set.
  * train_perform.txt 
  > Model performance on the training set
  * train_fpr_tpr.txt
  > Changes in true positive rate and false positive rates on the training set.
  * test_rec_pre.txt
  > Changes in recall and precision on the test set.
  * test_perform.txt
  > Model performance on the test set
  * test_fpr_tpr.txt
  > Changes in true positive and false positive rates on the test set.
  * test_new_assoc.txt
  > New lncRNA-PCG associations identified on the test set.
### 3: This directory is used to store the experimental results of the NPInter dataset
  * train_rec_pre.txt 
  > Changes in recall and precision on the training set.
  * train_perform.txt 
  > Model performance on the training set
  * train_fpr_tpr.txt
  > Changes in true positive rate and false positive rates on the training set.
  * test_rec_pre.txt
  > Changes in recall and precision on the test set.
  * test_perform.txt
  > Model performance on the test set
  * test_fpr_tpr.txt
  > Changes in true positive and false positive rates on the test set.
  * test_new_assoc.txt
  > New lncRNA-PCG associations identified on the test set.
