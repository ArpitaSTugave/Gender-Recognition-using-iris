function [accuracy] = CalculateAccuracy(ActualTestGroup,ClassifiedTestGroup)
% calculates accuracy
total = size(ClassifiedTestGroup);
count=0;
incorrect = [];
for i=1:total(1)
    if(strcmp(ActualTestGroup(i),ClassifiedTestGroup(i)))
        count = 1+count; 
    else
        incorrect= [incorrect i];
    end
end
accuracy=count*100/total(1);
end
