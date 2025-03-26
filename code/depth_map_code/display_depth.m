clear; close all; clc
%%
I_depth_name = '233A5900.tif';
I_depth_base = "E:\Colorimetry\Photos\Perlas\Contadora_28_August_2023\Contadora_28_Aug_2023_0to25\depth";
I_depth_path = fullfile(I_depth_base, I_depth_name);

I_depth = imread(I_depth_path)

figure;
imagesc(I_depth);
colorbar;
title(sprintf("Depth Map: %s", I_depth_name), 'Interpreter', 'none');
