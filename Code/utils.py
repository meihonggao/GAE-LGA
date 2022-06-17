from sklearn.metrics import roc_curve, auc
import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt
import math
import numpy as np
import torch
import random
import csv
import argparse

def parameter_parser():
    parser = argparse.ArgumentParser(description="Run GAE-LGI.")
    parser.add_argument("--dataset_path",
                        nargs="?",
                        default="../Datasets/Dataset2",#Dataset1,Dataset2,Dataset3
                        help="Training datasets.")
    parser.add_argument("--result_path",
                        nargs="?",
                        default="../Results/2",#1,2,3
                        help="Results path.")
    parser.add_argument("--fl",
                        type=int,
                        default=238,#263,238,308
                        help="LncRNA feature dimensions. Default is 263.")
    parser.add_argument("--fg",
                        type=int,
                        default=716,#498,716,256
                        help="Pcg feature dimensions. Default is 498.")
    parser.add_argument("--fm",
                        type=int,
                        default=312,
                        help="Multiomics feature dimensions. Default is 312.")                         
    parser.add_argument("--p_drop",
                        type=float,
                        default=0.,
                        help="Training datasets.")
    parser.add_argument("--out_features",
                        type=int,
                        default=200,
                        help="Out features of GCN. Default is 200.")
    parser.add_argument("--hidden_features",
                        type=int,
                        default=50,
                        help="Hidden features of GCN. Default is 50.")
    parser.add_argument("--epoch",
                        type=int,
                        default=10000,
                        help="Number of training epochs. Default is 500.")
    parser.add_argument("--val_ratio",
                        type=float,
                        default=0.05,
                        help="The ratio of positive validation edges. Default is 0.05.")
    parser.add_argument("--test_ratio",
                        type=float,
                        default=0.1,
                        help="The ratio of positive test edges. Default is 0.1.")
    parser.add_argument("--gcn_layers",
                        type=int,
                        default=3,
                        help="Gcn layers. Default is 3.")
    parser.add_argument("--seed",
                        type=int,
                        default=1,
                        help="The seed for generating random numbers. Default is 1.")
    parser.add_argument("--learn_ratio",
                        type=float,
                        default=0.001,
                        help="The learning rate. Default is 0.001.")
    parser.add_argument("--train_type",
                        type=int,
                        default=1,
                        help="The training type. Default is 1.")
    parser.add_argument("--cross_val",
                        type=int,
                        default=10,
                        help="The training type. Default is 1.")                                         
    return parser.parse_args() 

def AU_ROC(y_true,y_score):
    #fpr, tpr, thersholds = roc_curve(y_label, y_pre, pos_label=2)
    fpr, tpr, thresholds = roc_curve(y_true, y_score)
    #acc=accuracy_score(y_true, y_score)
    #F1=f1_score(y_true, y_score, average='macro')
    #precision, recall, _ = precision_recall_curve(y_true, y_score)
    roc_auc = auc(fpr, tpr)
    plt.plot(fpr, tpr, 'k--', label='ROC (AUC = {0:.2f})'.format(roc_auc), lw=2)

    plt.xlim([-0.05, 1.05])  # 设置x、y轴的上下限，以免和边缘重合，更好的观察图像的整体
    plt.ylim([-0.05, 1.05])
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')  # 可以使用中文，但需要导入一些库即字体
    #plt.title('ROC Curve')
    plt.legend(loc="lower right")
    plt.show()
    plt.savefig("../Results/test.jpg") 
    
def train_test_split_edges(data_matrix,edge_index,args):
    data=dict()
    data['train'] = dict()
    data['test'] = dict()
    data['val'] = dict()
    num_lnc,num_pcg=data_matrix.size()
    row, col = edge_index
    n_v = int(math.floor(args.val_ratio * row.size(0)))
    n_t = int(math.floor(args.test_ratio * row.size(0)))
    # Positive edges.
    perm = torch.randperm(row.size(0))
    row, col = row[perm], col[perm]
    r, c = row[:n_v], col[:n_v]
    tr=list(set(range(num_lnc)).difference(set(r.numpy())))
    data['val']['data_matrix'] = data_matrix[torch.unique(r)]
    data['val']['edge_index'] = torch.stack([r, c], dim=0)
    r, c = row[n_v:n_v + n_t], col[n_v:n_v + n_t]
    tr2=list(set(tr).difference(set(r.numpy())))
    data['test']['data_matrix'] = data_matrix[torch.unique(r)]
    data['test']['edge_index'] = torch.stack([r, c], dim=0)
    r, c = row[n_v + n_t:], col[n_v + n_t:]
    data['train']['data_matrix'] = data_matrix[np.unique(tr2)]
    tr=list(set(range(num_lnc)).difference(set(r)))
    data['train']['edge_index'] = torch.stack([r, c], dim=0)
    #data.train_pos_edge_index = to_undirected(data.train_pos_edge_index) 
    return data['train'],data['test'],data['val']

def train_test_cross_val(data_matrix,edge_index,args):
    data=dict()
    num_lnc,num_pcg=data_matrix.size()
    row, col = edge_index
    # Positive edges.
    perm = torch.randperm(row.size(0))
    perm_cross = []
    cross_idx=math.ceil(len(perm)/args.cross_val)
    for i in range(0, len(perm), cross_idx):
        temp = perm[i:i + cross_idx]
        perm_cross.append(temp)
    for i in range(0, args.cross_val):
        r, c = row[perm_cross[i]], col[perm_cross[i]]
        test_name='test'+str(i)
        data[test_name]=dict()
        data[test_name]['data_matrix'] = data_matrix[torch.unique(r)]
        data[test_name]['edge_index'] = torch.stack([r, c], dim=0)
        train_idx=list(set(perm.numpy()).difference(set(perm_cross[i].numpy())))
        r, c=row[train_idx], col[train_idx]
        train_name='train'+str(i)
        data[train_name]=dict()
        data[train_name]['data_matrix'] = data_matrix[list(set(r))]
        data[train_name]['edge_index'] = torch.tensor(np.vstack((r,c)))
    return data

def new_lnc(data_list,sim):  #
    """
    This function is used to complete association information for a new lncRNA according to the mean of neighbor nodes 
    :param data_list: lncRNA-PCG association
    :param sim: Simlarities between lncRNAs
    data_list=LG
    sim=dataset['ll_m']['data_matrix']
    """
    
    nl=data_list.shape[0]
    ng=data_list.shape[1]
    
    rate=data_list.sum()/(nl*ng)
    rate=round(rate.item()*ng)
    
    sim=sim.float()
    for i in range(nl):
        if(torch.sum(data_list[i])==0):
            print(i)
            row=sim[i]
            N_index=[]
            for x in range(nl):
                if((row[x]>=torch.mean(sim))and(x!=i)):
                    N_index.append(x)  
            if (len(N_index)>0):
                new_row=torch.tensor([1 for y in range(ng)])
                for l in range(len(N_index)):
                   new_row=new_row+data_list[N_index[l],]       
                new_row=new_row/len(N_index)
                for y in range(ng):
                    if (new_row[y]>=torch.mean(sim)):
                        new_row[y]=1
                    else:
                        new_row[y]=0
                data_list[i]=new_row  
            else:
                new_row=torch.tensor([0 for y in range(ng)])
                z_index=random.sample(range(ng), rate)
                for z in z_index:
                    new_row[z]=1
                data_list[i] = new_row
    return data_list

def gaussian_sim(data_list):  ##calculate the gaussian similarity
    print("Similarity calculation!")
    nl=data_list.shape[0]
    ng=data_list.shape[1]
    sl=[0]*nl
    sd=[0]*ng
    pkl=np.zeros((nl, nl))
    pkg=np.zeros((ng, ng))
    for i in range(nl):
        sl[i]=pow(np.linalg.norm(data_list[i,:]),2)
    gamal=sum(sl)/nl
    for i in range(nl):
        for j in range(nl):
            pkl[i,j]=math.exp(-gamal*pow(np.linalg.norm(data_list[i,:]-data_list[j,:]),2))      
    for i in range(ng):
        sd[i]=pow(np.linalg.norm(data_list[:,i]),2)
    gamag=sum(sd)/ng 
    for i in range(ng):
        for j in range(ng):
            pkg[i,j]=math.exp(-gamag*pow(np.linalg.norm(data_list[:,i]-data_list[:,j]),2))
    pkl=torch.tensor(pkl)
    pkg=torch.tensor(pkg)
    pkl = pkl.to(torch.float32)
    pkg = pkg.to(torch.float32)
    return pkl, pkg

def read_csv(path):
    with open(path, 'r', newline='') as csv_file:
        reader = csv.reader(csv_file)
        lg_data = []
        lg_data += [[float(i) for i in row] for row in reader]
        return torch.Tensor(lg_data)


def get_edge_index(matrix):
    edge_index = [[], []]
    for i in range(matrix.size(0)):
        for j in range(matrix.size(1)):
            if matrix[i][j] >= 0.3:
                edge_index[0].append(i)
                edge_index[1].append(j)
    return torch.LongTensor(edge_index)
    
def get_one_zero_index(matrix):
    zero_index = []
    one_index = []
    for i in range(matrix.size(0)):
        for j in range(matrix.size(1)):
            if matrix[i][j] < 1:
                zero_index.append([i, j])
            if matrix[i][j] >= 1:
                one_index.append([i, j])
    random.shuffle(one_index)
    random.shuffle(zero_index)
    zero_tensor = torch.LongTensor(zero_index)
    one_tensor = torch.LongTensor(one_index)
    return zero_tensor,one_tensor


def data_pro(args):
    "LncRNA and PCG association"
    dataset = dict()
    LG=read_csv(args.dataset_path + '/lnc_pcg_net.csv')
    l_m_matrix=read_csv(args.dataset_path + '/lnc_feat.csv')
    g_m_matrix=read_csv(args.dataset_path + '/pcg_feat.csv')
    ll_m_matrix,oo_m_matrix=gaussian_sim(l_m_matrix)
    gg_m_matrix,oo_m2_matrix=gaussian_sim(g_m_matrix)
    
    dataset['lg'] = dict()
    #dataset['lg']['data_matrix']=new_lnc(LG,ll_m_matrix)
    dataset['lg']['data_matrix']=LG
    dataset['lg']['edge_index']= get_edge_index(ll_m_matrix) 
    
    dataset['lg_train'],dataset['lg_test'],dataset['lg_val']=\
        train_test_split_edges(dataset['lg']['data_matrix'],dataset['lg']['edge_index'],args)
        
    dataset['lg_cross_val']=train_test_cross_val(dataset['lg']['data_matrix'],dataset['lg']['edge_index'],args)
     
    "LncRNA and PCG functional sim"
    ll_f_matrix,gg_f_matrix=gaussian_sim(dataset['lg']['data_matrix'])
    
    dataset['ll_f'] = dict()
    dataset['ll_f']['data_matrix'] = ll_f_matrix
    dataset['ll_f']['edge_index'] = get_edge_index(ll_f_matrix)
    
    dataset['ll_f_train'],dataset['ll_f_test'],dataset['ll_f_val']=\
        train_test_split_edges(dataset['ll_f']['data_matrix'],dataset['ll_f']['edge_index'],args)
        
    dataset['ll_f_cross_val']=train_test_cross_val(dataset['ll_f']['data_matrix'],dataset['ll_f']['edge_index'],args)
        
    dataset['gg_f'] = dict()
    dataset['gg_f']['data_matrix'] = gg_f_matrix
    dataset['gg_f']['edge_index'] = get_edge_index(gg_f_matrix)
    
    dataset['gg_f_train'],dataset['gg_f_test'],dataset['gg_f_val']=\
        train_test_split_edges(dataset['gg_f']['data_matrix'],dataset['gg_f']['edge_index'],args)
        
    dataset['gg_f_cross_val']=train_test_cross_val(dataset['gg_f']['data_matrix'],dataset['gg_f']['edge_index'],args)

    "LncRNA and PCG multi-omics features"
    
      
    dataset['ll_m'] = dict()
    dataset['ll_m']['data_matrix']=ll_m_matrix
    dataset['ll_m']['edge_index'] = get_edge_index(ll_m_matrix)
    
    dataset['ll_m_train'],dataset['ll_m_test'],dataset['ll_m_val']=\
        train_test_split_edges(dataset['ll_m']['data_matrix'],dataset['ll_m']['edge_index'],args)
        
    dataset['ll_m_cross_val']=train_test_cross_val(dataset['ll_m']['data_matrix'],dataset['ll_m']['edge_index'],args)
 
    dataset['gg_m'] = dict()
    dataset['gg_m']['data_matrix'] = gg_m_matrix
    dataset['gg_m']['edge_index'] = get_edge_index(gg_m_matrix)
    
    dataset['gg_m_train'],dataset['gg_m_test'],dataset['gg_m_val']=\
        train_test_split_edges(dataset['gg_m']['data_matrix'],dataset['gg_m']['edge_index'],args)

    dataset['gg_m_cross_val']=train_test_cross_val(dataset['gg_m']['data_matrix'],dataset['gg_m']['edge_index'],args)

    dataset['l_m'] = dict()
    dataset['l_m']['data_matrix']=l_m_matrix
    dataset['l_m']['edge_index'] = get_edge_index(l_m_matrix)

    dataset['l_m_train'],dataset['l_m_test'],dataset['l_m_val']=\
        train_test_split_edges(dataset['l_m']['data_matrix'],dataset['l_m']['edge_index'],args)
        
    dataset['l_m_cross_val']=train_test_cross_val(dataset['l_m']['data_matrix'],dataset['l_m']['edge_index'],args)
        
    dataset['g_m'] = dict()
    dataset['g_m']['data_matrix']=l_m_matrix
    dataset['g_m']['edge_index'] = get_edge_index(l_m_matrix)

    dataset['g_m_train'],dataset['g_m_test'],dataset['g_m_val']=\
        train_test_split_edges(dataset['g_m']['data_matrix'],dataset['g_m']['edge_index'],args)
        
    dataset['g_m_cross_val']=train_test_cross_val(dataset['g_m']['data_matrix'],dataset['g_m']['edge_index'],args)

    return dataset    

def del_tensor_0_cloumn(Cs):
    idx = torch.all(Cs[..., :] == 0, axis=1)
    index=[]
    for i in range(idx.shape[0]):
        if not idx[i].item():
            index.append(i)
    index=torch.tensor(index)
    Cs = torch.index_select(Cs, 0, index)
    return Cs