function [BestCost, TSP ] = Two_opt_LS(Location,Nb_Nodes,TSP,TSPCost,Dis,PlotTour,TSPType)
%这个算法结构非常简单，步骤如下：
%1）设置初始值
     % 改良值  -1 （随便一个负数都可以，用于循环条件）
     % 循环计数器 1
     % 两个node -1,-1
     % 最低成本 初始值为原路径的值
%2）写循环
     % 循环条件     改良值为负（由于2-opt函数是用新路成本减旧路成本）
     % 运行2-opt函数   得到改良值以及两个点的位置
     % 如果改良值为负，更新最低成本和路径
     

%Note that the initial feasible solution is TSP and the corresponding objective function 
% value is TSPCost

% the neighborhood structure to use is
% whole neighborhood of TSP, for its best neighbor using Two_Opt move

if (PlotTour==1)
    I1=  figure (2) ;
    set(I1,'Name',[TSPType '- 2 opt LS' ])
end

BestImp=-1;
Improvement_in_Cost=Inf;
%Initialize iteration counter iter
iter=1;
%Initialize  node1 & node2 to -1
node1=-1;
node2=-1;
node3=-1;
%Initialize BestCost to TSPCost
BestCost=TSPCost;
VNS=[1,2];
method=1;
nb_no_imp=0;

%REPEAT until stopping condition = true // e.g., (TSP is a local optimum [BestImp<0] )

while(BestImp<0)
    switch VNS(method)
        case 1
            [node1,node2,Improvement_in_Cost]=Two_Opt(TSP,Dis);
        case 2
            [node1,node2,node3,Improvement_in_Cost,Three_Opt_Type]= Three_Opt(TSP,Dis);
    end
    BestImp=round(Improvement_in_Cost,3);
     
    if(BestImp<0)
        
        Cost=BestCost+Improvement_in_Cost;
        
        BestCost=Cost; 
    if (method==1)
        NewTSP=[TSP(1:node1) fliplr(TSP(node1+1:node2)) TSP(node2+1:end) ];
    else
        if (Three_Opt_Type == 1)
                    %        reverse
                    if (node3 >= node2 + 1)
                        %         if (k >= j + 1)
                        NewTSP=[TSP(1:node1) fliplr(TSP(node2+1:node3)) TSP(node1+1:node2) TSP(node3+1:end) ];
                        
                    else if (node3 + 1 <= node1)
                            
                            NewTSP=[ fliplr(TSP(node2+1:end)) TSP(node1+1:node2) TSP(node3+1:node1) fliplr(TSP(1:node3))];
                            
                        end
                    end
                    %
                else if (Three_Opt_Type == 2)
                        if (node3 >= node2 + 1)
                            %         if (k >= j + 1)
                            NewTSP=[TSP(1:node1) TSP(node2+1:node3) TSP(node1+1:node2) TSP(node3+1:end) ];
                        else if (node3 + 1 <= node1)
                                NewTSP=[TSP(1:node3) TSP(node1+1:node2) TSP(node3+1:node1) TSP(node2+1:end) ];
                            end
                            
                        end
                    end
                end
                
    end
    else
        nb_no_imp=nb_no_imp+1;
        if (nb_no_imp>10)
            BestImp=0;
        else 
            method=2;
    end
    

  
        
    
        
        
            
         
            
       
        
        TSP=NewTSP;
        NewTSP=[];
    else
        
        BestImp=0;
    end
    
    
    
end

% end

