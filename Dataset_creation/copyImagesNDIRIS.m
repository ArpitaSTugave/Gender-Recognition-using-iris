%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
% This code iterates through the ND_Iris Original Image Dataset and then with user assistance selects 5 left and 5 right Iris images of a subject. 
% The user can accept/ reject an iris image based on factors like clarity, illumination, focus, obstruction, etc. 
% The resultant dataset puts a subject images in an appropriate folder depending on subject's gender and ethnicity.
% Also, the subject's 10 images are used only if 5 left and 5 right iris images are selected, else subject is dumped.
% Folder structure created by FolderStructureCreaterForNDIRIS.m is needed before.

%% clean
close all
clear all
clc

%% code

InitialSubjectCounter =1;
FinalSubjectCounter =360;

numberOfImages = 5;
irisImagesLocation = '\\ece-bprl-file.ad.ufl.edu\research\datafiles\IRIS\ND_IRIS\';
finalPath = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\ImageData\ND_IRIS_Images\';
excelCompositionFilename = 'NDIRISComposition.xlsx';

[~, text1] = xlsread(strcat(irisImagesLocation,'iris-recording-metadata.csv'));
ImageNames = text1(2:end,1);
eyeType = text1(2:end,3);

[num2, text2  ] = xlsread(strcat(irisImagesLocation,'subject-metadata.csv'));
gender = text2(2:end,4);
subject2 = num2(:,1);
race = text2(2:end,2);

irisImagesLocation = strcat(irisImagesLocation,'data\');
subjectFolders = dir(irisImagesLocation);
len = length(subjectFolders);
figure;
for i = InitialSubjectCounter:FinalSubjectCounter
    if subjectFolders(i).name(1) == '.'
        continue;
    end
    flagr = 0;
    flagl = 0;
    imageFileNameLeft = {};
    imageFileNameRight = {};
    ModifiedFinalPathRight = [];
    ModifiedFinalPathLeft = [];
    subjectName = subjectFolders(i).name;
    sn=str2num(subjectName);
    ImageIndex = strmatch(sn,subject2);
    Gender =gender(ImageIndex);
    Race =race(ImageIndex);
    currentFinalPath = strcat(finalPath,Gender);
    currentFinalPath = strcat(currentFinalPath,'\');
    currentFinalPath = strcat(currentFinalPath,Race);
    currentFinalPath = strcat(currentFinalPath,'\');
    ModifiedFinalPathLeft = strcat(currentFinalPath,'left\irisImage\');
    ModifiedFinalPathRight = strcat(currentFinalPath,'right\irisImage\');
    
    FolderLocation = strcat(irisImagesLocation ,subjectName);
    tiffImagesPath = strcat(FolderLocation,'\');
    tiffImagesPath = strcat(tiffImagesPath,'*.tiff');
    images = dir(tiffImagesPath);
    len2 = length(images);
    countLeft=1;
    countRight=1;
    disp(i);
    disp(Gender);
    disp(Race);
    if(len2 < 25)
        disp('Warning- Less than 25 images in this subject set\n');
    end
    fprintf('Total images in this subject set: %d\n',len2);
    
    for j=1:len2
        filename = images(j).name;
        sourceLocation = strcat(FolderLocation ,'\');
        sourceLocation = strcat(sourceLocation ,filename);
        ImageIndex = strmatch(filename,ImageNames);
        EyeType =eyeType(ImageIndex);
        sl = size(imageFileNameLeft);
        sr = size(imageFileNameRight);
        ss = size(sourceLocation);

          
        if(countLeft >5 && countRight>5)
            break;
        elseif(strcmp(EyeType,'left'))
            if(countLeft >numberOfImages)
                continue;
            else
                imshow(sourceLocation);
                a = input('Accept this image (y/n)? ','s');
                if  strcmpi(a,'y')                
                    imageFileNameLeft{countLeft} = sourceLocation;
                    countLeft = countLeft +1;
                else
                    continue;
                end
            end
        else
            if(countRight >numberOfImages)
                continue;
            else
                imshow(sourceLocation);
                a = input('Accept this image (y/n)? ','s');
                if strcmpi(a,'y')                   
                    imageFileNameRight{countRight} = sourceLocation;
                    countRight = countRight +1;
                else
                    continue;
                end
            end
        end   
    end
    A = {subjectName len2 num2str(countLeft==6 && countRight==6) countLeft-1 countRight-1 countLeft+countRight-2};
    xlsRange = ['A' num2str(i) ':' 'F' num2str(i)];
    xlswrite(strcat(finalPath,excelCompositionFilename),A,'Sheet1',xlsRange);
    if(countLeft <6 || countRight<6)
        disp('Rejected');
    else
        disp('Accepted');
        for ll =1:5
            copyfile(imageFileNameLeft{ll},char(ModifiedFinalPathLeft));
            copyfile(imageFileNameRight{ll},char(ModifiedFinalPathRight));
        end
    end
end