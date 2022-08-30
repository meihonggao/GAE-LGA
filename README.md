# GAE-LGA: Integration of multi-omics data with graph autoencoder to identify lncRNA-PCG associations

## Requirements
Before using the GAE-LGA model, users first need to install the following environment on the computer：
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
### Dataset1 LncRAN-PCG associations f the LncRNA2Target dataset
  * feat_name.txt   
  * lnc_feat.csv
  * lnc_feat.txt
  * lnc_name.txt
  * lnc_pcg_net.csv
  * lnc_pcg_net.txt
  * lnc_ss_sim.csv
  * pcg_feat.csv
  * pcg_feat.txt
  * pcg_name.txt
  * process.R
### Dataset2 LncRAN-PCG associations from the LncTarD dataset
### Dataset3 LncRAN-PCG associations from the NPInter dataset
  * Dataset1   #LncRAN-PCG associations from the LncRNA2Target dataset
  * Dataset2   #LncRAN-PCG associations from the LncTarD dataset
  * Dataset3   #LncRAN-PCG associations from the NPInter dataset

## Results
 * 1    #Experimental results of Dataset1
 * 2    #Experimental results of Dataset2
 * 3    #Experimental results of Dataset3



