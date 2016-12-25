%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
% This code deletes all the previously selected images of a subject if count of images is less than 10. And the subject is dumped. 
% NDIRIS_Refined_Image_adder.m tries to refil but some subjects may not fulfil the 10 images requirement. These subjects are dumped.
%% clean
close all;
clear all;
clc

%% code
irisImagesLocation = '\\ece-bprl-file.ad.ufl.edu\research\datafiles\IRIS\ND_IRIS\';
FolderLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\ImageData\ND_IRIS_Images_V1\';
excelFileLocation = [FolderLocation 'Refined_NDIRISComposition.xlsx'];
requiredCount = 10;

Gender = {'M'};
Ethnicity = {'Asian' 'Asian-Middle-Eastern' 'Asian-Southern' 'Black-or-African-American' 'Hispanic' 'Unknown' 'White'};
EyeType = {'left' 'right'};
ImageTypes = {'irisImage' 'polarImage' 'maskedImage'};

[~, text1] = xlsread(strcat(irisImagesLocation,'iris-recording-metadata.csv'));
ImageNames = text1(2:end,1);
eyeType = text1(2:end,3);

[num2, text2  ] = xlsread(strcat(irisImagesLocation,'subject-metadata.csv'));
gender = text2(2:end,4);
subject2 = num2(:,1);
race = text2(2:end,2);

irisImagesLocation = strcat(irisImagesLocation,'data\');

data = xlsread(excelFileLocation);
TotalCount = data(:,5);
ImageIndex2 = (TotalCount~=requiredCount);
for i=1:size(TotalCount)
    if ImageIndex2(i)==1
        ImageIndex1 = strmatch(data(i,1),subject2);
        Gender =gender(ImageIndex1);
        Race =race(ImageIndex1);
        newFolderLocation = strcat(strcat(strcat(strcat(FolderLocation,Gender),'\'),Race),'\');
        leftFolderLocation = strcat(newFolderLocation,'left\irisImage\');
        rightFolderLocation = strcat(newFolderLocation,'right\irisImage\');
        
        sn = ['0' num2str(data(i,1))];
        disp(sn)
        disp(Gender)
        disp(Race)
        
        tiffImagesPath = strcat(leftFolderLocation,sn);
        tiffImagesPath = strcat(tiffImagesPath,'*.tiff');
        images = dir(char(tiffImagesPath));
        len = length(images);
        for j=1:len
            delete(char(strcat(leftFolderLocation,images(j).name)));
        end
        
        tiffImagesPath = strcat(rightFolderLocation,sn);
        tiffImagesPath = strcat(tiffImagesPath,'*.tiff');
        images = dir(char(tiffImagesPath));
        len = length(images);
        for j=1:len
            delete(char(strcat(rightFolderLocation,images(j).name)));
        end
    end
end