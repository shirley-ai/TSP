
function [node1,node2,node3,Improvement_in_Cost,Three_Opt_Type]= Three_Opt(TSP,Dis)

Improvement_in_Cost=inf;
TSP_Size=size(TSP,2);
%find best possible improvement

% calculate the improvements acheived by all combination of 3-opt and pick the best amongst them
              
for i=1:TSP_Size-2
    for j=i+1:TSP_Size-1 %穷尽所有两边组合
        %注意，虽然不用担心组成3角形，即可以重合一个点，但要避免两点都重合，否则TSP路线要出问题
        for k=1:TSP_Size-1%针对所有的第三条边
            if((k+1<=i)|| (j+1<=k))%这是为了防止重复计算，如果不加这一句，第二条边和第三条边的功能就会时常互换
                 DelCost=Dis(TSP(i),TSP(i+1))+Dis(TSP(j),TSP(j+1))+Dis(TSP(k),TSP(k+1));
                %先计算break edge的成本
                temp_Imp_in_Cost1 = Dis(TSP(i),TSP(k))+Dis(TSP(j+1), TSP(i+1))+Dis(TSP(j),TSP(k+1))-DelCost;
                temp_Imp_in_Cost2 = Dis(TSP(i),TSP(j+1))+Dis(TSP(k), TSP(i+1))+Dis(TSP(j), TSP(k+1))-DelCost;
                %然后计算两种连接的成本变化，注意这里不需要计算所有边长，只需要计算连接的3条边成本
                  if ((temp_Imp_in_Cost1 < temp_Imp_in_Cost2) && (temp_Imp_in_Cost1< Improvement_in_Cost))
                        
                      Improvement_in_Cost = temp_Imp_in_Cost1;
                      Three_Opt_Type=1;
                      node1=i; 
                      node2=j;
                      node3=k;
                  else if ((temp_Imp_in_Cost1 >= temp_Imp_in_Cost2) && (temp_Imp_in_Cost2 < Improvement_in_Cost))
                      Improvement_in_Cost = temp_Imp_in_Cost2;
                      Three_Opt_Type=2;
                      node1=i; 
                      node2=j;
                      node3=k;  
                      %选出最好的连接方式
                      end
                  end
            end
        end
    end
end
end