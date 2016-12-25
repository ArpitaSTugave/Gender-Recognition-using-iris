%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
% This code copies the template dataset created by irisTemplateCreaterNDIRIS.m into new structure based on gender
% only. Also it creates the 5 sets used for training and testing on
% classifier.
%% clean
close all;
clear all;
clc

%% code
GenderClassifiedTemplateDatasetLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\GenderClassifiedTemplateDataset\Original\';
%trainNumber = 1;   % put every ith images as test and rest as train
CV_set=[1 2 3 4 5];

FolderLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\ImageData\ND_IRIS_Images_V1\';
Gender = {'M' 'F'};
Ethnicity = {'Asian' 'Asian-Middle-Eastern' 'Asian-Southern' 'Black-or-African-American' 'Hispanic' 'Unknown' 'White'};
EyeType = {'left' 'right'};
ImageTypes = {'irisImage' 'polarImage' 'maskedImage'};

for set = CV_set
    newGenderClassifiedTemplateDatasetLocation = strcat(GenderClassifiedTemplateDatasetLocation,'set');
    newGenderClassifiedTemplateDatasetLocation = strcat(newGenderClassifiedTemplateDatasetLocation,num2str(set));
    newGenderClassifiedTemplateDatasetLocation = strcat(newGenderClassifiedTemplateDatasetLocation,'\');
    
    newTrainLocation = strcat(newGenderClassifiedTemplateDatasetLocation,'train\');
    newTestLocation = strcat(newGenderClassifiedTemplateDatasetLocation,'test\');
    
    for genderC = Gender
        gender = cell2mat(genderC);
        %mkdir(FolderLocation,gender);
        FolderLocationG = strcat(FolderLocation,gender);
        FolderLocationG = strcat(FolderLocationG,'\');
        
%         new2TrainLocation = strcat(newTrainLocation,genderC);
%         new2TestLocation = strcat(newTestLocation,genderC);
        
        for ethnicityC = Ethnicity
            ethnicity = cell2mat(ethnicityC);
            %mkdir(FolderLocationG,ethnicity);
            FolderLocationE = strcat(FolderLocationG,ethnicity);
            FolderLocationE = strcat(FolderLocationE,'\');
            for eyeTypeC =EyeType
                eyeType = cell2mat(eyeTypeC);
                %mkdir(FolderLocationE,eyeType);
                FolderLocationT = strcat(FolderLocationE,eyeType);
                FolderLocationT = strcat(FolderLocationT,'\');
                
                FolderLocationII = strcat(FolderLocationT,'irisImage');
                FolderLocationII = strcat(FolderLocationII,'\');
                FolderLocationPI = strcat(FolderLocationT,'polarImage');
                FolderLocationPI = strcat(FolderLocationPI,'\');
                
                counter=0;
                templateNames = dir(char(FolderLocationPI));
                len = length(templateNames);
                for j=1:len
                    if templateNames(j).name(1) == '.'
                        continue;
                    end
                    name = templateNames(j).name;
                    if(strcmp(name(end-6:end-4),'seg'))
                        continue;
                    else
                        counter=counter+1;
                        if counter == set
                            copyfile(strcat(FolderLocationPI,name),char(newTestLocation));
                        else
                            copyfile(strcat(FolderLocationPI,name),char(newTrainLocation));
                        end
                    end
                    if counter==5
                        counter=0;
                    end
                end
            end
        end
    end
end