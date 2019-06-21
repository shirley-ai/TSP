% function TSP = Insertion_Heuristics(nodes,Dis,InsertionCriteria,TSPType)
PlotTour=false;

TSPType='Closed'; %open  Closed
if(PlotTour==true)
    h = figure;
    set(h,'Name',[TSPType    ])
end

%given Location, coordinates of the nodes,(Or Dis Matrix) and Nb_Nodes, number of cities/nodes, find a tour using Insertion heuristic

% Location=[21 2; 12 43;10 5; 32 12; 14 21; 32 23; 24 27;35 40;30 43;32 10;35 36; 32 40;10 24;40 15;10 15];
% Nb_Nodes=15;
% 
% %  %Calculate the distance matrix and initialise the 'Dis' matrix
% Dis=pdist2(Location,Location);

% 
Dis=[0 42 11 15 20 24 25;
    42 0 38 37 22 28 20;
    11 38 0 23 16 28 26;
    15 37 23 0 20 11 17;
    20 22 16 20 0 18 12;
    24 28 28 11 18 0 9;
    25 20 27 17 12 9 0];
Nb_Nodes=7;

%Create a list called 'Unvisited_nodes' that keeps track of the nodes not visited by the salesman (not in P).
Nb_Unvisited_Nodes=Nb_Nodes;
Unvisited_nodes=1:Nb_Nodes;

% Initialize the depot to  node 1, since the salesman departures from the warehouse/Depot (i.e. node 1).
Depot=3;
% Initialize the Total Distance to Zero
Total_Distance=0;


% remove the depot from the list of unvisited nodes
Unvisited_nodes(Unvisited_nodes==Depot)=[];
Nb_Unvisited_Nodes=Nb_Unvisited_Nodes-1;

% find the  closest nodes to the Depot
[MinDistance,nodeindex]=min(Dis(Depot,Unvisited_nodes));
node=Unvisited_nodes(nodeindex);

%create AN OPEN tour, called 'TSP'
TSP=[Depot node];
Tour_size=2;
Total_Distance=Total_Distance+Dis(Depot,node);
% if the TSPType is closed TSP
%Join the first and last nodes of the TSP TO obtain a closed TSP tour.
if(isequal(TSPType,'Closed'))
    Total_Distance=Total_Distance+Dis(TSP(end) ,TSP(1));
    TSP=[TSP TSP(1)];
    Tour_size=3;
    
end
% update the Unvisited_nodes & Nb_Unvisited_Nodes
Unvisited_nodes(nodeindex)=[];
Nb_Unvisited_Nodes=Nb_Unvisited_Nodes-1;
%%%% plot tour
if(PlotTour==true)
    hold on
    % plot the location of nodes
    scatter(Location(:,1),Location(:,2),'b');
    x = Location(TSP(1:Tour_size),1);
    y = Location(TSP(1:Tour_size),2);
    
    % Plot new Tour
    plot(x,y,'r',x,y,'k.');
    hold off
    % pause(5)
end

% while there is a n unvisited node left Do
while(Nb_Unvisited_Nodes>0)
    
    % select the next node to insert based on Insertion Criteria
    % Insertion Criteria = Closest
    if(Nb_Unvisited_Nodes>1)
        Dist_to_TSP=Dis(Unvisited_nodes ,TSP(1,1:Tour_size-1));
        [Distance_To_TSP,i_uninserted]=     min(Dist_to_TSP);
        [M,I]=  min(Distance_To_TSP);
        nodeindex=i_uninserted(I);
        node=Unvisited_nodes(nodeindex);
    else
        node=Unvisited_nodes;
        nodeindex=1;
    end
    disp([ 'Nearest Node ' int2str(node) ])
    
    
    %calculate insertion cost of the chosen node in the TSP tour
    MinInsertionCost=inf; %inf是无穷大
    
    for j=1:size(TSP,2)-1
        insertionCost=Dis(TSP(j),node)+Dis(TSP(j+1),node)-Dis(TSP(j),TSP(j+1));
        disp(['Insertion(' int2str(node) ',(' int2str(TSP(j)) ',' int2str(TSP(j+1)) ')=' int2str(insertionCost)])
        
        if(MinInsertionCost>insertionCost)
            inspos=j+1;
            %inspos=j;
            MinInsertionCost=insertionCost;
        end
        
    end
    
    % insert the node in the best position in the tour
    if(isequal(TSPType,'open'))
        if(MinInsertionCost>Dis(TSP(Tour_size),node))
            TSP=[TSP node]; %对于open TSB，我们可以选择不插入两点之间，如果插入成本高于直接连接最后一点的成本的话
        else
            TSP=InserColumntInArray(TSP,inspos,node);
        end
    else
        TSP=InserColumntInArray(TSP,inspos,node);
        Total_Distance =   Total_Distance +     MinInsertionCost;
        disp(['insertion position ' int2str(inspos) '-> ' int2str(TSP) '  :  Cost ' int2str(Total_Distance)] )
        
    end
    
    Unvisited_nodes(nodeindex)=[];
    Nb_Unvisited_Nodes=Nb_Unvisited_Nodes-1;
    
    Tour_size=Tour_size+1;
    if(PlotTour==true)
        clf
        hold on
        % plot the location of nodes
        scatter(Location(:,1),Location(:,2),'b');
        x = Location(TSP(1:Tour_size),1);
        y = Location(TSP(1:Tour_size),2);
        
        % Plot new Tour
        plot(x,y,'r',x,y,'k.');
        hold off
        % pause(5)
    end
    
    
    
end
