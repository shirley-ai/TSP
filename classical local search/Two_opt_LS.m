function [BestCost, TSP ] = Two_opt_LS(Location,Nb_Nodes,TSP,TSPCost,Dis,PlotTour,TSPType)
%����㷨�ṹ�ǳ��򵥣��������£�
%1�����ó�ʼֵ
     % ����ֵ  -1 �����һ�����������ԣ�����ѭ��������
     % ѭ�������� 1
     % ����node -1,-1
     % ��ͳɱ� ��ʼֵΪԭ·����ֵ
%2��дѭ��
     % ѭ������     ����ֵΪ��������2-opt����������·�ɱ�����·�ɱ���
     % ����2-opt����   �õ�����ֵ�Լ��������λ��
     % �������ֵΪ����������ͳɱ���·��
     

%Note that the initial feasible solution is TSP and the corresponding objective function 
% value is TSPCost

% the neighborhood structure to use is
% whole neighborhood of TSP, for its best neighbor using Two_Opt move

if (PlotTour==1)
    I1=  figure (2) ;
    set(I1,'Name',[TSPType '- 2 opt LS' ])
end

BestImp=-1;
Improvement_in_Cost=Inf;
%Initialize iteration counter iter
iter=1;
%Initialize  node1 & node2 to -1
node1=-1;
node2=-1;
%Initialize BestCost to TSPCost
BestCost=TSPCost;

%REPEAT until stopping condition = true // e.g., (TSP is a local optimum [BestImp<0] )

while(BestImp<0)
    
    % search the neighborhood of TSP given the neighborhood structure
    [node1,node2,Improvement_in_Cost]=Two_Opt(TSP,Dis);
    
    BestImp=round(Improvement_in_Cost,3);
    % if the BestImp is less than zero (i.e. a better neighbor is found
    % that improves the tour by Improvement_in_Cost, update the BestCost
    % and current neighbor TSP
    if(BestImp<0)
        
        Cost=BestCost+Improvement_in_Cost;
        
        BestCost=Cost;
        
        %%% one way of updating the tour
        %     Tour_size=Nb_Nodes+1;
        %     NewTSP=zeros(1,Tour_size);
        %         for i=1:node1
        %             NewTSP(i)=TSP(i);
        %         end
        %
        %         %reverse
        %         counter=node1+1;
        %
        %         for i=node2:-1:node1+1
        %             NewTSP(counter)=TSP(i);
        %             counter=counter+1;
        %         end
        %
        %         %      index=node2;
        %         %      counter=1;
        %         %      L=zeros(1,4);
        %         %      while (index>=2)
        %         %          L(counter)=D(index);
        %         %          counter=counter+1;
        %         %          index=index-1;
        %         %      end
        %
        %         for i=node2+1:Tour_size
        %             NewTSP(i)=TSP(i);
        %         end
        %
        %
        %        if (PlotTour)
        %                iter=iter+1;
        %
        %
        %                hold on
        %                set(I1,'Name',[TSPType '- 2 opt LS' ])
        %                title(['Cost ' int2str( BestCost )])
        %                scatter(Location(:,1),Location(:,2),'b');
        %
        %                % Add node numbers to the plot
        %                for l=1:Nb_Nodes
        %                    str = sprintf(' %d',l);
        %                    text(Location(l,1),Location(l,2),str);
        %                end
        %
        %                x = Location(NewTSP(1:end),1);
        %                y = Location(NewTSP(1:end),2);
        %
        %                % Plot new Tour
        %                plot(x,y,'r',x,y,'k.');
        %                hold off
        %          end
        %
        %          TSP=zeros(1,Tour_size);
        %          for i=1:Tour_size
        %             TSP(i)=NewTSP(i);
        %         end
        %%% easy way of updating the tour
        NewTSP=[TSP(1:node1) fliplr(TSP(node1+1:node2)) TSP(node2+1:end) ];
        
        % plot the tour
        if (PlotTour)
            clf
            iter=iter+1;
            
            hold on
            set(I1,'Name',[TSPType '- 2 opt LS' ])
            title(['Cost ' int2str( BestCost )]);
            scatter(Location(:,1),Location(:,2),'b');
            
            % Add node numbers to the plot
            for l=1:Nb_Nodes
                str = sprintf(' %d',l);
                text(Location(l,1),Location(l,2),str);
            end
            
            x = Location(NewTSP(1:end),1);
            y = Location(NewTSP(1:end),2);
            
            % Plot new Tour
            plot(x,y,'r',x,y,'k.');
            hold off
            pause(1);
        end
        
        
        TSP=NewTSP;
        NewTSP=[];
    else
        
        BestImp=0;
    end
    
    
    
end

% end

