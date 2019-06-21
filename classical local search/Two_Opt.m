%find best possible improvement
%这个函数用于寻找当前路径中进行一次变动可以产生的最大提高，确定用于交换路径的那两个点
%有了这个函数，就可以在循环中反复使用
function [node1,node2,BestImp]= Two_Opt(TSP,Dis)

%. Dis[i,j]+Dis[i+1, j+1]-Dis[i,i+1]-Dis[j,j+1];

BestImp=inf;
TSP_Size=size(TSP,2);
% calculate the improvements acheived by all combination of 2-opt and pick the best amongst them
for i=1:TSP_Size-3
    for j=i+2:TSP_Size-1 %两个循环穷尽所有两边组合
        %这里需要注意的就是边的开头和结尾，在纸上画一下就知道了
        %不用太担心4个点形成3角形，因为3角形的话是没有成本变化的，所以不会update solution
         imp=Dis(TSP(i),TSP(j))+Dis(TSP(i+1), TSP(j+1))-Dis(TSP(i),TSP(i+1))-Dis(TSP(j),TSP(j+1));
         %用新的路径成本减掉旧的路径成本，值越小（负数）提高越大
        if(imp<BestImp)
            BestImp=imp;
            node1=i;
            node2=j;
      
        end
    end
end

end