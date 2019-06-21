
% example code for GA

% one point crossover
child1=zeros(1,n);
child2=zeros(1,n);
c1=randperm(n,1);
child1=parent2(1:c1);
child2=parent1(1:c1);
I1=ismember(parent1,child1);
I2=ismember(parent2,child2);
child_to_add1=parent1(I1~=1);
child_to_add2=parent2(I2~=1);
child1=[child1, child_to_add1];
child2=[child2, child_to_add2];

% two way cross over

