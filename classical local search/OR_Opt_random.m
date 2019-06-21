% find a random better neighbor in OR-opt
function [node1,node2,node3,Improvement_in_Cost]= OR_Opt_random(TSP,Dis)

Imp=inf;
TSP_Size=size(TSP,2);

while (Imp>=0)
    p=randperm(TSP_Size-3,2);
    if (p(2)-p(1)==1) %to avoid overlap of the 3 adjascent nodes and the other 2 nodes
        continue
    end
    i=p(1)-1;
    j=p(1)+2;
    k=p(2);
          
    %calculate the cost reduction of breaking 3 edges
    DelCost=Dis(TSP(i),TSP(i+1))+Dis(TSP(j),TSP(j+1))+Dis(TSP(k),TSP(k+1));
    %caculate the cost change of adding new edges
    %in OR-opt we only choose the neighbor without reverse
    Improvement_in_Cost = Dis(TSP(i),TSP(j+1))+Dis(TSP(k), TSP(i+1))+Dis(TSP(j), TSP(k+1))-DelCost;
    Imp=round(Improvement_in_Cost,3);
    if (Imp<0)
      
        node1=i; 
        node2=j;
        node3=k;
    end
end
end

    


                     
                   