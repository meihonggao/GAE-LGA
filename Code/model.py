import torch
from torch import nn
from torch_geometric.nn import HeteroConv, GCNConv, SAGEConv, GATConv, Linear
from torch_geometric.utils import train_test_split_edges

class EncoderGCN2(nn.Module):
    def __init__(self, args):
        super(EncoderGCN2, self).__init__()
        self.args = args
        self.conv1_lnc_f = GCNConv(args.fl+args.fl, args.hidden_features)
        self.act1_lnc_f=nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv2_lnc_f = GCNConv(args.hidden_features, args.out_features)
        
        self.conv1_pcg_f = GCNConv(args.fg+args.fg, args.hidden_features)
        self.act1_pcg_f=nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv2_pcg_f = GCNConv(args.hidden_features, args.out_features)

    def forward(self, data):
        #x, x_edge_index = torch.cat((data['ll_f']['data_matrix'],data['ll_m']['data_matrix']),1), data['ll_f']['edge_index']
        #x, x_edge_index = data['ll_m'], data['ll_m_edges']
        x, x_edge_index = data['x_data_matrix'], data['x_edge_index']
        x = self.act1_lnc_f(self.conv1_lnc_f(x, x_edge_index))
        x = self.conv2_lnc_f(x, x_edge_index)
        
        #y, y_edge_index = torch.cat((data['gg_f']['data_matrix'],data['gg_m']['data_matrix']),1), data['gg_f']['edge_index']
        #y, y_edge_index = data['gg_m'], data['gg_m_edges']
        y, y_edge_index = data['y_data_matrix'], data['y_edge_index']
        y = self.act1_pcg_f(self.conv1_pcg_f(y, y_edge_index))
        y = self.conv2_pcg_f(y, y_edge_index)
        
        return x,y

class EncoderGCN3(nn.Module):
    def __init__(self, args):
        super(EncoderGCN3, self).__init__()
        self.args = args
        self.conv1_lnc_f = GCNConv(args.fl+args.fl, args.hidden_features)
        self.act1_lnc_f=nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv2_lnc_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act2_lnc_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv3_lnc_f = GCNConv(args.hidden_features, args.out_features)
        
        self.conv1_pcg_f = GCNConv(args.fg+args.fg, args.hidden_features)
        self.act1_pcg_f=nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv2_pcg_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act2_pcg_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv3_pcg_f = GCNConv(args.hidden_features, args.out_features)

    def forward(self, data):
        #x, x_edge_index = torch.cat((data['ll_f']['data_matrix'],data['ll_m']['data_matrix']),1), data['ll_f']['edge_index']
        #x, x_edge_index = data['ll_m'], data['ll_m_edges']
        x, x_edge_index = data['x_data_matrix'], data['x_edge_index']
        x = self.act1_lnc_f(self.conv1_lnc_f(x, x_edge_index))
        x = self.act2_lnc_f(self.conv2_lnc_f(x, x_edge_index))
        x = self.conv3_lnc_f(x, x_edge_index)
        
        #y, y_edge_index = torch.cat((data['gg_f']['data_matrix'],data['gg_m']['data_matrix']),1), data['gg_f']['edge_index']
        #y, y_edge_index = data['gg_m'], data['gg_m_edges']
        y, y_edge_index = data['y_data_matrix'], data['y_edge_index']
        y = self.act1_pcg_f(self.conv1_pcg_f(y, y_edge_index))
        y = self.act2_pcg_f(self.conv2_pcg_f(y, y_edge_index))
        y = self.conv3_pcg_f(y, y_edge_index)
        
        return x,y

class EncoderGCN4(nn.Module):
    def __init__(self, args):
        super(EncoderGCN4, self).__init__()
        self.args = args
        self.conv1_lnc_f = GCNConv(args.fl+args.fl, args.hidden_features)
        self.act1_lnc_f=nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv2_lnc_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act2_lnc_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv3_lnc_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act3_lnc_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))                   
        self.conv4_lnc_f = GCNConv(args.hidden_features, args.out_features)
        
        self.conv1_pcg_f = GCNConv(args.fg+args.fg, args.hidden_features)
        self.act1_pcg_f=nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv2_pcg_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act2_pcg_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv3_pcg_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act3_pcg_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))                      
        self.conv4_pcg_f = GCNConv(args.hidden_features, args.out_features)

    def forward(self, data):
        #x, x_edge_index = torch.cat((data['ll_f']['data_matrix'],data['ll_m']['data_matrix']),1), data['ll_f']['edge_index']
        #x, x_edge_index = data['ll_m'], data['ll_m_edges']
        x, x_edge_index = data['x_data_matrix'], data['x_edge_index']
        x = self.act1_lnc_f(self.conv1_lnc_f(x, x_edge_index))
        x = self.act2_lnc_f(self.conv2_lnc_f(x, x_edge_index))
        x = self.act3_lnc_f(self.conv3_lnc_f(x, x_edge_index))
        x = self.conv4_lnc_f(x, x_edge_index)
        
        #y, y_edge_index = torch.cat((data['gg_f']['data_matrix'],data['gg_m']['data_matrix']),1), data['gg_f']['edge_index']
        #y, y_edge_index = data['gg_m'], data['gg_m_edges']
        y, y_edge_index = data['y_data_matrix'], data['y_edge_index']
        y = self.act1_pcg_f(self.conv1_pcg_f(y, y_edge_index))
        y = self.act2_pcg_f(self.conv2_pcg_f(y, y_edge_index))
        y = self.act3_pcg_f(self.conv3_pcg_f(y, y_edge_index))
        y = self.conv4_pcg_f(y, y_edge_index)
        
        return x,y
        
class EncoderGCN5(nn.Module):
    def __init__(self, args):
        super(EncoderGCN5, self).__init__()
        self.args = args
        self.conv1_lnc_f = GCNConv(args.fl+args.fl, args.hidden_features)
        self.act1_lnc_f=nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv2_lnc_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act2_lnc_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv3_lnc_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act3_lnc_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))                      
        self.conv4_lnc_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act4_lnc_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))                      
        self.conv5_lnc_f = GCNConv(args.hidden_features, args.out_features)
        
        self.conv1_pcg_f = GCNConv(args.fg+args.fg, args.hidden_features)
        self.act1_pcg_f=nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv2_pcg_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act2_pcg_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))
        self.conv3_pcg_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act3_pcg_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))                      
        self.conv4_pcg_f = GCNConv(args.hidden_features, args.hidden_features)
        self.act4_pcg_f = nn.Sequential(nn.ReLU(),
                              nn.Dropout(args.p_drop))                      
        self.conv5_pcg_f = GCNConv(args.hidden_features, args.out_features)

    def forward(self, data):
        #x, x_edge_index = torch.cat((data['ll_f']['data_matrix'],data['ll_m']['data_matrix']),1), data['ll_f']['edge_index']
        #x, x_edge_index = data['ll_m'], data['ll_m_edges']
        x, x_edge_index = data['x_data_matrix'], data['x_edge_index']
        x = self.act1_lnc_f(self.conv1_lnc_f(x, x_edge_index))
        x = self.act2_lnc_f(self.conv2_lnc_f(x, x_edge_index))
        x = self.act3_lnc_f(self.conv3_lnc_f(x, x_edge_index))
        x = self.act4_lnc_f(self.conv4_lnc_f(x, x_edge_index))
        x = self.conv5_lnc_f(x, x_edge_index)
        
        #y, y_edge_index = torch.cat((data['gg_f']['data_matrix'],data['gg_m']['data_matrix']),1), data['gg_f']['edge_index']
        #y, y_edge_index = data['gg_m'], data['gg_m_edges']
        y, y_edge_index = data['y_data_matrix'], data['y_edge_index']
        y = self.act1_pcg_f(self.conv1_pcg_f(y, y_edge_index))
        y = self.act2_pcg_f(self.conv2_pcg_f(y, y_edge_index))
        y = self.act3_pcg_f(self.conv3_pcg_f(y, y_edge_index))
        y = self.act4_pcg_f(self.conv4_pcg_f(y, y_edge_index))
        y = self.conv5_pcg_f(y, y_edge_index)
        
        return x,y
    
class DecoderGCN(nn.Module):
    def __init__(self):
        super(DecoderGCN, self).__init__()
        
    def forward(self, z1,z2):
        A = torch.mm(z1, torch.t(z2))
        A = torch.sigmoid(A)
        return A
        