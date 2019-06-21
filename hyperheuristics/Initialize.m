function Population=Initialize(Population_Size,SA_Param_Range,TSP,Distance)
% all parameters are randomly chosen
% for TCF: when 1, it's geometric cooling; otherwise, geometric reheating
% for APF: when 1, standard function; otherwise, 1-imp/T (approximate exponential function)
    
% create the first individual 
    Population=cell(1,2);
    I_Temp=randi(SA_Param_Range{1}(2));
    F_Temp=(randi(SA_Param_Range{2}(2)*100-SA_Param_Range{2}(1)*100)+SA_Param_Range{2}(1)*100)/100;
    Rt=randi(SA_Param_Range{3}(2)-SA_Param_Range{3}(1))+SA_Param_Range{3}(1);
    TCF_Criteria=SA_Param_Range{4}(2);
    Alpha=(randi(SA_Param_Range{5}(2)*100-SA_Param_Range{5}(1)*100)+SA_Param_Range{5}(1)*100)/100;
    APF_Criteria=SA_Param_Range{6}(2);
    
    SA_Parameters = {I_Temp,F_Temp,Rt,TCF_Criteria,Alpha,APF_Criteria};
    [SA_Fitness, SA_TSP ] = SA_Two_opt(TSP,Distance,SA_Parameters);
    % add the individual to the Population list
    Population(1,:)={SA_Fitness, SA_Parameters};
    % set the current population size to one
    CurrPopSize=1;
    
    % create other individuals and update the population
    if (Population_Size>1)
for i=2:Population_Size
    I_Temp=randi(SA_Param_Range{1}(2));
    F_Temp=(randi(SA_Param_Range{2}(2)*100-SA_Param_Range{2}(1)*100)+SA_Param_Range{2}(1)*100)/100;
    Rt=randi(SA_Param_Range{3}(2)-SA_Param_Range{3}(1))+SA_Param_Range{3}(1);
    TCF_Criteria=SA_Param_Range{4}(rem(i,2)+1);
    Alpha=(randi(SA_Param_Range{5}(2)*100-SA_Param_Range{5}(1)*100)+SA_Param_Range{5}(1)*100)/100;
    APF_Criteria=SA_Param_Range{6}(rem(i,2)+1);
    %SC=SA_Param_Range{7}(rem(i,2)+1);
    
    SA_Parameters = {I_Temp,F_Temp,Rt,TCF_Criteria,Alpha,APF_Criteria};
    [SA_Fitness, SA_TSP ] = SA_Two_opt(TSP,Distance,SA_Parameters);
    Population = UpdatePopulation( Population,CurrPopSize,  SA_Parameters, SA_Fitness);
    % increase the  current population size by one
    CurrPopSize=CurrPopSize+1;
end
    end
end
    