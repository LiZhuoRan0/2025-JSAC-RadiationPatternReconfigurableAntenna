function Result = RadiationPattern_Normlization(Result, N)
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
for phi = -90:90% elevation
    for theta = -90:90% azimuth
        Volume = Volume + (Std_RadiationPtn((phi+90)*181 + theta+91))^3 * sind(90-phi) * constant * constant /3;
    end
end
Equivalent_Omin_Gain = Volume/(2*pi/3);

% normalization
Result = Result / nthroot(Equivalent_Omin_Gain, 3);
end