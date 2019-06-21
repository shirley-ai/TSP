function [SA_Fitness, SA_TSP ] = SA_Two_opt(TSP,Distance,SA_Parameters)
% This function is to calculate fitness and correspondent TSP
% Two-opt is used to explore new neighbors


% calculate the initial best cost
TSPCost=0;
  for i=1:size(TSP,2)-1
      TSPCost=TSPCost+Distance(TSP(i),TSP(i+1));
  end
    TSP_Size=size(TSP,2);  
    Imp=-1;
    % input all parameters
    Temp=SA_Parameters{1}; % initial temperature
    MinTemp=SA_Parameters{2}; % final temperature
    Max_R=SA_Parameters{3}; % number of neighbours to visit at each stage
    TCF_Criterion=SA_Parameters{4}; % cooling function
    Alpha=SA_Parameters{5}; % temperature change rate
    APF_Criterion=SA_Parameters{6}; % acceptance probability function
    % stopping condition is fixed, excluded from parameters

    iter=1;% number of iterations
    beta=Alpha-0.05;% reheating rate
    %Initialize BestCost to TSPCost
    BestCost=TSPCost;
    BestTSP=TSP;
    Cost=TSPCost;
   % number of no improvement
    Nb_No_Imp=0;
    
    while(Temp>MinTemp) 
        iter=iter+1;
        Initial_BestCost=BestCost; % record the initial best cost at each temperature
        for r=1:Max_R
        % find neighbors using two-opt
        i=randi([1 TSP_Size-3]);
        j=randi([i+2 TSP_Size-1]);
        Imp=Distance(TSP(i),TSP(j))+Distance(TSP(i+1), TSP(j+1))-Distance(TSP(i),TSP(i+1))-Distance(TSP(j),TSP(j+1));
        Imp=round(Imp,3);
        RND=rand(); % generate a random number
        if APF_Criterion==1
            APF=exp(-Imp/Temp); % acceptance function 1
        else 
            APF=1-Imp/Temp;% acceptance function 2
        end
        if(Imp<=0 || RND< APF) %if there is improvement, or meets acceptance function
                
               NewTSP=[TSP(1:i) fliplr(TSP(i+1:j)) TSP(j+1:end) ];
               TSP=NewTSP;
               Cost=Cost+Imp;
                       
        end
              
               % if new cost is better than best cost, update best cost
        if(BestCost > Cost)
                    
                    
                    BestCost = Cost;
                    BestTSP=NewTSP;
                    

        end
        end % end of iterature at this temperature
        
        BestImp=BestCost-Initial_BestCost;
            if BestImp>=0
                Nb_No_Imp=Nb_No_Imp+1;
            else
                Nb_No_Imp=0;
            end
            
            if TCF_Criterion==1
                Temp=Temp*Alpha; % geometric cooling
            else %geometric reheating
                if Nb_No_Imp>=8
                    Temp=Temp/beta;
                    Nb_No_Imp=0; % avoid keeping heating up
                else
                    Temp=Temp*Alpha;
                end
                    
        

            
        
        end
     SA_Fitness=BestCost;
     SA_TSP=BestTSP;   
        
    end
 end

