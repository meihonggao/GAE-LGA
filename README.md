# GAE-LGA: Integration of multi-omics data with graph autoencoder to identify lncRNA-PCG associations

## Requirements
Before using the GAE-LGA model, users first need to install the following environment on the computer：
  * Python 3.6.2
  * PyTrorch 1.9.1
  * NumPy 1.19.2
  * scikit-learn 0.24.1

## Code
  * main_cpu_1.py: is used to calculate the running results of the model on the LncRNA2Target dataset (CPU environment)
  * main_gpu_1.py: is used to calculate the running results of the model on the LncRNA2Target dataset (GPU environment)
  * main_cpu_2.py: is used to calculate the running results of the model on the LncTarD dataset (CPU environment)
  * main_gpu_2.py: is used to calculate the running results of the model on the LncTarD dataset (GPU environment)
  * main_cpu_3.py: is used to calculate the running results of the model on the NPInter dataset (CPU environment)
  * main_gpu_3.py: is used to calculate the running results of the model on the NPInter dataset (GPU environment)
  * model.py: is used to define the encoder and decoder of the model.
  * train.py: is used to train the parameters of the model.
  * utils.py: is used to define the function functions that need to be used in the model.

## Usage
Here, we provide procedures for running the GAE-LGA model on three datasets
### Run on Dataset1
If you are using CPU environment, please run the following python command：```python main_cpu_1.py```
If you are using GPU environment, please run the following python command：```python main_gpu_1.py```
### Run on Dataset1
If you are using CPU environment, please run the following python command：```python main_cpu_2.py```
If you are using GPU environment, please run the following python command：```python main_gpu_2.py```
### Run on Dataset1
If you are using CPU environment, please run the following python command：```python main_cpu_3.py```
If you are using GPU environment, please run the following python command：```python main_gpu_3.py```

## Datasets
  * Dataset1   #LncRAN-PCG associations from the LncRNA2Target dataset
  * Dataset2   #LncRAN-PCG associations from the LncTarD dataset
  * Dataset3   #LncRAN-PCG associations from the NPInter dataset

## Results
 * 1    #Experimental results of Dataset1
 * 2    #Experimental results of Dataset2
 * 3    #Experimental results of Dataset3



