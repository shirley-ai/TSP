% find a random better neighbor in 2-opt
function [node1,node2,imp]= Two_Opt_random(TSP,Dis)

imp=0; %initialize the improvement value
TSP_Size=size(TSP,2);
% find a random neighbor that can improve the solution, and that's it
while (imp>=0)
    p=randperm(TSP_Size-1,2);%generate two random nodes
    i=p(1);
    j=p(2);
    imp=Dis(TSP(i),TSP(j))+Dis(TSP(i+1), TSP(j+1))-Dis(TSP(i),TSP(i+1))-Dis(TSP(j),TSP(j+1));
    imp=round(imp,3);
end
node1=i;
node2=j;




end