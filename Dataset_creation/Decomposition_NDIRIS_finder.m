%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
% This code goes through the newly created NDIRIS-dataset an computes the composition of dataset by gender, ethnicity, etc
%% clean
close all;
clear all;
clc

%% code
irisImagesLocation = '\\ece-bprl-file.ad.ufl.edu\research\datafiles\IRIS\ND_IRIS\';
FolderLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\ImageData\ND_IRIS_Images_V1\';
excelFileLocation = [FolderLocation 'Decomposition_NDIRISComposition.xlsx'];

Gender = {'M' 'F'};
Ethnicity = {'Asian' 'Asian-Middle-Eastern' 'Asian-Southern' 'Black-or-African-American' 'Hispanic' 'Unknown' 'White'};
EyeType = {'left' 'right'};
ImageTypes = {'irisImage' 'polarImage' 'maskedImage'};
GenderCount = [0 0 0 0 0 0 0];
EthnicityCount = [0 0 0 0 0 0 0];
GenderEthnicityCount = zeros(2,7);
i=0;
for genderC = Gender
    i=i+1;
    gender = cell2mat(genderC);
    FolderLocationG = strcat(FolderLocation,gender);
    FolderLocationG = strcat(FolderLocationG,'\');
    j=0;
    for ethnicityC = Ethnicity
        j=j+1;
        ethnicity = cell2mat(ethnicityC);
        FolderLocationE = strcat(FolderLocationG,ethnicity);
        FolderLocationE = strcat(FolderLocationE,'\left\polarImage\*.png');
        images = dir(FolderLocationE);
        len = length(images);
        EthnicityCount(j)= EthnicityCount(j) + len;
        GenderCount(i) = GenderCount(i) + len;
        GenderEthnicityCount(i,j) = GenderEthnicityCount(i,j) +len;
    end
end
data = [GenderCount/10; EthnicityCount/10; GenderEthnicityCount/10];
xlswrite(excelFileLocation,data);