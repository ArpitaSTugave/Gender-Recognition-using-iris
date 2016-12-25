%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  Extracts the feature set from templates as per given feature extraction method
%% clean up
clear all
close all
clc

%% algorithm to implement Local Binary Pattern
%FeatureMethod = {'lpq','LBPwindow2','lbp_sushant','lpq','wld','grab','LBPwindow50'};
FeatureMethod = {'CULBPC_window50'};

datasetType= {'Masked' 'Original'};
dataType = {'test' 'train'};
CV_set=[1 2 3 4 5];

i=0;
for featureMethod = FeatureMethod
    i =i+1;
    fh = str2func(char(featureMethod));
    
    for datasettype = datasetType
        templateLocation =strcat('\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\GenderClassifiedTemplateDataset\Dataset_CVed\',datasettype);
        templateLocation =strcat(templateLocation,'\');
        
        for set = CV_set
            newGenderClassifiedTemplateDatasetLocation = strcat(templateLocation,'set');
            newGenderClassifiedTemplateDatasetLocation = strcat(newGenderClassifiedTemplateDatasetLocation,num2str(set));
            newGenderClassifiedTemplateDatasetLocation = strcat(newGenderClassifiedTemplateDatasetLocation,'\');
            
            for dataTypeC = dataType
                datatype = cell2mat(dataTypeC);
                
                FolderLocationG = strcat(newGenderClassifiedTemplateDatasetLocation,datatype);
                FolderLocationG = strcat(FolderLocationG,'\');
                
                templateImages = dir(char(strcat(FolderLocationG,'*.png')));
                len = length(templateImages);
                features=[];
                for i = 1:len
                    if templateImages(i).name(1) == '.'
                        continue;
                    end
                    templateImage = imread(char(strcat(FolderLocationG ,templateImages(i).name)));
                    
                    [lbhist] = fh(templateImage);
                    features = [features ; lbhist];
                end
                fileName = char(strcat(dataTypeC,strcat(featureMethod,'_Features')));
                savefile = [fileName];
                [stat,mess]=fileattrib(savefile);
                
                FeatureFolder = char(strcat(newGenderClassifiedTemplateDatasetLocation,'features\'));
                mkdir(FeatureFolder,char(featureMethod));
                FeatureFolder = char(strcat(FeatureFolder,char(featureMethod)));
                FeatureFolder = char(strcat(FeatureFolder,'\'));
                
                save(char(strcat(FeatureFolder,savefile)),'features');
            end
        end
    end
end