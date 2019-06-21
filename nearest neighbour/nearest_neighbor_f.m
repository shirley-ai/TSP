
function [total_dis,TSP]=nearest_neighbor_f(dis,nb_nodes,depot)
% create a function to solve all nearest neighbor TSP problems
p=[];
un_nodes=1:nb_nodes;
total_dis=0;
nb_un_nodes=nb_nodes;

p=depot;
un_nodes(un_nodes==depot)=[];
nb_un_nodes=nb_un_nodes-1;

while (nb_un_nodes~=0)
    [m,j]=min(dis(p(end),un_nodes));
    p=[p,un_nodes(j)];
    un_nodes(j)=[];
    nb_un_nodes=nb_un_nodes-1;
    total_dis=total_dis+m;
end

TSP=[p,p(1)];
total_dis=total_dis+dis(p(end),p(1));
end