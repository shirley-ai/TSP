function [Child1,Child2]=CrossOverOperator(Parent1,Parent2)
% one-point crossover
n=size(Parent1,2);
Child1=zeros(1,n);
Child2=zeros(1,n);
C1 = randi([1, n - 1],1,1);
Child1 = [Parent2(1:C1) Parent1(C1+1:end)];
Child2 = [Parent1(1:C1) Parent2(C1+1:end)];
end
