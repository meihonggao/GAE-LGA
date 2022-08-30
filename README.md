# GAE-LGA: Integration of multi-omics data with graph autoencoder to identify lncRNA-PCG associations

## Requirements
Before using GAE-LGA, users first need to install the following environments on their computers：
  * Python 3.6.2
  * PyTrorch 1.9.1
  * NumPy 1.19.2
  * scikit-learn 0.24.1

## Code
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
  * If you are using GPU environment, please run the following python command：```python main_gpu_1.py```
### Usage on LncTarD dataset
  * If you are using CPU environment, please run the following python command：```python main_cpu_2.py```
  * If you are using GPU environment, please run the following python command：```python main_gpu_2.py```
### Usage on NPInter dataset
  * If you are using CPU environment, please run the following python command：```python main_cpu_3.py```
  * If you are using GPU environment, please run the following python command：```python main_gpu_3.py```

## Datasets
### Dataset1---LncRNA2Target dataset
  * feat_name.txt   
  >Attribute names for multi-omics features, consisting of attributes from single nucleotide variants, copy number variants, gene expression data, and DNA methylation data.
  * lnc_feat.csv
  >Multi-omics features of lncRNAs
  * lnc_name.txt
  >Names of lncRNAs in lnc_feat.csv
  * lnc_pcg_net.txt
  >LncRNA-PCG associations from the LncRNA2Target dataset
  * lnc_pcg_net.csv
  >LncRNA-PCG associations in which lncRNAs and PCGs have multi-omics features
  * pcg_feat.csv
  >Multi-omics features of  protein-coding genes
  * pcg_name.txt
  >Names of protein-coding genes in pcg_feat.csv
  * process.R
  >Process lnc_pcg_net.txt to lnc_pcg_net.csv
### Dataset2---LncTarD dataset
  * feat_name.txt   
  >Attribute names for multi-omics features, consisting of attributes from single nucleotide variants, copy number variants, gene expression data, and DNA methylation data.
  * lnc_feat.csv
  >Multi-omics features of lncRNAs
  * lnc_name.txt
  >Names of lncRNAs in lnc_feat.csv
  * lnc_pcg_net.txt
  >LncRNA-PCG associations from the LncTarD dataset
  * lnc_pcg_net.csv
  >LncRNA-PCG associations in which lncRNAs and PCGs have multi-omics features
  * pcg_feat.csv
  >Multi-omics features of  protein-coding genes
  * pcg_name.txt
  >Names of protein-coding genes in pcg_feat.csv
  * process.R
  >Process lnc_pcg_net.txt to lnc_pcg_net.csv
### Dataset3---NPInter dataset
  * feat_name.txt   
  >Attribute names for multi-omics features, consisting of attributes from single nucleotide variants, copy number variants, gene expression data, and DNA methylation data.
  * lnc_feat.csv
  >Multi-omics features of lncRNAs
  * lnc_name.txt
  >Names of lncRNAs in lnc_feat.csv
  * lnc_pcg_net.txt
  >LncRNA-PCG associations from the NPInter dataset
  * lnc_pcg_net.csv
  >LncRNA-PCG associations in which lncRNAs and PCGs have multi-omics features
  * pcg_feat.csv
  >Multi-omics features of  protein-coding genes
  * pcg_name.txt
  >Names of protein-coding genes in pcg_feat.csv
  * process.R
  >Process lnc_pcg_net.txt to lnc_pcg_net.csv

## Results
 * 1    This directory is used to store the experimental results of the LncRNA2Target dataset.
 * 2    This directory is used to store the experimental results of the LncTarD dataset
 * 3    This directory is used to store the experimental results of the NPInter dataset



