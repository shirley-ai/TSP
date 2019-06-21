function [Cost, NewTSP ] = Shaking_procedure_mona(TSP,Cost,TSP_Size,Dis,Neighbor_Str)

if(Neighbor_Str==1)% generate random neighbor by 2opt
    
    % Generate a random neighbor of the current solution
    i=randi([1 TSP_Size-3]);
    j=randi([i+2 TSP_Size-1]);
%     % compute the Improvement_in_Cost
%     Improvement_in_Cost=Dis(TSP(i),TSP(j))+Dis(TSP(i+1), TSP(j+1))-Dis(TSP(i),TSP(i+1))-Dis(TSP(j),TSP(j+1));
    % perform the move
    NewTSP=[TSP(1:i) fliplr(TSP(i+1:node2)) TSP(j+1:end) ];
    Cost=total_lentgh(NewTSP,TSP_Size, Dis) 
else% % generate random neighbor by 3-opt & Oropt
    
    % Generate a random neighbor of the current solution
    i=randi([1 TSP_Size-3]);
    j=randi([i+1 TSP_Size-2]);
    k=randi([1 TSP_Size-1]);
    
    try
        
        while((k+1>i)&& (j+1>k))
            k=randi([1 TSP_Size-1]);
        end
    catch ME
    end
    % compute the Improvement_in_Cost
    
    DelCost=Dis(TSP(i),TSP(i+1))+Dis(TSP(j),TSP(j+1))+Dis(TSP(k),TSP(k+1));
    
    temp_Imp_in_Cost1 = Dis(TSP(i),TSP(k))+Dis(TSP(j+1), TSP(i+1))+Dis(TSP(j),TSP(k+1))-DelCost;
    temp_Imp_in_Cost2 = Dis(TSP(i),TSP(j+1))+Dis(TSP(k), TSP(i+1))+Dis(TSP(j), TSP(k+1))-DelCost;
    
    if (temp_Imp_in_Cost2<=temp_Imp_in_Cost1)
        Improvement_in_Cost=temp_Imp_in_Cost2;
        Three_Opt_Type=2;
        
    else
        Improvement_in_Cost=temp_Imp_in_Cost1;
        Three_Opt_Type=1;
    end
    % perform the move
    [Cost,NewTSP]=  Perform_3optMove(TSP,TSP_Size,Dis, i,j,k,Three_Opt_Type);
    
end

% Cost=Cost+Improvement_in_Cost;

end