% TSB problem
% to solve the TSB problem using Heuristics
%
% Shirley Chen, 22/09/2018

% variable directory
% Dis               the distance matrix
% p                 the set containing visited nodes
% unvisited_nodes   the set containing unvisited nodes
% total_cost        the total distance of the chosen route
% min               temporary value used to compare distance
% location          temporary value used to update unvisited_nodes


clear
clc

Dis=[0 42 11 15 20 24 25;...
42 0 38 37 22 28 20;...
11 38 0 23 16 28 26;...
15 37 23 0 20 11 17;...
20 22 16 20 0 18 12;...
24 28 28 11 18 0 9;...
25 20 26 17 12 9 0]; % the distance matrix

p={}; % visited places
unvisited_nodes={1,2,3,4,5,6,7}; % unvisited places

p{1}=3; % initialize the first element by starting from node 3
unvisited_nodes(3)=[]; % remove node 3 from unvisited cell

min=100; % initiate a value for the minimum distance between two nodes

for i=1:1:6
    if Dis(p{1},unvisited_nodes{i})<min
        p{2}=unvisited_nodes{i};
        min=Dis(p{1},unvisited_nodes{i});
        location=i;
    end
end
% choose the second node with the shortest distance to start point and add it to p

unvisited_nodes(location)=[]; % remove the visited node from unvisited cell

min=100; % initiate a value for the minimum distance between two nodes

for i=1:1:5
    if Dis(p{2},unvisited_nodes{i})<min
        p{3}=unvisited_nodes{i};
        min=Dis(p{2},unvisited_nodes{i});
        location=i;
    end
end
% choose the third node

unvisited_nodes(location)=[]; % update the unvisited nodes

min=100; % initiate a value for the minimum distance between two nodes

for i=1:1:4
    if Dis(p{3},unvisited_nodes{i})<min
        p{4}=unvisited_nodes{i};
        min=Dis(p{3},unvisited_nodes{i});
        location=i;
    end
end
% choose the fourth node

unvisited_nodes(location)=[]; % update the unvisited_nodes

min=100; % initiate a value for the minimum distance between two nodes

for i=1:1:3
    if Dis(p{4},unvisited_nodes{i})<min
        p{5}=unvisited_nodes{i};
        min=Dis(p{4},unvisited_nodes{i});
        location=i;
    end
end
% choose the fifth node

unvisited_nodes(location)=[]; % update the unvisited_nodes

min=100; % initiate a value for the minimum distance between two nodes

for i=1:1:2
    if Dis(p{5},unvisited_nodes{i})<min
        p{6}=unvisited_nodes{i};
        min=Dis(p{5},unvisited_nodes{i});
        location=i;
    end
end
% choose the fourth node

unvisited_nodes(location)=[]; % update the unvisited_nodes

p{7}=unvisited_nodes{1} % the only unvisited node
% leave the semicolon to show the whole route 

total_cost=0;
for i=1:1:7
    if i<7
        total_cost=total_cost+Dis(p{i},p{i+1});
    else
        total_cost=total_cost+Dis(p{1},p{7}) % leave the semicolon because we need to see the final result
    end
end
% calculate the total distance

 
