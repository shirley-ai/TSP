%%%%%%%% upload test samples
samples_optSolution={
    'eil51' , 426;%$1
    'eil76' , 538;%$2
    'pr76' , 108159;%$3
    'kroA100' , 21282;%$4
    'kroB100' , 22141;%$5
    'kroC100' , 20749;%$6
    'kroD100' , 21294;%$7
    'kroE100' , 22068;%$8
    'eil101' , 629;%$9
    'pr107' , 44303;%$10
    'pr124' , 59030;%$11
    'ch130' , 6110;%$12
    'pr136' , 96772;%$13
    'pr144' , 58537;%$14
    'ch150' , 6528;%$15
    'kroA150' , 26524;%$16
    'kroB150', 26130;%$17
    'pr152' , 73682;%$18
    'kroA200' , 29368;%$19
    'kroB200' , 29437;%$20
    'pr299' , 48191;%$21
    'pr226' , 80369;%$22
    'pr264' , 49135;%$23
    'pr439' , 107217;%$24
    'pr1002' , 259045;%$25
    'u159' , 42080;%$26
    'u574' , 36905;%$27
    'u724' , 41910;%$28
    'u1060' , 224094;%$29
    'u1432' , 152970;%$30
    };
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Samples only saves the samples name
Samples=samples_optSolution(:,1);

% run the heursitics for all samples
% s is the sample number
% for s=1:30
s=2;
    %set sample to Samples{s}
    sample=Samples{s};
    %upload sample
    DataName = [sample +'.mat'];
    newData =load(DataName, 'Data','OptSolution');
    % set the Location to newData.Data
    Location=newData.Data;
     % set the optimal cost of the instance to (Opt_Cost) to newData.OptSolution
     
     Opt_Cost=newData.OptSolution;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % initialise figure and its title
    TSPType='open';
    h = figure(1);
    set(h,'Name',[TSPType '- Nearest Neighbor'  ])
    
    PlotTour=true; 
    
 
    
    % calculate the distance matrix given Location of Nodes
    Dis=pdist2(Location,Location);
    
    % Initialise Nb_Nodes to the number of nodes of the new instance
    Nb_Nodes=size(Location,1);
    
    % initialise the list nodes of the new problem instance
    % set the distance between each node and itself to inf
    nodes=zeros(Nb_Nodes,1);
    for i=1:size(Location,1)
        Dis(i,i)=inf;%%
        nodes(i,1)=i;
    end
    
    % set the depot to one
    Depot=1;
    
    %%% Run Heuristic
    
    % find a complete tour using Nearest Neighbor heuristic
    [Total_Distance,TSP ]= Nearest_Neighbor_Function(nodes,Nb_Nodes,Dis,Location,Depot,PlotTour);
   
    % calculate the Percentage Increase over the optimal solution ('Inc_over_opt')
    Inc_over_opt=round(((Total_Distance-Opt_Cost)/Opt_Cost)*100,4);
    
    %%Plot tour
    hold on
    set(h,'Name',[TSPType '- Nearest Neighbor_ Depot=' int2str(Depot)])
    title(['Cost ' int2str( Total_Distance ) ' (%' int2str(Inc_over_opt) ')'])
    scatter(Location(:,1),Location(:,2),'b');
    x = Location(TSP(1:end),1);
    y = Location(TSP(1:end),2);
    % Add node numbers to the plot
    for l=1:Nb_Nodes
        str = sprintf(' %d',l);
        text(Location(l,1),Location(l,2),str);
    end
    
    % Plot new Tour
    plot(x,y,'r',x,y,'k.');
    hold off
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%improve
    
    [BestCost2opt, Two_opt_TSP ] = Two_opt_LS(Location,Nb_Nodes,TSP,Total_Distance,Dis,PlotTour,TSPType);

    Inc_over_opt=round(((Total_Distance-BestCost2opt)/Opt_Cost)*100,4);
    
    
 
  


I = figure(3);
    set(I,'Name',[TSPType '- Nearest Neighbor'  ])
    
 hold on
    set(I,'Name',[TSPType '- Two_opt_LS '])
    title(['Cost ' int2str( BestCost2opt ) ' (%' int2str(Inc_over_opt) ')'])
    scatter(Location(:,1),Location(:,2),'b');
    
     % Add node numbers to the plot
    for l=1:Nb_Nodes
        str = sprintf(' %d',l);
        text(Location(l,1),Location(l,2),str);
    end
    
    x = Location(Two_opt_TSP(1:end),1);
    y = Location(Two_opt_TSP(1:end),2);
    
    % Plot new Tour
    plot(x,y,'r',x,y,'k.');
    hold off
    
%   %%improve by 3 opt  
%     
%      [BestCost3opt, Three_opt_TSP ] = Three_opt_LS(Location,Nb_Nodes,TSP,Total_Distance,Dis,PlotTour,TSPType);
% 
%     Inc_over_opt=round(((Total_Distance-BestCost3opt)/Opt_Cost)*100,4);
%     
%     
%  
    
    
    
%     I = figure(4);
%     set(I,'Name',[TSPType '- 3 opt CLS'  ])
%     
%     hold on
%     set(I,'Name',[TSPType '- Two_opt_LS '])
%     title(['Cost ' int2str( BestCost3opt ) ' (%' int2str(Inc_over_opt) ')'])
%     scatter(Location(:,1),Location(:,2),'b');
%     
%     % Add node numbers to the plot
%     for l=1:Nb_Nodes
%         str = sprintf(' %d',l);
%         text(Location(l,1),Location(l,2),str);
%     end
%     
%     x = Location(Three_opt_TSP(1:end),1);
%     y = Location(Three_opt_TSP(1:end),2);
%     
%     % Plot new Tour
%     plot(x,y,'r',x,y,'k.');
%     hold off
%     
%     
%     
%     
%     % save the figure
%     % savefig(h,[sample '-D ' int2str(Depot) '.fig'])
%     
%     %close deletes the current figure h
%     % close(h)
%     % end