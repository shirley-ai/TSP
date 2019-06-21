% find a random better neighbor in 3-opt
function [node1,node2,node3,Improvement_in_Cost,Three_Opt_Type]= Three_Opt_random(TSP,Dis)

Improvement_in_Cost=inf;
TSP_Size=size(TSP,2);

while (Improvement_in_Cost>=0)
    p=randperm(TSP_Size-1,3);
    i=p(1);
    j=p(2);
    k=p(3);
    %calculate the cost reduction of breaking 3 edges
    DelCost=Dis(TSP(i),TSP(i+1))+Dis(TSP(j),TSP(j+1))+Dis(TSP(k),TSP(k+1));
    %caculate the cost change of adding new edges
    temp_Imp_in_Cost1 = Dis(TSP(i),TSP(k))+Dis(TSP(j+1), TSP(i+1))+Dis(TSP(j),TSP(k+1))-DelCost;
    temp_Imp_in_Cost2 = Dis(TSP(i),TSP(j+1))+Dis(TSP(k), TSP(i+1))+Dis(TSP(j), TSP(k+1))-DelCost;
    if (round(temp_Imp_in_Cost1,3)<0)
        Improvement_in_Cost = temp_Imp_in_Cost1;
        Three_Opt_Type=1;
        node1=i; 
        node2=j;
        node3=k;
     else if (round(temp_Imp_in_Cost2,3)<0)
                      Improvement_in_Cost = temp_Imp_in_Cost2;
                      Three_Opt_Type=2;
                      node1=i; 
                      node2=j;
                      node3=k;  
         end
    end
end
end

                     
                   