function out = fcm5(center, data)

out = zeros(size(center, 1), size(data, 1));

del=(sum(data).*(1./size(data)));
for i=1:size(data,1)
    for j=1:size(data,2)
        delnew=sum((data(i,j)-del).^2);
    end
end
delnew=sqrt(delnew.*1./size(data));
if size(center, 2) > 1,
    for k = 1:size(center, 1),
    out1(k,:)=1-( expo(-(sum((((data')-ones(size(data, 1), 1)*center(k, :)))'))/delnew));
    end
else	% 1-D data
    for k = 1:size(center, 1),
	out(k, :) = abs(center(k)-data)';
    end
end
