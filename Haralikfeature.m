function [H]=Haralikfeature(I)
glcm0 = graycomatrix(I, 'GrayLimits', [0 255], 'NumLevels', 256, 'offset', [0 1],  'Symmetric', true);
% glcm45= graycomatrix(I, 'GrayLimits', [0 255], 'NumLevels', 256, 'offset', [-1 1],  'Symmetric', true);
% glcm90= graycomatrix(I, 'GrayLimits', [0 255], 'NumLevels', 256, 'offset', [-1 0],  'Symmetric', true);
% glcm135=graycomatrix(I, 'GrayLimits', [0 255], 'NumLevels', 256, 'offset', [-1 -1],  'Symmetric', true);

% %%%%%%%%%normalize the SGLD matrix to values between 0 and 1%%%%%%%
glcm0=glcm0/sum(sum(glcm0));

%%%%%%%%%%%%%%ENERGY%%%%%%%%%%%%
Eng=sum(sum(power(glcm0,2)));

%%%%%%%%%%%% Entropy%%%%%%%
Ent=sum(sum(-((full(spfun(@log2,glcm0))).*glcm0)));
[i,j,v]=find(glcm0);

%%%%%%%% Inverse differnece moment%%%%%%%%%%%
IDM=sum((1./(1+(((i-1)-(j-1)).*((i-1)-(j-1))))).*v);

%%%%%%%%Correlation%%%%%%%
[m,n]=size(glcm0);
px=sum(glcm0,2);
[i,j,v]=find(px);
mu_x=sum((i-1).*v);
sigma_x=sum((((i-1)-mu_x).^2).*v);
h_x=sum(sum(-((full(spfun(@log2,px))).*px)));
temp1=repmat(px,[1 m]);

py=sum(glcm0,1);
[i,j,v]=find(py);
mu_y=sum((j-1).*v);
sigma_y=sum((((j-1)-mu_y).^2).*v);
h_y=sum(sum(-((full(spfun(@log2,py))).*py)));
temp2=repmat(py,[n 1]);

[i,j,v]=find(glcm0);
Corr=(sum(((i-1)-mu_x).*((j-1)-mu_y).*v))/sqrt(sigma_x*sigma_y);

%%%%%%%%%%%Information measures of correlation 1 and 2%%%%%%%%%%
foo1=-(glcm0.*(((temp1.*temp2)==0)-1));
foo2=-((temp1.*temp2).*((foo1==0)-1));
[i1,j1,v1]=find(foo1);
[i2,j2,v2]=find(foo2);
h1=sum((sum(-(v1.*(log2(v2))))));
Corr1=(Ent-h1)/max(h_x,h_y);
[i,j,v]=find(temp1.*temp2);
h2=sum((sum(-(v.*(log2(v))))));
Corr2=sqrt((1-exp(-2*(h2-Ent))));

%%%%%%%%Sum average, sum variance and sum entropy%%%%%%%%%%%%%
[i,j,v]=find(glcm0);
k=i+j-1;
pk_sum=zeros(max(k),1);
for l=min(k):max(k)
pk_sum(l)=sum(v(find(k==l)));
end

[i,j,v]=find(pk_sum);
sum_avg=sum((i-1).*v);

sum_var=sum((((i-1)-sum_avg).^2).*v);
sum_entropy=sum(-((full(spfun(@log2,pk_sum))).*pk_sum));

% %%%%%%%%%%%Difference average, variance and entropy%%%%%%%%%%
[i,j,v]=find(glcm0);
k=abs(i-j);
pk_diff=zeros(max(k)+1,1);
for l=min(k):max(k)
pk_diff(l+1)=sum(v(find(k==l)));
end
[i,j,v]=find(pk_diff);
diff_avg=sum((i-1).*v);
diff_var=sum((((i-1)-diff_avg).^2).*v);
diff_entropy=sum(-((full(spfun(@log2,pk_diff))).*pk_diff));







