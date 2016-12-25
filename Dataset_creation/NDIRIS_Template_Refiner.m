%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
% This code goes through the newly created tempate datset by irisTemplateCreaterNDIRIS.m and then refines it with user assistance.
% User can accept/reject a template based on template clarity, obstrcution,etc 
%% clean
close all;
clear all;
clc

%% code
irisImagesLocation = '\\ece-bprl-file.ad.ufl.edu\research\datafiles\IRIS\ND_IRIS\';
FolderLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\ImageData\ND_IRIS_Images_V1\';

masekCodeLocation = '\\ece-bprl-file.ad.ufl.edu\users$\arpita123\Documents\Arpita\iriscode\';
excelFileLocation = [FolderLocation 'Refined_NDIRISComposition.xlsx'];
Gender = {'M'};
Ethnicity = {'Asian' 'Asian-Middle-Eastern' 'Asian-Southern' 'Black-or-African-American' 'Hispanic' 'Unknown' 'White'};
EyeType = {'left' 'right'};
ImageTypes = {'irisImage' 'polarImage' 'maskedImage'};
data = xlsread(excelFileLocation);

figure;
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
            
            FolderLocationP = strcat(FolderLocationT,'polarImage');
            FolderLocationP = strcat(FolderLocationP,'\');
            
            tiffImagesPath = strcat(FolderLocationP,'*.png');
            images = dir(tiffImagesPath);
            len = length(images);
            for j=1:2:len-1
                tfilename = images(j).name;
                templateImage = strcat(FolderLocationP ,tfilename);
                subplot(1,2,1);
                imshow(templateImage);
                rectangle('Position',[45 20 90 10],'EdgeColor','r');
                rectangle('Position',[215 10 110 20],'EdgeColor','r');
                rectangle('Position',[200 20 140 10],'EdgeColor','r');
                
                srfilename = images(j+1).name;
                srImage = strcat(FolderLocationP ,srfilename);
                subplot(1,2,2);
                imshow(srImage);
                
                a = input('Do what with this template (y-Accept /Any-delete)? ','s');
                if  strcmpi(a,'y')   
                    continue;  
                else
                    subjectName = tfilename(1:5);
                    sn=str2num(subjectName);
                    ImageIndex = strmyatch(sn,data(:,1));
                    if strcmp(eyeTypeC,'left')
                        data(ImageIndex,3) =data(ImageIndex,3)-1;
                    else
                        data(ImageIndex,4) =data(ImageIndex,4)-1;
                    end
                    data(ImageIndex,5) =data(ImageIndex,5)-1;
                    xlswrite(excelFileLocation,data);
                    delete(templateImage);
                    delete(srImage);
                    tfilename(end-2:end)=[];
                    delete(strcat(strcat(FolderLocationII,tfilename),'tiff'));
                end  
                disp(srImage);
            end
        end
    end
end