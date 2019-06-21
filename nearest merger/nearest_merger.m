% TSP nearest merger procedure
%    Shirley Chen, 07 Oct,2018

%%%%%%%%% step 1: initialize all the variables
Location=[21 2; 12 43;10 5; 32 12; 14 21; 32 23; 24 27;35 40;30 43;32 10;35 36; 32 40;10 24;40 15;10 15];%����
dis=pdist2(Location,Location);%�������
nb_nodes=size(dis,1); %�������

subtours=cell(nb_nodes,1); %����һ��Ԫ�����������subtour
for i=1:nb_nodes %�������
    subtours(i)={i};
end
nb_subtours=nb_nodes; %subtour����������������ѭ��������

subtour_dis=dis;%�ѶԽ��ߵ�0�������޴�������������������ʱ�򲻻��ܵ��������
for s1=1:nb_subtours
    subtour_dis(s1,s1)=inf;
end

%%%%%%%% step 2: select the two closest subtours
while nb_subtours~=1
    [min_dis,index]=min(subtour_dis);%ÿ��subtour������subtour����̾���
    [min_cost,s1]=min(min_dis);%����subtour����̾���
    s2=index(s1);%�õ����������subtour��ָ��, s1,s2
    %��һ���������ǵ㻹��subtour���ܹ��ҵ������subtour����Ϊ�ں���Ὣ������subtour���������subtour�ľ���ϳ�һ��ά��
    
    %%%%%%%%% step3: merge the selected subtours
    s1_size=size(subtours{s1},2);
    s2_size=size(subtours{s2},2); %�õ�ѡ����subtour��ά��
    
    %����ά�ȷֱ����ۣ�1������һ���� 2��һ����һ��subtour 3)����subtour
    if (s1_size==1&&s2_size==1) %����һ����
        newtour=[subtours{s1},subtours{s2},subtours{s1}];
    else
        if (s1_size==1&&s2_size~=1)||(s1_size~=1&&s2_size==1) %һ����һ��tour
            if s2_size>1 %��s2����㣬s1����tour
                s2_temp=s2;
                s2=s1;
                s1=s2_temp;
                
                s2_temp_size=s2_size;
                s2_size=s1_size;
                s1_size=s2_temp_size;
            end
            %����С�ɱ���s2�ϲ���s1��
            min_cost=inf;
            for i=1:s1_size-1
                cost=dis(subtours{s1}(i),subtours{s2})+dis(subtours{s2},subtours{s1}(i+1))-dis(subtours{s1}(i),subtours{s1}(i+1));
                %ÿһ��subtour��������β��������Ҫ��1
                %����Ҫ��dis������subtour_dis����Ϊsubtour_dis��ά���ں���᲻����С��ÿһ��subtour������һ���㣬�����޷�����subtour�ڲ��ľ����ϵ
                if cost<min_cost
                    min_cost=cost;
                    position=i;
                end
            end
            
            newtour=[subtours{s1}(1:position),subtours{s2},subtours{s1}(position+1:end)];
            
        else %��������subtour
            min_cost=inf;
            for i=1:s1_size-1
                for j=1:s2_size-1
                    cost1=dis(subtours{s1}(i),subtours{s2}(j))+dis(subtours{s1}(i+1),subtours{s2}(j+1))-dis(subtours{s1}(i),subtours{s1}(i+1))-dis(subtours{s2}(j),subtours{s2}(j+1));
                 %��һ��Ҫreverse
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
                %ע�⣬ÿһ��subtour��������β���������м��subtourҪend-1����ĩβ���������
            else
               newtour=[subtours{s1}(1:position_i),subtours{s2}(position_j+1:end-1),subtours{s2}(1:position_j),subtours{s1}(position_i+1:end)]; 
            end
        end
    end
    
    %%%%%%% step4: update everything after each merge
    if nb_subtours>2 %���ڴ�����Ƶ�ԭ�򣬵���ʣ����subtour��ʱ���Ӧ������ѭ���ˣ����򱨴�
            if s1>s2 %ע��ָ���Ĵ�С��Ӱ��ɾ����˳������ɾ��С�ģ����ָ��������ָ��ԭ��������
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
                     
    
    subtours(end+1)={newtour}; %���µ�subtour�������
    nb_subtours=nb_subtours-1;
    % ����subtour�������
    % ����Ҫ���⣬subtour����ÿһ�������£����ڼ���ÿ��subtour�ľ��룬�ҳ����������subtour�����������һֱ����ԭ�������ڼ���ϲ��ɱ����漰����С������
    r=Inf(1,nb_subtours-1); %����һ�����޴���� ���������䣬��������ⶨһ��ֵ�����ԣ�
    subtour_dis=[subtour_dis;r]; %����һ�м��ھ������
    c=Inf(nb_subtours,1); %����һ�����޴������ע���Ѿ�����һ��
    subtour_dis=[subtour_dis,c]; %����һ�м��ھ����ұ�
    % ��ʼ����ʵ�ʾ������subtour_dis����
    
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
        subtours=newtour; %���subtours�л�ʣ����subtour����������tour�Ѿ���newtour���γ��ˣ�����ֱ�Ӹ�ֵ��ע�������������ʹ�cell�����array
        break
    end
    
    

    
end

%%%%%%% step5: calculate the total cost
total_cost=0;
for i=1:nb_nodes
    total_cost=total_cost+dis(subtours(i),subtours(i+1));
end

    
    
   
    

            
               
                        
                 
            