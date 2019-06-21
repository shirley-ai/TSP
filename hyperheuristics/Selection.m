function [P1, P2]=Selection(Population, Population_Size, TournomentSize)
Pop_idx=1:Population_Size;
Pop_Size=Population_Size;
% select the first parent
TournomentList_index=randperm(Population_Size,TournomentSize);
TournomentList_Cost = zeros(1,TournomentSize);
for  i = 1: TournomentSize
    TournomentList_Cost(i)=Population{TournomentList_index(i),1};
end
[M,I]=min(TournomentList_Cost);    
P1 = TournomentList_index(I);
% select the second parent
Pop_idx(P1)=[];
TournomentList_index=Pop_idx(randperm(Population_Size-1,TournomentSize));
for  i = 1: TournomentSize
    TournomentList_Cost(i)=Population{TournomentList_index(i),1};
end
[M,I]=min(TournomentList_Cost);    
P2 = TournomentList_index(I);
clear TournomentList_Cost;
clear TournomentList_index;
end