function [Cir,Elon,Comp,Ecc]=shape(image,A)
%B(1,:)= {'Circularity ','Elongation','Compactness','Eccentricity'};
% list = dir('images\');A=load('G:\matlab code\paper2\Results\(11) Lession Coordinate\b32.txt');
% for i=1:length(list)
% if ~strcmp(list(i,1).name,{'.','..','desktop.ini'})   
% BW=(imread(['images\',list(i,1).name]));
%BW =(imread('G:\matlab code\paper2\Results\(11) Lession Coordinate\b32.jpg'));
%A=load('G:\matlab code\paper2\Results\(11) Lession Coordinate\b32.txt');
Ibw = im2bw(image);
CC = bwconncomp(Ibw,8);
stat = regionprops(CC,'all');
Centroid = [stat.Centroid];
MajorAxisLength =[stat.MajorAxisLength];
MinorAxisLength=[stat.MinorAxisLength];
Orientation=[stat.Orientation];
area = [stat.Area];
radius =[stat.EquivDiameter]/2;
perimeter = [stat.Perimeter];
 subplot(121)
% imshow(BW); hold on;
% plot(stat(1).Centroid(1),stat(1).Centroid(2),'bo');
% subplot(122)
% imshow(BW);
% p =  patch(A(:,1),A(:,2),'red','Marker','*','FaceColor','none');
% set(p,'EdgeColor','b','LineWidth',2)
%%%%%%%%%%%%%%%%%%%%% Circularity %%%%%%%%%%%%%%%%%%%%%%
Cir = (4 * pi * area)./(perimeter .^ 2);
%xlswrite('Circularity.xlsx',Circularity');
% if Circularity <0.6 
%      h = msgbox('M');
% else
%      h = msgbox('B'); 
% end 

%%%%%%%%%%%%%%%%%%%%% Elongation %%%%%%%%%%%%%%%%%%%%%%
Elon=MinorAxisLength./MajorAxisLength;
%xlswrite('Elongation.xlsx',Elongation');   
% if Elongation <0.6
%      h = msgbox('M');
% else
%      h = msgbox('B'); 
% end 

%%%%%%%%%%%%%%%%%%%% Compactness %%%%%%%%%%%%%%%%%%%
Comp=Cir .*Elon;
%xlswrite('Compactness.xlsx',Compactness');
%if Elongation <0.6
%      h = msgbox('M');
% else
%      h = msgbox('B'); 
% end 

%%%%%%%%%%%%%%%%%%%% Eccentricity %%%%%%%%%%%%%%%%%%%
 Foci=sqrt((MajorAxisLength).^2-(MinorAxisLength).^2);
 Ecc =Foci./MajorAxisLength;
  %xlswrite('Eccentricity.xlsx',Eccentricity'); 
  
%%%%%%%%%%%%%%%%%%%%%% Angular Margin and Spiculations %%%%%%%%%%%%%%%%%%%%%%
% for i=1:size(A,1)-2
%     col1=A(i,:);
%     col2=A(i+1,:);
%     col3=A(i+2,:);
%     x1=col1(1,1);
%     y1=col1(1,2);
%     x2=col2(1,1);
%     y2=col2(1,2);
%     x3=col3(1,1);
%     y3=col3(1,2);
%     m1=(y2-y1)./(x2-x1);
%     m2=(y3-y2)./(x3-x2);
%     u=sqrt((x2-x1)^2+(y2-y1)^2);
%     v=sqrt((x3-x2)^2+(y3-y2)^2);
%     u1=[(x2-x1),(y2-y1)];
%     u2=[(x3-x2),(y3-y2)];
%     u3=dot(u1,u2);
%     angle=acosd(u3/(u*v));
%     Spiculations=atand(abs(m2-m1./(1+(m1*m2))));
% end
% Y = circshift(A,2);
% Y=unique(Y,'rows','stable');
% col1=Y(1,:);
% col2=Y(2,:);
% col3=Y(3,:);
% x1=col1(1,1);
% y1=col1(1,2);
% x2=col2(1,1);
% y2=col2(1,2);
% x3=col3(1,1);
% y3=col3(1,2);
% m1=(y2-y1)./(x2-x1);
% m2=(y3-y2)./(x3-x2);
% u=sqrt((x2-x1)^2+(y2-y1)^2);
% v=sqrt((x3-x2)^2+(y3-y2)^2);
% u1=[(x2-x1),(y2-y1)];
% u2=[(x3-x2),(y3-y2)];
% u3=dot(u1,u2);
% angle1=acosd(u3/(u*v));
% xlswrite('angle.xlsx',angle'); 
%lswrite('angle.xlsx',angle1');
% xlswrite('Spiculations.xlsx',Spiculations'); 
end



