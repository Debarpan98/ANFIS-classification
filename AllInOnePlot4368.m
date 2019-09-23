data=load('TrainResults.mat');
d=data.compareTrainAll;
k=1;
for i=10:10:130
    for j=1:length(d)
        if d(j,2)==i
            for l=1:6
                temp(k,l)=d(j,l);
            end
            temp(k,7)=k;
            k=k+1;
        end
    end
end
k=1;
k1=1;
k2=1;
for i=1:length(temp)
    a(i,1)=temp(i,7);
    a(i,2)=temp(i,2);
    if temp(i,3) == temp(i,2)
        correct(k1,1)=temp(i,7);
        correct(k1,2)=temp(i,1);
        correct(k1,3)=temp(i,2);
        k1=k1+1;    
    else
        incorrect(k2,1)=temp(i,7);
        incorrect(k2,2)=temp(i,1);
        incorrect(k2,3)=temp(i,2);
        k2=k2+1;
    end
end
x = (a(:,1))';
y = (a(:,2))';
figure
plot(x,y,'k')
title('Combine Plots')

hold on
scatter((correct(:,1))',(correct(:,2))',25,[0 1 0])

scatter((incorrect(:,1))',(incorrect(:,2))',25,[1 0 0]) 
hold off
