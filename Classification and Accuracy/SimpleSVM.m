%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  This code runs the given classifier on the gven feature extraction technique and gives the accuracy as output.
% This code uses the CalculateAccuracy.m code 
%% cleanup
close all
clear all
clc

%% Run SVM

FeatureMethod = {'CULBPC_slant', 'CULBPC_straight'};
datasetType = {'Original','Masked'};

% Classification Methods = 1-SVM, 2-Decision Tress, 3-Adaboost Ensemble
% 4.Bagged Ensemble classifier 5.KNN
ClassificationMethod =1;

CV_set=[1 2 3 4 5];

output = {FeatureMethod '' '' ''};
colCount = 3;

for datasettype = datasetType
    taccu=0;
    olocation = strcat('\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\GenderClassifiedTemplateDataset\Dataset_CVed\',char(datasettype));
    olocation = strcat(olocation,'\set');

    for set = CV_set
        location = strcat(olocation,num2str(set));
        TestDataL = strcat(location,strcat('\features\',FeatureMethod,'\test',FeatureMethod,'_Features.mat'));
        
        %for fusion
       [dummy val] = size(TestDataL);
        if val>1
            TestData1 = load(char(TestDataL(1)));
            TestData2 = load(char(TestDataL(2)));
            TestData = [TestData1.features TestData2.features];
        else
        TestData = load(char(TestDataL));
        TestData.features = [TestData.features];
        end
        %TestDataULBP = strcat(location,strcat('\features\','ULBP_window50','\test','ULBP_window50','_Features.mat'));
        %TestDataAdd = load(TestDataULBP);
        %TestData.features = [TestData.features TestDataAdd.features];
        
        
        %TestData.features = [TestData.features(:,1421:7100) TestData.features(:,8521:14200) TestData.features(:,15621:21300)];
        
        TrainDataL = strcat(location,strcat('\features\',FeatureMethod,'\train',FeatureMethod,'_Features.mat'));
        
        if val>1
            TrainData1 = load(char(TrainDataL(1)));
            TrainData2 = load(char(TrainDataL(2)));
            TrainData = [TrainData1.features TrainData2.features];
        else
        TrainData = load(char(TrainDataL));
        TrainData.features = [TrainData.features];
        end
        %TrainDataULBP = strcat(location,strcat('\features\','ULBP_window50','\train','ULBP_window50','_Features.mat'));
        %TrainDataAdd = load(TrainDataULBP);
        %TrainData.features = [TrainData.features TrainDataAdd.features];
        
        
        %TrainData.features = [TrainData.features(:,1421:7100) TrainData.features(:,8521:14200) TrainData.features(:,15621:21300)];
        
        %
        
        % <--------- Total-27648   
        %LBP NonOverlap window 10
        %    upper 1/3 - [1:9216]
        %TestData.features = [TestData.features(:,1:9216)];
        
        %   lower 2/3 - [9217:27648]
        %TestData.features = [TestData.features(:,9217:27648)];
        
        %   2nd Disputed Area(10:30)*(210:330) - [14593:17664] and [23809:26880]
        %TestData.features = [TestData.features(:,14593:17664) TestData.features(:,23809:26880)];
        
        % 1st Disputed Area(20:30)*(50:130) - [19713:21760]
        %TestData.features = [TestData.features(:,19713:21760)];
        %------------>
        
        %<------------ 
        % Overlap window 10 of 50%  Total-90880
        %   upper 1/3 without transition area- [1:18176]
        %TestData.features = [TestData.features(:,1:18176)];
        
        %   upper 1/3 with transition area- [1:36352]
        %TestData.features = [TestData.features(:,1:36352)];
        
        %   lower 2/3 without transition area- [36353:90880]
        %TestData.features = [TestData.features(:,36353:90880)];
        
        %   lower 2/3 with transition area- [18177:90880]
        %TestData.features = [TestData.features(:,18177:90880)];
        %--------------------->
        
        %<------------ 
        % ULBP_window 10   Total-6372
        %  upper 1/3 - [1:2124]
        %TestData.features = [TestData.features(:,1:2124)];
        
        %   lower 2/3 - [2125:6372]
        %TestData.features = [TestData.features(:,2125:6372)];
        
        %--------------------->
        
        %<----------------- 
        % ULBP_window 10 with overlap50%    Total-20945
        %   upper 1/3 without transition area-
        %TestData.features = [TestData.features(:,1:4189)];
        
        %   upper 1/3 with transition area-
        %TestData.features = [TestData.features(:,1:8378)];
        
        %   lower 2/3 without transition area- 
        %TestData.features = [TestData.features(:,8379:20945)];
        
        %   lower 2/3 with transition area- 
        %TestData.features = [TestData.features(:,4190:20945)];
               
        %--------------------->
        
        %TestData.features = [TestData.features(:,4609:13824) TestData.features(:,18433:27648)];
        
        % upper 1/3rd for lpq
        % TestData.features = [TestData.features(:,1:1800)];
        % Using only parts of iris lbp bad
        % Upper 1/3rd
        %TestData.features = [TestData.features(:,1:4608) TestData.features(:,13825:18432)];
        % Lower 2/3rd
        %TestData.features = [TestData.features(:,4609:13824) TestData.features(:,18433:27648)];
        % Lower 2/3rd right
        %TestData.features = [TestData.features(:,18433:27648)];
        %Lower 2/3rd left
        %TestData.features = [TestData.features(:,4609:13824)];
        
        
        % Upper 1/3rd for GraB
        % TrainData.features = [TrainData.features(:,721:2160) TrainData.features(:,2881:4320) TrainData.features(:,5041:6480)];
        %Lower 2/3 for GraB
        % TrainData.features = [TrainData.features(:,721:2160) TrainData.features(:,2881:4320) TrainData.features(:,5041:6480)];
        
        % Upper 1/3rd
        %TrainData.features = [TrainData.features(:,1,4608) TrainData.features(:,13825,18432)];
        % Lower 2/3rd
        %TrainData.features = [TrainData.features(:,4609:13824) TrainData.features(:,18433:27648)];
        % Lower 2/3rd right
        %TrainData.features = [TrainData.features(:,18433:27648)];
        %Lower 2/3rd left
        %TrainData.features = [TrainData.features(:,4609:13824)];
        
        ActualTestGroupL = strcat(location,'\testLabel.mat');
        ActualTestGroup = load(ActualTestGroupL);
        
        TrainGroupL = strcat(location,'\trainLabel.mat');
        TrainGroup = load(TrainGroupL);
        
        if(ClassificationMethod==1)
            options = statset('Display','off','MaxIter',50000);

        if val>1
            svmStruct = svmtrain(TrainData,TrainGroup.label,'kernel_function','linear','options',options);
            ClassifiedTestGroup = svmclassify(svmStruct,TestData);
        else
            svmStruct = svmtrain(TrainData.features,TrainGroup.label,'kernel_function','linear','options',options);
            ClassifiedTestGroup = svmclassify(svmStruct,TestData.features);
        end
        
        elseif ClassificationMethod==2
            tree = fitctree(TrainData.features,TrainGroup.label,'Prune','off');
            %view(tree, 'mode','graph');
            ClassifiedTestGroup = predict(tree, TestData.features);
        elseif ClassificationMethod==3
            ens = fitensemble(TrainData.features,TrainGroup.label,'AdaBoostM1',100,'Tree');
            ClassifiedTestGroup = predict(ens, TestData.features);
        elseif ClassificationMethod==4
            ens = fitensemble(TrainData.features,TrainGroup.label,'Bag',10,'Tree','Type','Classification');
            ClassifiedTestGroup = predict(ens, TestData.features);
        elseif ClassificationMethod==5
            knn = fitcknn(TrainData.features,TrainGroup.label,'NumNeighbors',100);
            ClassifiedTestGroup = predict(knn, TestData.features);
        end
        
        cd('\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\SVM\SimpleSVM');
        taccu = taccu + CalculateAccuracy(char(ActualTestGroup.label),char(ClassifiedTestGroup));
    end
    total = taccu/5;
    output(1,colCount) = num2cell(total);
    colCount =colCount+1;
end