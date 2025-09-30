function power_allocation = Water_Filling(H, P, sigma2)
%% 
% input
%       H           Nr x Nt
%       P           total transmit power
%       sigma2      noise power
% output
%       power_allocation
%%
% [Nr, Nt] = size(H);
s = svd(H);
lambda = [eps; 1e5];
threshold = 1e-3;
NSR = sigma2./s.^2;
while lambda(2)-lambda(1) > threshold
    tmp = mean(lambda) - NSR;
    tmp_2 = sum(tmp(tmp>0));
    if tmp_2 < P
        lambda(1) = mean(lambda);
    elseif tmp_2 > P
        lambda(2) = mean(lambda);
    end
end
power_allocation = mean(lambda) - NSR;
power_allocation(power_allocation<0)=0;
end
