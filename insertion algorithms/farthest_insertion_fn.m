
function [TSB,total_dis] = farthest_insertion_fn(dis,TSBtype)
% solve TSB problems using farthest insertion procedure

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
[max_dis,index]=min(dis(depot,un_nodes));
node=un_nodes(index); % node refers to selected node
TSB=[depot,node];
TSB_size=2;
total_dis=total_dis+dis(depot,node);

if (isequal(TSBtype,'Closed')) % for closed TSB
    TSB_size=3;
    total_dis=total_dis+dis(TSB(end),TSB(1));
    TSB=[TSB,TSB(1)];
end
nb_un_nodes=nb_un_nodes-1;
un_nodes(un_nodes==node)=[];

%%%%%%% step 3: find the farthest node to current subtour
while (nb_un_nodes~=0)
    if nb_un_nodes>1
        if isequal(TSBtype,'Closed') %注意不要用‘==’这个判断，否则要报错
            [max_dis,index]=max(dis(un_nodes,TSB(1,1:TSB_size-1))); % for closed TSB, the last node is repeated
        else
            [max_dis,index]=max(dis(un_nodes,TSB));
        end
        [M,I]=min(max_dis);
        node_index=index(I);
        node=un_nodes(node_index);
    else
        node=un_nodes;
    end
    disp(['Nearest Node' int2str(node)])
    
 %%%%%%%% step 4: find how to insert the selected node
 min_cost=inf;
 for j=1:size(TSB,2)-1
     cost=dis(TSB(j),node)+dis(TSB(j+1),node)-dis(TSB(j),TSB(j+1));
     disp(['Insertion(',int2str(node),',(',int2str(TSB(j)),',',int2str(TSB(j+1)),')=',int2str(cost)])
     
     if cost<min_cost
         min_cost=cost;
         insert_location=j+1;
     end
 end
 
 %%%%% step 5: insert the node into the subtour
 if isequal(TSBtype,'Open')
     if min_cost>dis(TSB(end),node)
         total_dis=total_dis+dis(TSB(end),node);
         TSB=[TSB,node];
             
     else
         TSB=[TSB(1:insert_location-1),node,TSB(insert_location:end)];
         total_dis=total_dis+min_cost;
     end
 else
     TSB=[TSB(1:insert_location-1),node,TSB(insert_location:end)];
     total_dis=total_dis+min_cost;
 end
 
 nb_un_nodes=nb_un_nodes-1;
 un_nodes(un_nodes==node)=[];
 TSB_size=TSB_size+1;
end

 
 