import torch
import time
import numpy as np
from pandas import DataFrame 
from model import *
from utils import *
from sklearn.metrics import precision_recall_curve,roc_curve, accuracy_score,f1_score,auc,precision_score,recall_score
import torch.nn.functional as F
import os 


def train(model, model2, dataset, args):
    print("Training......")
    optimizer = torch.optim.Adam(model.parameters(), lr=args.learn_ratio)
    train_data = dict()
    train_data['x_data_matrix'],train_data['x_edge_index']=\
        torch.cat((dataset['ll_f']['data_matrix'],dataset['ll_m']['data_matrix']),1), dataset['ll_f_train']['edge_index']
    train_data['y_data_matrix'],train_data['y_edge_index'] =\
        torch.cat((dataset['gg_f']['data_matrix'],dataset['gg_m']['data_matrix']),1), dataset['gg_f_train']['edge_index']
    #np.savetxt(args.result-path+'/lncRNA.feature.txt', train_data['x_data_matrix'], delimiter=' ')
    #np.savetxt(args.result-path+'/gene.feature.txt', train_data['y_data_matrix'], delimiter=' ')
    #np.savetxt(args.result-path+'/gene-net1.txt', dataset['gg_f']['data_matrix'], delimiter=' ')
    total_auc=[]
    total_aupr=[]
    model.train()
    y_true=dataset['lg']['data_matrix'].view(1,-1).numpy().flatten().tolist()   
    for epoch in range(0, args.epoch):
        model.zero_grad()
        embedding_x,embedding_y = model(train_data)
        score=model2.forward(embedding_x,embedding_y)
        loss = torch.nn.MSELoss(reduction='mean')
        ground_data=dataset['lg']['data_matrix']
        ground_data=ground_data
        loss = loss(score, ground_data)
        loss.backward()
        optimizer.step()
        print('Loss for epoch '+str(epoch)+":",loss.item())        
        y_score=score.view(1,-1).detach().cpu().numpy().flatten().tolist()
        fpr, tpr, thresholds = roc_curve(y_true, y_score)
        precision, recall, _ = precision_recall_curve(y_true, y_score)
        total_auc.append(auc(fpr, tpr))
        total_aupr.append(auc(recall, precision))   
    score = score.detach().cpu() 
    y_score=score.view(1,-1).detach().numpy().flatten().tolist()
    fpr, tpr, thresholds = roc_curve(y_true, y_score)
    precision, recall, _ = precision_recall_curve(y_true, y_score)
    auroc=auc(fpr, tpr)
    aupr=auc(recall, precision)
    acc=accuracy_score(y_true, np.rint(y_score))
    F1=f1_score(y_true, np.rint(y_score), average='macro')
    Pre=precision_score(y_true, np.rint(y_score), average='macro')
    Rec=recall_score(y_true, np.rint(y_score), average='macro')
    print('AUC',auroc)
    print('AUPR',aupr)
    print('ACC',acc)
    print('F1-score',F1)
    print('Precision',Pre)
    print('Recall',Rec)
    df=DataFrame([auroc,aupr,acc,F1,Pre,Rec],index=['AUC','AUPR','ACC','F1-score','Precision','Recall'],columns=['peformance']) 
    df.to_csv(args.result_path+'/train_perform.txt',sep=':',header=0)    
    #np.savetxt(args.result_path+'/train_auc.txt', total_auc,delimiter='\t')
    #np.savetxt(args.result_path+'/train_aupr.txt', total_aupr,delimiter='\t')
    fpr_tpr=np.vstack((fpr,tpr))
    rec_pre=np.vstack((recall,precision))
    np.savetxt(args.result_path+'/train_fpr_tpr.txt', fpr_tpr,delimiter=',')
    np.savetxt(args.result_path+'/train_rec_pre.txt', rec_pre,delimiter=',')

    
def test(model,model2,dataset,args):
    print('Testing......')
    test_data = dict()
    test_data['x_data_matrix'],test_data['x_edge_index']=\
        torch.cat((dataset['ll_f']['data_matrix'],dataset['ll_m']['data_matrix']),1), dataset['ll_f_test']['edge_index']
    test_data['y_data_matrix'],test_data['y_edge_index'] =\
        torch.cat((dataset['gg_f']['data_matrix'],dataset['gg_m']['data_matrix']),1), dataset['gg_f_test']['edge_index']
    model.eval() 
    embedding_x,embedding_y = model(test_data)
    score=model2.forward(embedding_x,embedding_y)  
    ground_data=dataset['lg']['data_matrix']
    ground_data=ground_data
    #loss_test = F.nll_loss(score, ground_data)
    #acc_test = accuracy(score, ground_data)
    loss = torch.nn.MSELoss(reduction='mean')   
    loss = loss(score, ground_data)
    loss.backward()
    print('Loss:',loss.item())
    y_true=dataset['lg']['data_matrix'].view(1,-1).numpy().flatten().tolist()  
    y_score=score.view(1,-1).detach().cpu().numpy().flatten().tolist()
    idx1=np.where(np.array(np.rint(y_score)) == 1)[0]
    idx2=np.where(np.array(y_true) == 0)[0]
    inter_idx = list(set(idx1) & set(idx2))
    lnc_idx = [inter_idx[i]//args.fg for i in range(len(inter_idx))]
    pcg_idx = [inter_idx[i]%args.fg for i in range(len(inter_idx))]
    new_score = np.array(y_score)[inter_idx].tolist()
    new_assoc=np.vstack((lnc_idx,pcg_idx,new_score))
    np.savetxt(args.result_path+'/test_new_assoc.txt', new_assoc, delimiter=',',fmt='%1.2f')
    fpr, tpr, thresholds = roc_curve(y_true, y_score)
    precision, recall, _ = precision_recall_curve(y_true, y_score)
    auroc=auc(fpr, tpr)
    aupr=auc(recall, precision)
    acc=accuracy_score(y_true, np.rint(y_score))
    F1=f1_score(y_true, np.rint(y_score), average='macro')
    Pre=precision_score(y_true, np.rint(y_score), average='macro')
    Rec=recall_score(y_true, np.rint(y_score), average='macro')
    print('AUC',auroc)
    print('AUPR',aupr)
    print('ACC',acc)
    print('F1-score',F1)
    print('Precision',Pre)
    print('Recall',Rec)
    df=DataFrame([auroc,aupr,acc,F1,Pre,Rec],index=['AUC','AUPR','ACC','F1-score','Precision','Recall'],columns=['peformance']) 
    df.to_csv(args.result_path+'/test_perform.txt',sep=':',header=0)    
    fpr_tpr=np.vstack((fpr,tpr))    
    rec_pre=np.vstack((recall,precision))
    np.savetxt(args.result_path+'/test_fpr_tpr.txt', fpr_tpr,delimiter=',')
    np.savetxt(args.result_path+'/test_rec_pre.txt', rec_pre,delimiter=',')

def main():
    start = time.time()
    
    os.environ["CUDA_VISIBLE_DEVICES"] = '0,1'
    args = parameter_parser()
    args.dataset_path='../Datasets/Dataset3'    #Dataset1,Dataset2,Dataset3
    args.result_path='../Results/3'    #1,2,3
    args.fl=308 #263,238,308
    args.fg=256 #498,716,256
    args.epoch=273  #1290
    torch.manual_seed(args.seed)
    dataset = data_pro(args)
    
    "Training..."
    args.train_type=2
    args.gcn_layers=2
    args.hidden_features=50
    args.learn_ratio=0.001
    args.out_features=10
    en_model = EncoderGCN2(args)
    de_model = DecoderGCN()
    en_model
    de_model
    train(en_model, de_model, dataset, args)
    
    "Testing..."
    test(en_model, de_model, dataset, args)
    end = time.time()
    print('*****************************************')
    print('Runtime = '+str(end-start)+'s')
           
if __name__ == "__main__":
    main()
    