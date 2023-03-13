function out = distfcn(newcenter,data,sigma)
%DISTFCM Distance measure in fuzzy c-mean clustering.
%	OUT = DISTFCM(CENTER, DATA) calculates the Euclidean distance
%	between each row in CENTER and each row in DATA, and returns a
%	distance matrix OUT of size M by N, where M and N are row
%	dimensions of CENTER and DATA, respectively, and OUT(I, J) is
%	the distance between CENTER(I,:) and DATA(J,:).
% out = zeros(size(center, 1), size(data, 1));
% 
% del=(sum(data).*(1./size(data)));
% for i=1:size(data,1)
%     for j=1:size(data,2)
%         delnew=sum((data(i,j)-del).^2);
%     end
% end
% delnew=sqrt(delnew.*1./size(data));
% if size(center, 2) > 1,
%     for k = 1:size(center, 1),
% 	out(k, :) =1-( expo(-(sum(((data-ones(size(data, 1), 1)*center(k, :)))'))/delnew));
%     end
% else	% 1-D data
%     for k = 1:size(center, 1),
% 	out(k, :) = abs(center(k)-data)';
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% out = zeros(size(center, 1), size(data, 1));
% 
% % fill the output matrix
% 
% if size(center, 2) > 1,
%     for k = 1:size(center, 1),
% 	out(k, :) = sqrt(sum(((data-ones(size(data, 1), 1)*center(k, :)).^2)'));
%     end
% else	% 1-D data
%     for k = 1:size(center, 1),
% 	out(k, :) = abs(center(k)-data)';
%     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out = zeros(size(newcenter, 1), size(data, 1));
% newkernel=exp((-(abs(data-((ones(size(data,1),1))*newcenter))))/sigma);
% newmeankernel=exp((-(abs(mean(data)-newcenter)))/sigma);
if size(newcenter, 2) > 1,
    for k = 1:size(newcenter, 1)
    out(k,:)=sum(exp((-(abs(data-((ones(size(data,1),1))*newcenter(k,:)))))/sigma));
    end

end