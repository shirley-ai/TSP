function [ Best_TSP ,BestCost] = VNS_TSP(Location,TSP,BestCost,TSPSize,Dis,graphic)

%Cost
try
%     BestImp=-2;
    
    Nb_NoImp=0;
    Cost=BestCost;
    iter=0;
    Improvement_in_Cost=Inf;
%     node1=-1;
%     node2=-1;
%     node3=-1;
    Neighbor_order=[ 1 2 3 4 5];
    Neighbor_Str=1;
    Shaking=true;
    stop=false;
    while( stop ~=true )
        %     while(BestImp<0 )
        iter=iter+1;
        
        switch Neighbor_order(Neighbor_Str)
            case 1
                [node1,node2,Improvement_in_Cost]=Two_Opt(TSP,Dis);
            case 2
                [node1,node2,node3,Improvement_in_Cost,Three_Opt_Type]=OR_Opt(TSP,Dis,1);
            case 3
                [node1,node2,node3,Improvement_in_Cost,Three_Opt_Type]=OR_Opt(TSP,Dis,2);
            case 4
                [node1,node2,node3,Improvement_in_Cost,Three_Opt_Type]=OR_Opt(TSP,Dis,3);
                
            case 5
                [node1,node2,node3,Improvement_in_Cost,Three_Opt_Type]= Three_Opt(TSP,Dis);
                
        end
        BestImp=round(Improvement_in_Cost,3);
        
        if(BestImp<0)
            
            NewTSP=zeros(size(TSP,1),size(TSP,2));
            
            Cost=BestCost+Improvement_in_Cost;
            BestCost=Cost;
            
            %%perform move
            if(Neighbor_order(Neighbor_Str)==1)% perform 2opt
                
                
                NewTSP=[TSP(1:node1) fliplr(TSP(node1+1:node2)) TSP(node2+1:end) ];
            else% perform 3-opt & Oropt
               [BestCost, NewTSP] =  Perform_3optMove(TSP,TSPSize, Dis,node1,node2,node3,Three_Opt_Type);
                
            end
            TSP=NewTSP;
            Best_TSP=TSP;
            
            if (graphic)
                clf
                hold on
                title(['Cost ' int2str( BestCost ) ' NS '  int2str( Neighbor_Str ) ])
                scatter(Location(:,1),Location(:,2),'b');
                x = Location(TSP(1:end),1);
                y = Location(TSP(1:end),2);
                % Add node numbers to the plot
                for l=1:TSPSize-1
                    str = sprintf(' %d',l);
                    text(Location(l,1),Location(l,2),str);
                end
                % Plot new Tour
                plot(x,y,'r',x,y,'k.');
                hold off
                pause(1);
            end
            NewTSP=[];
            
            Neighbor_Str=1;
            Nb_NoImp=0;
            
        else % no improvement found
            
            Nb_NoImp=Nb_NoImp+1;
            if(Nb_NoImp>=6)
                %                 BestImp=0;
                stop=true;
            else
                
                if(Neighbor_Str>=5)
                    Neighbor_Str=1;
                    %                     BestImp=-2;
                    stop=false;
                else
                    Neighbor_Str=Neighbor_Str+1;
                    %                     BestImp=-2;
                    stop=false;
                end
                
                % shake: generate a random neighbor of the current solution
                % given the current Neighborhood Structure
                if(Shaking==true)
                    [Cost, TSP ] = Shaking_procedure(TSP,Cost,TSPSize,Dis,Neighbor_order(Neighbor_Str)) ;
                    % should I check the cost of the random neighbor with the
                    % cost of the Best SOLUTION
                    if( BestCost>Cost)
                        BestCost=Cost;
                        Best_TSP=TSP;
                        
                        if (graphic)
                            clf
                            hold on
                            title(['Cost ' int2str( BestCost ) ' NS '  int2str( Neighbor_Str ) ])
                            scatter(Location(:,1),Location(:,2),'b');
                            x = Location(TSP(1:end),1);
                            y = Location(TSP(1:end),2);
                            % Add node numbers to the plot
                            for l=1:TSPSize-1
                                str = sprintf(' %d',l);
                                text(Location(l,1),Location(l,2),str);
                            end
                            % Plot new Tour
                            plot(x,y,'r',x,y,'k.');
                            hold off
                            pause(1);
                        end
                        
                        Nb_NoImp=0;
                    end
                end
                
                
            end
            
        end
        
    end
catch ME
    display(ME)
    display(ME.stack(1))
    display(ME.stack(1).line)
end
end
