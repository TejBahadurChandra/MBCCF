clear;
clc;
list = dir('images\');
for i=1:length(list)
if ~strcmp(list(i,1).name,{'.','..','desktop.ini'})   
oimg=imread(['images\',list(i,1).name]);
oimg = imresize(oimg, [190 190 ]);
 figure;
subplot(221);
imshow(oimg);
title('Original Image');

[row ,col, dimention]=size(oimg);
if dimention>1
    oimg=rgb2gray(oimg);
else
    oimg=oimg;
end

filename = list(i,1).name;
img=imread(['images1\',filename]);
img = imresize(img, [190 190 ]);
subplot(222);
imshow(img);
title('segmented Image');

[r, c, d] = size(img);
if d>1
    img=rgb2gray(img);
else
    img=img;
end
% %%%%%%%%%%%% find the all the pixel that the value is 255 %%%%%
% % for find the all the pixel that the value is 0 then x=find(img==0);
x=find(img==255);
% %%%%%%%%%%% Copy the pixel value %%%%%%
oimg(x)=0;
subplot(223);
imshow(oimg);
title('After mapping');
%%%%%%%%%%%%%%% calculate the features %%%%%%%%%%%%%
% op= features(double(oimg));
%%%%%%% Save the features in xls file %%%%%%%%%%%%%%
% filename = strcat(list(i,1).name,'.xlsx');
filename = strcat(list(i,1).name);
imwrite(oimg,filename);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
