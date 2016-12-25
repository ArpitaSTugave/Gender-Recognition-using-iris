%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
% This code goes through the newly created NDIRIS-dataset and uses the USIT toolkit's wahet.exe to compute iris templates from iris images.
%% clean
close all;
clear all;
clc

%% code
FolderLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\ImageData\ND_IRIS_Images_V1\';
Gender = {'M' 'F'};
Ethnicity = {'Asian' 'Asian-Middle-Eastern' 'Asian-Southern' 'Black-or-African-American' 'Hispanic' 'Unknown' 'White'};
EyeType = {'left' 'right'};
ImageTypes = {'irisImage' 'polarImage' 'maskedImage'};

for genderC = Gender
    gender = cell2mat(genderC);
    %mkdir(FolderLocation,gender);
    FolderLocationG = strcat(FolderLocation,gender);
    FolderLocationG = strcat(FolderLocationG,'\');
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
             
            command = [FolderLocation '"wahet" -i ' FolderLocationII '*.tiff -o ?1.png -s 360 30 -q -sr ?1_seg.png'];
            cd(FolderLocationPI);
            delete('*.png');
            system(command);             
        end
    end
end