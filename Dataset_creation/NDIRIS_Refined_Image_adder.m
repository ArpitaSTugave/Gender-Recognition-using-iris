%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
% This code tries to refil the images deleted through NDIRIS_images_Refiner.m with another images of the subject through user assistance
% User can accept/reject a image so that the image is selected and the counter is reset for the subject to indicate 10 images.
%% clean
close all;
clear all;
clc

%% code
irisImagesLocation = '\\ece-bprl-file.ad.ufl.edu\research\datafiles\IRIS\ND_IRIS\';
FolderLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\ImageData\ND_IRIS_Images_V1\';
excelFileLocation = [FolderLocation 'Refined_NDIRISComposition.xlsx'];
thresholdCount = 9;

Gender = {'M'};
Ethnicity = {'Asian' 'Asian-Middle-Eastern' 'Asian-Southern' 'Black-or-African-American' 'Hispanic' 'Unknown' 'White'};maskIntensity
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
ImageIndex2 = (TotalCount==thresholdCount);
for i=1:size(TotalCount)
    if ImageIndex2(i)==1
        ImageIndex1 = strmatch(data(i,1),subject2);
        Gender =gender(ImageIndex1);
        Race =race(ImageIndex1);
        newFolderLocation = strcat(strcat(strcat(strcat(FolderLocation,Gender),'\'),Race),'\');
        
        sn = ['0' num2str(data(i,1))];
        disp(sn)
        disp(Gender)
        disp(Race)
        path = [irisImagesLocation sn '\'];
        tiffImagesPath = strcat(path,'*.tiff');
        images = dir(tiffImagesPath);
        len = length(images);
        disp(len)
        countLeft=data(i,3);
        countRight=data(i,4);
        j=len;
        
        while (countLeft<5 || countRight < 5) && j>=1
            
            filename = images(j).name;
            sourceLocation = strcat(path ,filename);
            ImageIndex = strmatch(filename,ImageNames);
            EyeType =eyeType(ImageIndex);
            new2FolderLocation = char(strcat(strcat(newFolderLocation,EyeType),'\irisImage\'));
            ExpectedFile = char(strcat(new2FolderLocation,filename));
            j=j-1;
            
            if ((strcmp(EyeType,'left') && countLeft<5) ...
                    || (strcmp(EyeType,'right') && countRight<5)) && ~exist(ExpectedFile,'file')
                disp(EyeType)
                imshow(sourceLocation);
                a = input('Accept this image (y/n)? ','s');
                if  strcmpi(a,'y')
                    copyfile(sourceLocation,new2FolderLocation);
                    if strcmp(EyeType,'left')
                        data(i,3) =data(i,3)+1;
                        countLeft = countLeft+1;
                    else
                        data(i,4) =data(i,4)+1;
                        countRight=countRight+1;
                    end
                    data(i,5) =data(i,5)+1;
                else
                    continue;
                end
            end          
        end
    end
end
xlswrite(excelFileLocation,data);