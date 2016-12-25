function [] = FolderStructureCreaterForNDIRIS()

%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
% This code creates the folder structure required by the copyImagesNDIRIS.m file 
% The folder structure is based on subject's gender, ethnicity and iris image type.
%% clean
close all
clear all
clc

%% code
FolderLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\ImageData\ND_IRIS_Images\';
Gender = {'M' 'F'};
Ethnicity = {'Asian' 'Asian-Middle-Eastern' 'Asian-Southern' 'Black-or-African-American' 'Hispanic' 'Unknown' 'White'};
EyeType = {'left' 'right'};
ImageTypes = {'irisImage' 'polarImage' 'maskedImage'};

for genderC = Gender
    gender = cell2mat(genderC);
   mkdir(FolderLocation,gender);
    FolderLocationG = strcat(FolderLocation,gender);
    FolderLocationG = strcat(FolderLocationG,'\');
    for ethnicityC = Ethnicity
        ethnicity = cell2mat(ethnicityC);
        mkdir(FolderLocationG,ethnicity);
        FolderLocationE = strcat(FolderLocationG,ethnicity);
        FolderLocationE = strcat(FolderLocationE,'\');
        for eyeTypeC =EyeType
            eyeType = cell2mat(eyeTypeC);
            mkdir(FolderLocationE,eyeType);
            FolderLocationT = strcat(FolderLocationE,eyeType);
            FolderLocationT = strcat(FolderLocationT,'\');
            for imageTypesC =ImageTypes
                imageTypes = cell2mat(imageTypesC);
                mkdir(FolderLocationT,imageTypes);
            end
        end
    end
end
end