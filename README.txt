The Code is written by- Arpita Tugave and Kedar Amrolkar, University of Florida, Gainesville.

I] The folder Dataset_creation contains codes which help refine the ND-IRIS dataset.

The normal flow would be:
1) FolderStructureCreaterForNDIRIS -> creates the new dataset folder structure.
2) copyImagesNDIRIS -> copies appropriate iris images with user assistance.
3) NDIRIS_Images_Refiner -> Removes improper images selected in previous step(2) with user assistance.
4) NDIRIS_Refined_Image_adder -> Tries to refill the deleted images inthe previous step(3) with user assistance.
5) NDIRIS_LessThan5_remover -> Removes the images of subjects which fail to refill to 10 inprev step(4).
6) irisTemplateCreaterNDIRIS -> Extracts the iris template from raw iris images using WAHET.
7) NDIRIS_Template_Refiner -> Removes improper templates selected previously with user assistance.
8) Decomposition_NDIRIS_finder -> Just computes the composition of new dataset(V1) according to gender, ethnicity.
9) GenderClassifiedTemplateDatasetCreator -> Copies the new dataset into gender classified format.
10) TemplateMaskApplier -> Applies predefined mask on all the templates copied via step(9). Thus 'masked' dataset is created.
    For 'Original' dataset, do not execute 10.

II] The folder FeatueExtractionTechniques contains code for feature extraction techniques

The codes for various techniques like lpq, wld, ulbp, lbp, clbp, rlbp, grab are present with generic and specific objectives.
The names are self-explanatory.
The file GenericFeatureExtractorCode contains the code which extracts the features from templates using the above files.


III] The folder ClassificationAndAccuracy contains code for calculating the accuracy using a given feature  extraction method and given classifier.
It contains two files-
1) SimpleSVM - This code runs the given classifier on the gven feature extraction technique and gives the accuracy as output.
2) CalculatesAccuracy 