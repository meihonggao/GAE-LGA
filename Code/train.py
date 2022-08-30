import torch
import numpy as np
from model import *
from utils import *
from sklearn.metrics import precision_recall_curve,roc_curve, accuracy_score,f1_score,auc
import torch.nn.functional as F

def train(model, model2, dataset, args):
    print("Training......")
    optimizer = torch.optim.Adam(model.parameters(), lr=args.learn_ratio)
    train_data = dict()
    train_data['x_data_matrix'],train_data['x_edge_index']=\
        torch.cat((dataset['ll_f']['data_matrix'],dataset['ll_m']['data_matrix']),1), dataset['ll_f_train']['edge_index']
    train_data['y_data_matrix'],train_data['y_edge_index'] =\
        torch.cat((dataset['gg_f']['data_matrix'],dataset['gg_m']['data_matrix']),1), dataset['gg_f_train']['edge_index']
    total_auc=[]
    total_aupr=[]
    model.train() 
    y_true=dataset['lg']['data_matrix'].view(1,-1).numpy().flatten().tolist()#args.epoch
    for epoch in range(0, args.epoch):
        model.zero_grad()
        embedding_x,embedding_y = model(train_data)
        score=model2.forward(embedding_x,embedding_y)
        loss = torch.nn.MSELoss(reduction='mean')
        ground_data=dataset['lg']['data_matrix']
        loss = loss(score, ground_data)
        loss.backward()
        optimizer.step()
        print(loss.item())
        y_score=score.view(1,-1).detach().numpy().flatten().tolist()
        fpr, tpr, thresholds = roc_curve(y_true, y_score)
        precision, recall, _ = precision_recall_curve(y_true, y_score)
        total_auc.append(auc(fpr, tpr))
        total_aupr.append(auc(recall, precision)) 
    score = score.detach().cpu().numpy()
    if(args.train_type==1):
        if(args.gcn_layers==2):
            np.savetxt('../Results/total_auc_layers2.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_layers2.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.gcn_layers==3):
            np.savetxt('../Results/total_auc_layers3.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_layers3.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.gcn_layers==4):
            np.savetxt('../Results/total_auc_layers4.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_layers4.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.gcn_layers==5):
            np.savetxt('../Results/total_auc_layers5.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_layers5.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
    if(args.train_type==2):
        if(args.out_features==10):
            np.savetxt('../Results/total_auc_emb10.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_emb10.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.out_features==50):
            np.savetxt('../Results/total_auc_emb50.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_emb50.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.out_features==100):
            np.savetxt('../Results/total_auc_emb100.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_emb100.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.out_features==200):
            np.savetxt('../Results/total_auc_emb200.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_emb200.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
    if(args.train_type==3):
        if(args.hidden_features==10):
            np.savetxt('../Results/total_auc_hid10.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_hid10.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.hidden_features==50):
            np.savetxt('../Results/total_auc_hid50.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_hid50.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.hidden_features==100):
            np.savetxt('../Results/total_auc_hid100.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_hid100.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.hidden_features==200):
            np.savetxt('../Results/total_auc_hid200.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_layers5.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
    if(args.train_type==4):
        if(args.learn_ratio==0.1):
            np.savetxt('../Results/total_auc_lr01.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_lr01.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.learn_ratio==0.01):
            np.savetxt('../Results/total_auc_lr001.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_lr001.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.learn_ratio==0.001):
            np.savetxt('../Results/total_auc_lr0001.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_lr0001.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
        if(args.learn_ratio==0.0001):
            np.savetxt('../Results/total_auc_lr00001.out', total_auc,delimiter='\t')   #x,y,z相同大小的一维数组
            np.savetxt('../Results/total_aupr_lr00001.out', total_aupr,delimiter='\t')   #x,y,z相同大小的一维数组
    #print('AUC',auc(fpr, tpr))
    #print('PR_AUC',auc(recall, precision))
    #print('ACC',acc)
    #print('F1-score',F1)
    #return auc(fpr, tpr),auc(recall, precision)
    
def test(model,model2,dataset):
    test_data = dict()
    test_data['x_data_matrix'],test_data['x_edge_index']=\
        torch.cat((dataset['ll_f']['data_matrix'],dataset['ll_m']['data_matrix']),1), dataset['ll_f_test']['edge_index']
    test_data['y_data_matrix'],test_data['y_edge_index'] =\
        torch.cat((dataset['gg_f']['data_matrix'],dataset['gg_m']['data_matrix']),1), dataset['gg_f_test']['edge_index']
    model.eval()
    embedding_x,embedding_y = model(test_data)
    score=model2.forward(embedding_x,embedding_y)
    ground_data=dataset['lg']['data_matrix']
    #loss_test = F.nll_loss(score, ground_data)
    #acc_test = accuracy(score, ground_data)
    loss = torch.nn.MSELoss(reduction='mean')   
    loss = loss(score, ground_data)
    loss.backward()
    print(loss.item())
    y_true=dataset['lg']['data_matrix'].view(1,-1).numpy().flatten().tolist()  
    y_score=score.view(1,-1).detach().numpy().flatten().tolist()
    fpr, tpr, thresholds = roc_curve(y_true, y_score)
    precision, recall, _ = precision_recall_curve(y_true, y_score)
    print('AUC',auc(fpr, tpr))
    print('PR_AUC',auc(recall, precision))
    #print("Test set results:",
    #      "loss= {:.4f}".format(loss_test.item()),
    #      "accuracy= {:.4f}".format(acc_test.item()))

def main():
    args = parameter_parser()
    torch.manual_seed(args.seed)
    dataset = data_pro(args)
    
    "Training GCN layers..."
    print('Training GCN layers...')
    args.train_type=1
    args.out_features=200
    args.hidden_features=50
    args.learn_ratio=0.001   
    args.gcn_layers=2
    en_model_layer1 = EncoderGCN2(args)
    de_model_layer1 = DecoderGCN()
    train(en_model_layer1, de_model_layer1, dataset, args)
    args.gcn_layers=3
    en_model_layer2 = EncoderGCN3(args)
    de_model_layer2 = DecoderGCN()
    train(en_model_layer2, de_model_layer2, dataset, args)
    args.gcn_layers=4
    en_model_layer3 = EncoderGCN4(args)
    de_model_layer3 = DecoderGCN()
    train(en_model_layer3, de_model_layer3, dataset, args)
    args.gcn_layers=5
    en_model_layer4 = EncoderGCN5(args)
    de_model_layer4 = DecoderGCN()
    train(en_model_layer4, de_model_layer4, dataset, args)
    
    
    "Training embeding size..."
    print('Training embeding size...')
    args.train_type=2
    args.gcn_layers=2
    args.hidden_features=50
    args.learn_ratio=0.001
    args.out_features=10
    en_model_emb1 = EncoderGCN2(args)
    de_model_emb1 = DecoderGCN()
    train(en_model_emb1, de_model_emb1, dataset, args)
    args.out_features=50
    en_model_emb2 = EncoderGCN2(args)
    de_model_emb2 = DecoderGCN()
    train(en_model_emb2, de_model_emb2, dataset, args)
    args.out_features=100
    en_model_emb3 = EncoderGCN2(args)
    de_model_emb3 = DecoderGCN()
    train(en_model_emb3, de_model_emb3, dataset, args)
    args.out_features=200
    en_model_emb4 = EncoderGCN2(args)
    de_model_emb4 = DecoderGCN()
    train(en_model_emb4, de_model_emb4, dataset, args)
    
    
    "Training hidder size..."
    print('Training hidder size...')
    args.train_type=3
    args.gcn_layers=2
    args.out_features=200
    args.learn_ratio=0.001
    args.hidden_features=10
    en_model_hid1 = EncoderGCN2(args)
    de_model_hid1 = DecoderGCN()
    train(en_model_hid1, de_model_hid1, dataset, args)
    args.hidden_features=50
    en_model_hid2 = EncoderGCN2(args)
    de_model_hid2 = DecoderGCN()
    train(en_model_hid2, de_model_hid2, dataset, args)
    args.hidden_features=100
    en_model_hid3 = EncoderGCN2(args)
    de_model_hid3 = DecoderGCN()
    train(en_model_hid3, de_model_hid3, dataset, args)
    args.hidden_features=200
    en_model_hid4 = EncoderGCN2(args)
    de_model_hid4 = DecoderGCN()
    train(en_model_hid4, de_model_hid4, dataset, args)
    
    
    "Training learning rate..."
    print('Training learning rate...')
    args.train_type=4
    args.gcn_layers=2
    args.out_features=200
    args.hidden_features=50
    args.learn_ratio=0.1
    en_model_lr1= EncoderGCN2(args)
    de_model_lr1 = DecoderGCN()
    train(en_model_lr1, de_model_lr1, dataset, args)
    args.learn_ratio=0.01
    en_model_lr2= EncoderGCN2(args)
    de_model_lr2 = DecoderGCN()
    train(en_model_lr2, de_model_lr2, dataset, args)
    args.learn_ratio=0.001
    en_model_lr3= EncoderGCN2(args)
    de_model_lr3 = DecoderGCN()
    train(en_model_lr3, de_model_lr3, dataset, args)
    args.learn_ratio=0.0001
    en_model_lr4= EncoderGCN2(args)
    de_model_lr4 = DecoderGCN()
    train(en_model_lr4, de_model_lr4, dataset, args)
    
           
if __name__ == "__main__":
    main()
    