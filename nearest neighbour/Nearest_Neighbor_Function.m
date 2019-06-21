function [Total_Distance,TSP ]= Nearest_Neighbor_Function(nodes,Nb_Nodes,Dis,Location,Depot,PlotTour)
%Create a matrix, called 'Dis', and set it to the given distance matrix.
% Dis=[0 42 11 15 20 24 25;
%     42 0 38 37 22 28 20;
%     11 38 0 23 16 28 26;
%     15 37 23 0 20 11 17;
%     20 22 16 20 0 18 12;
%     24 28 28 11 18 0 9;
%     25 20 27 17 12 9 0];
% Nb_Nodes=7;


%Create an empty list referred to as 'P', that keeps track of the path travelled by the salesman.
p=[];
%Create a list called 'Unvisited_nodes' that keeps track of the nodes not visited by the salesman (not in P).
Nb_Unvisited_Nodes=Nb_Nodes;
Unvisited_nodes=zeros(1,Nb_Nodes);
for i=1:Nb_Nodes
    Unvisited_nodes(i)=nodes(i,1);
end

% Initialize the path to  node 3, since the salesman departures from the warehouse/Depot (i.e. node 3).
% Depot=3;
P=Depot;
Unvisited_nodes(Depot)=[];%check  again
Nb_Unvisited_Nodes=Nb_Unvisited_Nodes-1;

% Initialize the Total Distance to Zero
Total_Distance=0;
%While Nb_Unvisited_Nodes is not Zero; i.e there is an unvisited node(s) left, repeate the following process
%From the nodes not in the path  P, select the one, say j, closest to the last node in the path and
%expand the current path by adding node j to P.
while(Nb_Unvisited_Nodes~=0)
    [M,I] = min(Dis(P(end),Unvisited_nodes));
    %ClosestNode=Unvisited_nodes(j);
    P=[P ,Unvisited_nodes(I)];
    Unvisited_nodes(I)=[];
    
    Total_Distance=Total_Distance+M;
    Nb_Unvisited_Nodes=Nb_Unvisited_Nodes-1;
 %%%% plot tour
    if(PlotTour==true)
        hold on
        scatter(Location(:,1),Location(:,2),'b');
        x = Location(P(1:end),1);
        y = Location(P(1:end),2);
        
        % Plot new Tour
        plot(x,y,'r',x,y,'k.');
      hold off
      
    end
end % end while

%Join the first and last nodes of the path ? to obtain a closed TSP tour.
TSP=[P P(1)];
Total_Distance=Total_Distance+Dis(P(end) ,P(1));


% end