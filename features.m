function [feat]=features(inname)
%
%function [feat]=texfeat(inname);
%Christos P Loizou 2014 (panloicy@logosnet.cy.net)
%61 different image features extraction
%inname = GIF file name should be given or image
%27/6/01 - Modified for MATLAB R12 

if ischar(inname) 
   img=imread(inname,'gif');
   img=double(img)+1; % Imread range 0-255 / gifread 1-256
else
   img=inname;
end

feat=[1];

if max(max(img))==256;
   f=find(img==255 | img==254);
   img(f) = ones(length(f),1)*253;
   f=find(img==256);
   img(f) = ones(length(f),1)*255;
end;

x=img(img<254);
st=std(x);

%First Order Statistics (FOS) (features 1-9)
[mean,var,med,mode,skew,kurt,eng,ent]=nwfos(img);
feat=[feat,mean,var,med,mode,skew,kurt,eng,ent];  			

%Haralick Spatial Gray Level Dependence Matrices (SGLDM) (9-34)
[mf,rf]=nwsgldm(img,1);
feat=[feat, mf, rf];				

%Gray Level Difference Statistics (GLDS) (35-39)
[hom,con,eng,ent,mean]=nwgldmc(img,1);  
feat=[feat,hom,con,eng,ent,mean];
% 
%Neighbourhood Gray Tone Difference Matrix (NGTDM) (40-44)
[coars,contr,busyn,compl,stren]=nwngtdmn(img,1);
feat=[feat, coars,contr,busyn,compl,stren ];	
 
%Statistical Feature Matrix (SFM) (45-48)
[coars, cont, period, rough]=nwsfm(img,4,4);
feat=[feat, coars, cont, period, rough];	
 
%Laws Texture Energy Measures (TEM) (49-53)
[LL,EE,SS,LE,ES,LS]=nwlaws(img,7);
feat=[feat, LL,EE,SS,LE,ES,LS];			

% Fractal Dimension Texture Analysis (FDTA) (54-57)
h=fdta2(img,3);					
feat=[feat, h];					

% Fourier Power Spectrum (FPS) (58-59)
[fr,fa]=fps(img);
feat=[feat, fr,fa];				

% Shape (x, y, area, perim, perim^2/area) (60-62)
f=fshape2(img);
feat=[feat, f];	
 
%Spectral Texture of Images (STI) (63-267)
[srad, sang] = SPECXTURE(img);
feat=[feat, srad, sang];

%Invariant Moments of Image (IMI) (268-274)
[phi] = invmoments(img);
feat=[feat, phi];

%Statistical Measures of Texture in an Image (SMTI) (275-280)
t = statxture(img);
feat=[feat, t];

%Gray Level Run Length Matrix (GLRLM) (Calculated so as to be used in grayrlprops)
[GLRLMS,SI]= grayrlmatrix(img);
 
%Gray Level Run Length Properties (GLRLProps) (281-291)
stats = grayrlprops(GLRLMS);
feat=[feat, stats];

%Segmentation-based Fractal Texture Analysis, or SFTA (292-303)
Isfta= sfta(inname,2);
feat=[feat, Isfta];

% %Segmentation-based shape Texture Analysis(304-309)
% [Cir,Elon,Comp,Ecc]=shape(image,A);
% feat=[feat,Cir,Elon,Comp,Ecc];


