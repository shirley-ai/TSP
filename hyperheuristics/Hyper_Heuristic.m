% GA based hyper-heuristics to improve SA algorithm
clear
clc
% load data #############################################################
dataset=load('eil101.mat');
% dataset=load('pr107.mat');
% dataset=load('pr439.mat');
% dataset=load('u574.mat');
% dataset=load('pr1002.mat');
%  dataset=load('u1060.mat');

% get all the inputs#####################################################
Opt_Cost=dataset.OptSolution;%optimal cost
Location=dataset.Data;
Distance=pdist2(Location,Location);
Nb_Nodes=size(Distance,1);

% get initial TSP using nearest neighbor#################################
Unvisited_Nodes=1:Nb_Nodes;
Depot=1;
p=[Depot]; 
total_dis=0; 
nb_un_nodes=Nb_Nodes;
Unvisited_Nodes(Depot)=[];
nb_un_nodes=nb_un_nodes-1;
while (nb_un_nodes~=0)
    [m,j]=min(Distance(p(end),Unvisited_Nodes)); 
    p=[p,Unvisited_Nodes(j)];
    Unvisited_Nodes(j)=[];
    nb_un_nodes=nb_un_nodes-1;
    total_dis=total_dis+m;
end
TSP=[p,Depot];
TSP_Dist=total_dis+Distance(p(end),Depot);
% calculate the improvement
Inc_over_opt_NN=round(((TSP_Dist-Opt_Cost)/Opt_Cost)*100,4);

% initialize the SA parameter range######################################
InitTemp_Range=[1,20];
FinalTemp_Range=[0.1,0.5];
Rt_Range=[10,500];
TCF_Criterion=[1,2];
Alpha_Range=[.8,0.99];
APF_Criterion=[1,2];
SA_Param_Range={InitTemp_Range,FinalTemp_Range,Rt_Range,TCF_Criterion,Alpha_Range,APF_Criterion};

% initialize the GA elements############################################
Crossover=true;
Mutation=true;
Immigration=true;
CrossoverRate=.8;
MutationRate=0.01;
Population_Size=20;
immigrant_nb=round( Population_Size/3);
immigration_Frequency=30;


Nb_Evolutions=9999;
cpu_time=600;

TournomentSize = 4;
PP_Size=round(CrossoverRate*Population_Size/2)*2;
parents_pool=zeros(1,PP_Size);
elitism=.1*Population_Size;

% initialize population ##############################################
Population=Initialize(Population_Size,SA_Param_Range,TSP,Distance);
BestFitnes=Population{1,1};
BestIndividual=Population{1,2};

% evolution begin ##################################################
tic
for E=1:Nb_Evolutions
    NewGeneration={};
    % perform immigration %%%%%%%%%%%
    if (Immigration)
        if(rem(E,immigration_Frequency)==0)
            Immigrants = Initialize(immigrant_nb,SA_Param_Range,TSP,Distance);
            
            % delete some parents
            index=randperm((Population_Size-elitism),immigrant_nb)+elitism;% index for replacement
            Population(index,:)=[];
            CurrPopSize=Population_Size-immigrant_nb;
            % add immigrants
            for i=1:immigrant_nb
                Population= UpdatePopulation( Population, CurrPopSize, Immigrants{i,2}, Immigrants{i,1});
                CurrPopSize=CurrPopSize+1;
            end
        end
    end
    BestFitnes=Population{1,1};% update best cost
    
    % perform crossover %%%%%%%%%%%%%%
    % first select parents to crossover
    for i=1:(PP_Size/2)
        %select parents    based on the chosen selection mechanism
        [P1, P2] = Selection(Population, Population_Size,TournomentSize);
        parents_pool(2*i-1:2*i)=[P1, P2];
    end
    if(Crossover)
        for i=1:(PP_Size/2)
            P1= parents_pool(2*i-1);
            P2= parents_pool(2*i);
            Parent1=Population{P1,2};
            Parent2=Population{P2,2};
            [Child1,Child2]=CrossOverOperator(Parent1,Parent2);
            [Child1_Fitness, SA_TSP ] = SA_Two_opt(TSP,Distance,Child1);
            [Child2_Fitness, SA_TSP ] = SA_Two_opt(TSP,Distance,Child2);
            NewGeneration(end+1,:)={Child1_Fitness,Child1};
            NewGeneration(end+1,:)={Child2_Fitness,Child2};
        end
        % perform mutation on new generation%%%%%%%%%%%%%%%%
        if (Mutation)
            for m=1:2
                if(rand()<=MutationRate)
                    parent=NewGeneration{end-m+1,2};
                    NewChild=MutationOperator(parent,SA_Param_Range);
                    [NewChild_Fitness, SA_TSP ] = SA_Two_opt(TSP,Distance,NewChild);
                    % update new generation if parent here not best cost
                    if(NewGeneration{end-m+1,1}>BestFitnes)
                        NewGeneration(end-m+1,:)={NewChild_Fitness,NewChild};
                    end
                end
            end
        end
        % update population with new generation
        NG=size(NewGeneration,1);
        % first delete old parents randomly but keep the best ones
        index=randperm((Population_Size-elitism),NG)+elitism;% index for replacement
        Population(index,:)=[];
        CurrPopSize=Population_Size-NG;
        % add new generation
        for i=1:NG
            Population = UpdatePopulation( Population,CurrPopSize, NewGeneration{i,2}, NewGeneration{i,1});
            CurrPopSize=CurrPopSize+1;
        end
    
    end
    % update best solution so far
    if(BestFitnes>Population{1,1})
       BestFitnes=Population{1,1};
       BestIndividual=Population{1,2};
       ['E: ' int2str(E) ' => '  int2str(  BestFitnes) ]
    end
       time=toc; % stopping criteria
       if (time>cpu_time)
           break
       end
end
Inc_over_opt=round(((BestFitnes-Opt_Cost)/Opt_Cost)*100,4);
['Nearest Neighbor TSP:      '   int2str(  TSP_Dist) ' => ' sprintf('%.2f',Inc_over_opt_NN)]
['BestFitnes:      '   int2str(  BestFitnes) ' => ' sprintf('%.2f',Inc_over_opt)]
BestIndividual


    
        

