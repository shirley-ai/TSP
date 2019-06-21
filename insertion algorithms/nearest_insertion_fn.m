
function [TSP,total_dis] = nearest_insertion_fn(dis,TSPtype)
% solve TSB problems using nearest insertion procedure

%%%%%%%%% step 1: initialize all the variables 

nb_nodes=size(dis,2); % number of nodes
nb_un_nodes=nb_nodes; % number of unvisited nodes
p=[]; % track the nodes that has been visited
un_nodes=1:nb_nodes; % track the unvisited nodes
total_dis=0; % initialize total distance

depot=1; % initialize the depot. in nearest insertion we can start with any depot
p=1;
un_nodes(un_nodes==depot)=[];
nb_un_nodes=nb_un_nodes-1;

%%%%%%%%% step 2: find the closest node to depot
[min_dis,index]=min(dis(depot,un_nodes));
node=un_nodes(index); % node refers to selected node
TSP=[depot,node];
TSP_size=2;
total_dis=total_dis+dis(depot,node);

if (isequal(TSPtype,'Closed')) % for closed TSB
    TSP_size=3;
    total_dis=total_dis+dis(TSP(end),TSP(1));
    TSP=[TSP,TSP(1)];
end
nb_un_nodes=nb_un_nodes-1;
un_nodes(un_nodes==node)=[];

%%%%%%% step 3: find the closest node to current subtour
while (nb_un_nodes~=0)
    if nb_un_nodes>1
        if isequal(TSPtype,'Closed') %注意不要用‘==’这个判断，否则要报错
            [min_dis,index]=min(dis(un_nodes,TSP(1,1:TSP_size-1))); % for closed TSB, the last node is repeated
        else
            [min_dis,index]=min(dis(un_nodes,TSP));
        end
        [M,I]=min(min_dis);
        node_index=index(I);
        node=un_nodes(node_index);
    else
        node=un_nodes;
    end
    disp(['Nearest Node' int2str(node)])
    
 %%%%%%%% step 4: find how to insert the selected node
 min_cost=inf;
 for j=1:size(TSP,2)-1
     cost=dis(TSP(j),node)+dis(TSP(j+1),node)-dis(TSP(j),TSP(j+1));
     disp(['Insertion(',int2str(node),',(',int2str(TSP(j)),',',int2str(TSP(j+1)),')=',int2str(cost)])
     
     if cost<min_cost
         min_cost=cost;
         insert_location=j+1;
     end
 end
 
 %%%%% step 5: insert the node into the subtour
 if isequal(TSPtype,'Open')
     if min_cost>dis(TSP(end),node)
         total_dis=total_dis+dis(TSP(end),node);
         TSP=[TSP,node];
             
     else
         TSP=[TSP(1:insert_location-1),node,TSP(insert_location:end)];
         total_dis=total_dis+min_cost;
     end
 else
     TSP=[TSP(1:insert_location-1),node,TSP(insert_location:end)];
     total_dis=total_dis+min_cost;
 end
 
 nb_un_nodes=nb_un_nodes-1;
 un_nodes(un_nodes==node)=[];
 TSP_size=TSP_size+1;
end

 
 