function Result = RadiationPattern_Normlization_DifferentDictScale(Result, N, Scale)
%%
% input
%       Result      sensing matrix before normlization, power, not
%                   amplitude
%       N           # of antennas in one dimension
% output
%       Result      sensing matrix after normlization
%%
% Calculate normlization coefficient
index = ceil(N^2/2);
Std_RadiationPtn = Result(index,:);% linear

Volume = 0;
constant = pi/180;
% phi_samples = -90:DictScale:90;
% theta_samples = -90:DictScale:90;
% 
% for phi = -90:90% elevation
%     for theta = -90:90% azimuth
%         Volume = Volume + (Std_RadiationPtn((phi+90)*181 + theta+91))^3 * sind(90-phi) * constant * constant /3;
%     end
% end
phi_samples   = -90 : Scale :  90;   % 长度 nPhi
theta_samples = -90 : Scale :  90;   % 长度 nTheta
nPhi   = numel(phi_samples);
nTheta = numel(theta_samples);
% 注意：dOmega=(Scale*constant)^2 和 /3 不变
dOmega = (Scale * constant)^2;
Volume = 0;
for iPhi = 1 : nPhi
    phi = phi_samples(iPhi);
    for iTheta = 1 : nTheta
        theta = theta_samples(iTheta);

        % 线性下标：一定是整数
        idx = (iPhi - 1) * nTheta + iTheta;

        % 累加
        Volume = Volume + Std_RadiationPtn(idx)^3 ...
                            * sind(90 - phi) ...
                            * dOmega / 3;
    end
end


Equivalent_Omin_Gain = Volume/(2*pi/3);

% normalization
Result = Result / nthroot(Equivalent_Omin_Gain, 3);
end