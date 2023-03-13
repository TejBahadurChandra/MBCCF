function [U_new, center, obj_fcn] = objfcn(data, U, cluster_n, expo)
%STEPFCM One step in fuzzy c-mean clustering.
%   [U_NEW, CENTER, ERR] = STEPFCM(DATA, U, CLUSTER_N, EXPO)
%   performs one iteration of fuzzy c-mean clustering, where
%
%   DATA: matrix of data to be clustered. (Each row is a data point.)
%   U: partition matrix. (U(i,j) is the MF value of data j in cluster j.)
%   CLUSTER_N: number of clusters.
%   EXPO: exponent (> 1) for the partition matrix.
%   U_NEW: new partition matrix.
%   CENTER: center of clusters. (Each row is a center.)
%   ERR: objective function for partition U.
%
%   Note that the situation of "singularity" (one of the data points is
%   exactly the same as one of the cluster centers) is not checked.
%   However, it hardly occurs in practice.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mf = U.^expo;% MF matrix after exponential modification
center = mf*data./((ones(size(data, 2), 1)*sum(mf'))');% new center
% dist = distfcn(center, data);  % fill the distance matrix
% obj_fcn = sum(sum((dist.^2).*mf));
% tmp = dist.^(-2/(expo-1));      % calculate new U, suppose expo != 1
% U_new = tmp./(ones(cluster_n, 1)*sum(tmp));
%sum(sum(dist.*mf))+(alfa.*sum(sum(dist1.*mf)))+(beta.*sum(sum(dist.*mf)));

alfa=0.5;
beta=0.5;
sigma=sqrt((1/size(data,1)).*sum((data-((ones(size(data, 1), 1))*((1/size(data,1)).*sum(data)))).^2));
% mf = U.^expo;% MF matrix after exponential modification
% center = mf*data./((ones(size(data, 2), 1)*sum(mf'))'); %initialize center
kernel=exp((-(abs(data-(ones(size(center'))*center))))/sigma);
meankernel=exp((-(abs(ones(size((mean(data))'))*mean(data)-(ones(size(center'))*center))))/sigma);
one=(kernel*kernel')*data;% first upper part of new center
two=alfa*meankernel*mean(data);% second upper part of new center
three=beta*(kernel*kernel')*data;% third upper part of new center
lone=mf*kernel;% first lower part of new center
ltwo=alfa*meankernel;% second lower part of new center
lthree=beta*kernel; % third lower part of new center
newcenter=sum(mf*(one+two+three))/sum(ltwo+lthree+((sum(lone)*(ones(size(ltwo,1),1))')'));% new center
dist = distfcn(newcenter,data,sigma);
meandist=meandistfcn(newcenter,data,sigma);
part1=mf.*(ones(size(mf,1),1)*(1-dist));% first part of objet function
part2=mf.*(ones(size(mf,1),1)*(1-meandist));% second part of objet function
part3=mf.*(ones(size(mf,1),1)*(1-dist));% second part of objet function
%obj_fcn=sum(((ones(size(data,1),1))*part1')'+(alfa*part2)+(beta*((ones(size(data,1),1))*part3')'));
obj_fcn=sum(sum(part1+(alfa*part2)+(beta*part3)));
mpart1=dist;
mpart2=alfa*meandist;
mpart3=beta*dist;
U_new=mpart1+mpart2+mpart3;

% one= data*(exp((abs(data-padarray(center,[188,0],1,'post')))/sigma));
% two=alfa*(exp((abs(padarray(mean(data),[1,0],1,'post')-center))/sigma));
% two=mean(data)*padarray(two,[188,0],1,'post');
% three=data*(beta*(exp((abs(data-padarray(center,[188,0],1,'post')))/sigma)));
% lone=mf*(exp((abs(data-padarray(center,[188,0],1,'post')))/sigma));
% ltwo=alfa*(exp((abs(padarray(mean(data),[1,0],1,'post')-center))/sigma));
% lthree=(beta*(exp((abs(data-padarray(center,[188,0],1,'post')))/sigma)));
% newcenter=sum(mf*(one+three+padarray(two,[189,0],1,'post')))/sum(lthree+p
% adarray(lone+ltwo,[188,0],1,'post'));% new center
% part1=sum(sum(mf*(1-exp(abs(data-newcenter)/sigma))));
% part2=(alfa*sum(sum(mf*(1-exp(abs(mean(data)-newcenter)/sigma)))));
% part3=(beta*sum(sum(mf*(1-exp(abs(data-newcenter)/sigma)))));
% obj_fcn1=part1+part2+part3;
% U_new1 =((obj_fcn1)^(-1/expo-1));
