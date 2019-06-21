% TSB - nearest neighbour method
% solve TSB problem using Heuristics -- nearest neighbour method. 
% Shirley Chen, 30 Sept, 2018
%
% variable directory
% dis              distance matrix
% nb_nodes         total number of nodes
% p                nodes visited
% un_nodes         nodes unvisited
% nb_un_nodes      number of unvisited nodes
% total_distance   total distance travelled
% TSB              total route of TSB


    dis=[0 42 11 15 20 24 25;
        42 0 38 37 22 28 20;
        11 38 0 23 16 28 26;
        15 37 23 0 20 11 17;
        20 22 16 20 0 18 12;
        24 28 28 11 18 0 9; 
        25 20 27 17 12 9 0];
    
    %���ó�ʼֵ
    nb_nodes=7;
    nb_un_nodes=nb_nodes;
    p=[];
    un_nodes=1:nb_nodes;
    total_distance=0;
    
    %���õ�һ����
    p=3;
    un_nodes(un_nodes==3)=[];%�Ƴ�3
    nb_un_nodes=nb_un_nodes-1;
    
    %��whileѭ���ҵ����С���һ������
    while (nb_un_nodes~=0)
        [m,j]=min(dis(p(end),un_nodes));
        p=[p,un_nodes(j)];
        un_nodes(j)=[];
        total_distance=total_distance+m;
        nb_un_nodes=nb_un_nodes-1;
    end
    
    %���Ϸ��ص�һ���·�ߣ�closed TSB��
    TSB=[p,p(1)]
    total_distance=total_distance+dis(p(end),p(1))
    
    
    
    
    
   
   