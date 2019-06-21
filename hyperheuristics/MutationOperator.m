function NewChild=MutationOperator(Child,SA_Param_Range)
% mutate one parameter each time
n=randi(6);
switch n
    case 1
        Child{1}=randi(SA_Param_Range{1}(2));
    case 2
        Child{2}=(randi(SA_Param_Range{2}(2)*100-SA_Param_Range{2}(1)*100)+SA_Param_Range{2}(1)*100)/100;
    case 3
        Child{3}=randi(SA_Param_Range{3}(2)-SA_Param_Range{3}(1))+SA_Param_Range{3}(1);
    case 4
        if Child{4}==1
            Child{4}=2;
        else
            Child{4}=1;
        end
    case 5
        Child{5}=(randi(SA_Param_Range{5}(2)*100-SA_Param_Range{5}(1)*100)+SA_Param_Range{5}(1)*100)/100;
    case 6
        if Child{6}==1
            Child{6}=2;
        else
            Child{6}=1;
        end
end
NewChild=Child;
end