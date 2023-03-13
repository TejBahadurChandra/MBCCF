clear all;
clc;
% I = rgb2gray( imread('G:\matlab code\paper3(feature extraction)\synthetic data\Case-11-U-22-1.jpg') );
% rect = [10 15 40 40];
% [J,rect] = SRAD(I,50,0.5,rect);
% %[J,rect] = SRAD(I,niter,lambda,rect);
% subplot(1,2,1);
% imshow(I,[]);
% subplot(1,2,2);
% imshow(J,[]);
% J = imresize(J, [190 190 ]);
% imwrite(J,'myGray.png');

list = dir('images\');
for i=1:length(list)
if ~strcmp(list(i,1).name,{'.','..','desktop.ini'})   
I=rgb2gray(imread(['images\',list(i,1).name]));
resizeim = imresize(I, [190 190 ]);
rect = [10 15 40 40];
[J,rect] = SRAD(resizeim,20,0.5,rect);
% figure,
% imshow(J);
 filename = strcat(list(i,1).name);
 imwrite(J,filename);
end
end