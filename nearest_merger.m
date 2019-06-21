% TSP nearest merger procedure
%    Shirley Chen, 07 Oct,2018

%%%%%%%%% step 1: initialize all the variables
Location=[21 2; 12 43;10 5; 32 12; 14 21; 32 23; 24 27;35 40;30 43;32 10;35 36; 32 40;10 24;40 15;10 15];%坐标
dis=pdist2(Location,Location);%距离矩阵
nb_nodes=size(dis,1); %点的数量

subtours=cell(nb_nodes,1); %生成一个元胞数组放所有subtour
for i=1:nb_nodes %填充数组
    subtours(i)={i};
end
nb_subtours=nb_nodes; %subtour的数量。用来设置循环条件。

subtour_dis=dis;%把对角线的0换成无限大，这样计算两个最近点的时候不会受到自身干扰
for s1=1:nb_subtours
    subtour_dis(s1,s1)=inf;
end

%%%%%%%% step 2: select the two closest subtours
while nb_subtours~=1
    [min_dis,index]=min(subtour_dis);%每个subtour与其他subtour的最短距离
    [min_cost,s1]=min(min_dis);%所有subtour的最短距离
    s2=index(s1);%得到两个最近的subtour的指数, s1,s2
    %这一步中无论是点还是subtour都能够找到最近的subtour，因为在后面会将真正的subtour与其他点和subtour的距离合成一个维度
    
    %%%%%%%%% step3: merge the selected subtours
    s1_size=size(subtours{s1},2);
    s2_size=size(subtours{s2},2); %得到选定的subtour的维度
    
    %根据维度分别讨论：1）都是一个点 2）一个点一个subtour 3)都是subtour
    if (s1_size==1&&s2_size==1) %都是一个点
        newtour=[subtours{s1},subtours{s2},subtours{s1}];
    else
        if (s1_size==1&&s2_size~=1)||(s1_size~=1&&s2_size==1) %一个点一个tour
            if s2_size>1 %用s2代表点，s1代表tour
                s2_temp=s2;
                s2=s1;
                s1=s2_temp;
                
                s2_temp_size=s2_size;
                s2_size=s1_size;
                s1_size=s2_temp_size;
            end
            %用最小成本将s2合并到s1中
            min_cost=inf;
            for i=1:s1_size-1
                cost=dis(subtours{s1}(i),subtours{s2})+dis(subtours{s2},subtours{s1}(i+1))-dis(subtours{s1}(i),subtours{s1}(i+1));
                %每一个subtour都包含首尾，所以需要减1
                %这里要用dis而不是subtour_dis，因为subtour_dis的维度在后面会不断缩小，每一个subtour都代表一个点，所以无法计算subtour内部的距离关系
                if cost<min_cost
                    min_cost=cost;
                    position=i;
                end
            end
            
            newtour=[subtours{s1}(1:position),subtours{s2},subtours{s1}(position+1:end)];
            
        else %两个都是subtour
            min_cost=inf;
            for i=1:s1_size-1
                for j=1:s2_size-1
                    cost1=dis(subtours{s1}(i),subtours{s2}(j))+dis(subtours{s1}(i+1),subtours{s2}(j+1))-dis(subtours{s1}(i),subtours{s1}(i+1))-dis(subtours{s2}(j),subtours{s2}(j+1));
                 %有一种要reverse
                    cost2=dis(subtours{s1}(i),subtours{s2}(j+1))+dis(subtours{s1}(i+1),subtours{s2}(j))-dis(subtours{s1}(i),subtours{s1}(i+1))-dis(subtours{s2}(j),subtours{s2}(j+1));
                    [Min,index]=min([cost1,cost2]);
                    if Min<min_cost
                        min_cost=Min;
                        position_i=i;
                        position_j=j;
                    end
                end
            end
            
            if index==1
                newtour=[subtours{s1}(1:position_i),fliplr(subtours{s2}(1:position_j)),fliplr(subtours{s2}(position_j+1:end-1)),subtours{s1}(position_i+1:end)];
                %注意，每一个subtour都包含首尾，所以在中间的subtour要end-1，而末尾的则保留起点
            else
               newtour=[subtours{s1}(1:position_i),subtours{s2}(position_j+1:end-1),subtours{s2}(1:position_j),subtours{s1}(position_i+1:end)]; 
            end
        end
    end
    
    %%%%%%% step4: update everything after each merge
    if nb_subtours>2 %由于代码设计的原因，当还剩两个subtour的时候就应该跳出循环了，否则报错
            if s1>s2 %注意指数的大小会影响删除的顺序，若先删除小的，大的指数将不会指向原来的数据
                 subtours(s1,:)=[];
                 subtours(s2,:)=[];
                 subtour_dis(s1,:)=[];
                 subtour_dis(s2,:)=[];
                 subtour_dis(:,s1)=[];
                 subtour_dis(:,s2)=[];
            else
                subtours(s2,:)=[];
                subtours(s1,:)=[];
                subtour_dis(s2,:)=[];
                subtour_dis(s1,:)=[];
                subtour_dis(:,s2)=[];
                subtour_dis(:,s1)=[];
            end
                     
    
    subtours(end+1)={newtour}; %把新的subtour放在最后
    nb_subtours=nb_subtours-1;
    % 更新subtour距离矩阵
    % 这里要留意，subtour矩阵每一步都更新，用于计算每个subtour的距离，找出最近的两个subtour，而距离矩阵一直保持原样，用于计算合并成本，涉及到更小的粒度
    r=Inf(1,nb_subtours-1); %生成一行无限大的数 （后面会填充，所以随便拟定一个值都可以）
    subtour_dis=[subtour_dis;r]; %把这一行加在矩阵后面
    c=Inf(nb_subtours,1); %生成一列无限大的数，注意已经加了一行
    subtour_dis=[subtour_dis,c]; %把这一列加在矩阵右边
    % 开始计算实际距离填充subtour_dis矩阵
    
    s1=nb_subtours;
    for s2=1:nb_subtours-1
        Min=min(dis(subtours{s1},subtours{s2}));
        if size(Min,2)>1||size(Min,1)>1
            Min=min(Min);
        end
        subtour_dis(s1,s2)=Min;
        subtour_dis(s2,s1)=Min;
    end
    
    
    else
        subtours=newtour; %最后subtours中还剩两个subtour，但完整的tour已经在newtour中形成了，所以直接赋值，注意这里数据类型从cell变成了array
        break
    end
    
    

    
end

%%%%%%% step5: calculate the total cost
total_cost=0;
for i=1:nb_nodes
    total_cost=total_cost+dis(subtours(i),subtours(i+1));
end

    
    
   
    

            
               
                        
                 
            