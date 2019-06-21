% Update_Population 
function   Population = UpdatePopulation( Population,CurrPopSize,  New_Individual,  Fitness)
try
   
    
    Insereted=false; % if the individual is inserted in the population it is set to true and false otherwise 
% insert the Individual in the population in a non-deacreasing order based on its cost
        for  i = 1: CurrPopSize
            
            if (Fitness < Population{i}(1))
               
                Population=[Population(1:i-1,:) ;{Fitness, New_Individual} ;Population(i:end,:)];               
                Insereted=true;% if the individual is inserted in the population set Insereted to true
                break
            end
            
        end
        
        if(~Insereted) % if Insereted is false add the individual to the end of the list
            Population(end+1,:)={Fitness, New_Individual};          
        end
  
catch ME
    disp('error at Update_Population')
    disp(ME)
end

end
