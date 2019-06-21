
function [TSB,total_dis] = cheapest_insertion_fn(dis,TSBtype)
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

%%%%%%% step 3: find the cheapest node to current subtour
while (nb_un_nodes~=0)
    M=[];
    I=[];
    for i=un_nodes
        min_cost=inf;
        for j=1:size(TSB,2)-1
            cost=dis(TSB(j),i)+dis(TSB(j+1),i)-dis(TSB(j),TSB(j+1));
            if cost<min_cost
                min_cost=cost;
                insert_location=j+1;
            end
        end
          
          M=[M,min_cost];
          I=[I,insert_location];
           
 end
 [min_dis,index]=min(M);
 node=un_nodes(index);
 insert_location=I(index);
 
 %%%%% step 4: insert the node into the subtour
 if isequal(TSBtype,'Open')
     if min_dis>dis(TSB(end),node)
         total_dis=total_dis+dis(TSB(end),node);
         TSB=[TSB,node];
             
     else
         TSB=[TSB(1:insert_location-1),node,TSB(insert_location:end)];
         total_dis=total_dis+min_dis;
     end
 else
     TSB=[TSB(1:insert_location-1),node,TSB(insert_location:end)];
     total_dis=total_dis+min_dis;
 end
 
 nb_un_nodes=nb_un_nodes-1;
 un_nodes(un_nodes==node)=[];
 TSB_size=TSB_size+1;
end

 
 