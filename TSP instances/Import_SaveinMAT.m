


samples_optSolution={
%     'ch130' , 6110;
%     'ch150' , 6528;
%     'eil51' , 426
%  'eil76' , 538;
%  'eil101' , 629;
% 'kroA100' , 21282
% 'kroB100' , 22141;
% 'kroC100' , 20749;
% 'kroD100' , 21294;
% 'kroE100' , 22068;
% 'kroA150' , 26524;
% 'kroB150', 26130;
% 'kroA200' , 29368;
% 'kroB200' , 29437;
% 'pr76' , 108159;
% 'pr107' , 44303;
% 'pr124' , 59030;
% 'pr136' , 96772;
% 'pr144' , 58537;
% 'pr152' , 73682;
% 'pr226' , 80369;
% 'pr264' , 49135;
% 'pr299' , 48191;
% 'tsp225',3919;
% 'lin318',42029;
'd493',35002;

 'pr439' , 107217;
'pr1002' , 259045;
% 'pr2392' , 378032;
'u159' , 42080;
'u574' , 36905;
'u724' , 41910;
'u1060' , 224094;
'u1432' , 152970;
% 'u1817' , 57201;
% 'u2152' , 64253;
% 'u2319' , 234256
};
% for i=1:10
i=1
newStr = [samples_optSolution{i,1} +'.txt'];

Data=d493;
DataName = [samples_optSolution{i,1} +'.mat'];
OptSolution=samples_optSolution{i,2};
save(DataName,'Data','OptSolution')
% end