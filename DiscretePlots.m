data=load('TrainResults.mat');
compareTrain=data.compareTrain4;
k1=1;
k2=1;
for i = 1:length(compareTrain)
        if compareTrain(i,3) == compareTrain(i,2)
            correct(k1,1)=i;
            correct(k1,2)=compareTrain(i,1);
            %correct(k1,3)=compareTrain(i,2);
            k1=k1+1;
        else
            incorrect(k2,1)=i;
            incorrect(k2,2)=compareTrain(i,1);
            %incorrect(k2,3)=compareTrain(i,2);
            k2=k2+1;
        end
end
x = (1:1:1092);
y1 = (correct(:,3))';
figure
plot(x,y1,'k')
title('Combine Plots')

hold on
y2 = (correct(:,2))';
scatter((correct(:,1))',y2,25,[0 1 0])

y3 = (incorrect(:,2))';
scatter((incorrect(:,1))',y3,25,[1 0 0]) 
hold off
