%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
% This code applies the mask on the tempate stucture created through
% GenderClassifed Tempate Dataset creator. Also, remeber to copy the
% original dataset as it is the original. The new one is masked.
%% clean
close all;
clear all;
clc

%% code
GenderClassifiedTemplateDatasetLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\GenderClassifiedTemplateDataset\Dataset_CVed\Masked\';
dataType = {'test' 'train'};
Gender = {'M' 'F'};
CV_set=[1 2 3 4 5];

maskIntensity= 255;

for set = CV_set
    newGenderClassifiedTemplateDatasetLocation = strcat(GenderClassifiedTemplateDatasetLocation,'set');
    newGenderClassifiedTemplateDatasetLocation = strcat(newGenderClassifiedTemplateDatasetLocation,num2str(set));
    newGenderClassifiedTemplateDatasetLocation = strcat(newGenderClassifiedTemplateDatasetLocation,'\');
    
    for dataTypeC = dataType
        datatype = cell2mat(dataTypeC);
        %mkdir(FolderLocation,gender);
        FolderLocationG = strcat(newGenderClassifiedTemplateDatasetLocation,datatype);
        FolderLocationG = strcat(FolderLocationG,'\');
               
        templateNames = dir(char(FolderLocationG));
        len = length(templateNames);
        for j=1:len
            if templateNames(j).name(1) == '.' || strcmp(templateNames(j).name,'Thumbs.db')
                continue;
            end
            filename = strcat(FolderLocationG,templateNames(j).name);
            disp(filename);
            z=imread(filename);
            %imshow(z);
            z(20:25,55:125)=maskIntensity;
            z(25:30,45:135)=maskIntensity;
            z(10:15,225:315)=maskIntensity;
            z(15:20,215:325)=maskIntensity;
            z(20:25,205:335)=maskIntensity;
            z(25:30,195:345)=maskIntensity;
            %imshow(z);
            imwrite(z,filename);           
        end
    end
end