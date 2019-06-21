
function [node1,node2,node3,Improvement_in_Cost,Three_Opt_Type]= Three_Opt(TSP,Dis)

Improvement_in_Cost=inf;
TSP_Size=size(TSP,2);
%find best possible improvement

% calculate the improvements acheived by all combination of 3-opt and pick the best amongst them
              
for i=1:TSP_Size-2
    for j=i+1:TSP_Size-1 %������������
        %ע�⣬��Ȼ���õ������3���Σ��������غ�һ���㣬��Ҫ�������㶼�غϣ�����TSP·��Ҫ������
        for k=1:TSP_Size-1%������еĵ�������
            if((k+1<=i)|| (j+1<=k))%����Ϊ�˷�ֹ�ظ����㣬���������һ�䣬�ڶ����ߺ͵������ߵĹ��ܾͻ�ʱ������
                 DelCost=Dis(TSP(i),TSP(i+1))+Dis(TSP(j),TSP(j+1))+Dis(TSP(k),TSP(k+1));
                %�ȼ���break edge�ĳɱ�
                temp_Imp_in_Cost1 = Dis(TSP(i),TSP(k))+Dis(TSP(j+1), TSP(i+1))+Dis(TSP(j),TSP(k+1))-DelCost;
                temp_Imp_in_Cost2 = Dis(TSP(i),TSP(j+1))+Dis(TSP(k), TSP(i+1))+Dis(TSP(j), TSP(k+1))-DelCost;
                %Ȼ������������ӵĳɱ��仯��ע�����ﲻ��Ҫ�������б߳���ֻ��Ҫ�������ӵ�3���߳ɱ�
                  if ((temp_Imp_in_Cost1 < temp_Imp_in_Cost2) && (temp_Imp_in_Cost1< Improvement_in_Cost))
                        
                      Improvement_in_Cost = temp_Imp_in_Cost1;
                      Three_Opt_Type=1;
                      node1=i; 
                      node2=j;
                      node3=k;
                  else if ((temp_Imp_in_Cost1 >= temp_Imp_in_Cost2) && (temp_Imp_in_Cost2 < Improvement_in_Cost))
                      Improvement_in_Cost = temp_Imp_in_Cost2;
                      Three_Opt_Type=2;
                      node1=i; 
                      node2=j;
                      node3=k;  
                      %ѡ����õ����ӷ�ʽ
                      end
                  end
            end
        end
    end
end
end