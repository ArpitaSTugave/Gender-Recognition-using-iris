%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
% This code further refines the images selected through copyImagesNDIRIS.m file 
% User can reject a image so that the image is deleted and a counter is set for the subject to indicate less than 10 images.
%% clean
close all;
clear all;
clc

%% code
FolderLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\ImageData\ND_IRIS_Images_V1\';
excelFileLocation = [FolderLocation 'Refined_NDIRISComposition.xlsx'];
Gender = {'M' 'F'};
Ethnicity = {'Asian' 'Asian-Middle-Eastern' 'Asian-Southern' 'Black-or-African-American' 'Hispanic' 'Unknown' 'White'};
EyeType = {'left' 'right'};
ImageTypes = {'irisImage' 'polarImage' 'maskedImage'};
data = xlsread(excelFileLocation);

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
            
            tiffImagesPath = strcat(FolderLocationII,'*.tiff');
            images = dir(tiffImagesPath);
            len = length(images);
            countLeft=5;
            countRight=5;
    
            for j=1:len
                filename = images(j).name;
                sourceImage = strcat(FolderLocationII ,filename);
                imshow(sourceImage);
                a = input('Accept this image (y/n)? ','s');
                if  strcmpi(a,'y')   
                    continue;                  
                else
                    subjectName = filename(1:5);
                    sn=str2num(subjectName);
                    ImageIndex = strmatch(sn,data(:,1));
                    if strcmp(eyeTypeC,'left')
                        data(ImageIndex,3) =data(ImageIndex,3)-1;
                    else
                        data(ImageIndex,4) =data(ImageIndex,4)-1;
                    end
                    data(ImageIndex,5) =data(ImageIndex,5)-1;
                    xlswrite(excelFileLocation,data);
                    delete(sourceImage);
                end  
                disp(filename);
            end
        end
    end
end