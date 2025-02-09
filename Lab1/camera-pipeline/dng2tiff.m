% dng2tiff reads dng file into matlab as linear RGB.

% Status = raw2dng(rawPath) takes as input a dng image, performs steps 1-4
% of the pipeline from Karaimer & Brown code, and saves a tiff image.
%
% Modified from the toolbox released by Karaimer & Brown:
%
% Karaimer, Hakki Can, and Michael S. Brown. ECCV 2016
% "A software platform for manipulating the camera imaging pipeline."
%
% The mac version of dng_validate was written by Ben Singer from Princeton.
%
% Derya Akkaynak 2019 | deryaa@alum.mit.edu

function dng2tiff(dngPath, tiffSavePath)

% This is the stage where only linear operations are preformed on the
% image. From this stage on photofinishing begins!
stage = 4;

% This is the folder where the output .tiff image will be saved.
saveFolder = fullfile('.','dngOneExeSDK');

% These are the settings to ensure linearity.
writeTextFile(saveFolder,'wbAndGainSettings',[1 0 0 0]);
writeTextFile(saveFolder,'rwSettings',0);
writeTextFile(saveFolder,'stageSettings',stage);
writeTextFile(saveFolder,'cam_settings',0);
writeTextFile(saveFolder,'lastStage',stage);

% List of all .dng files within the folder.
dngFiles = dir(fullfile(dngPath, '*.dng'));


for k=1:length(dngFiles)
    thisFile = dngFiles(k).name;
    shortName = thisFile(1:end-4);
    outputFilePath = fullfile(tiffSavePath,[shortName,'.tif']);

    dngFile = dngFiles(k).name

    % This is the command to convert the .dng file to .tif file and save to
    % the specified folder.
    status = system(join([fullfile('.','dngOneExeSDK','dng_validate.exe -16 -3 ')  outputFilePath ' ' [dngPath,'\', dngFile]]));

    if status~=0
        fprintf(2,['dng2tiff: There was a problem processing the DNG image ',dngPath,'\n']);
    end
    
    % To do: copy the metadata to the saved tiff file!
end