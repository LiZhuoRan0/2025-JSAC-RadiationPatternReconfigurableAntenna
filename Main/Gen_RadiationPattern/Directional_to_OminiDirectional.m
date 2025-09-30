clear
clc

N = 5;              % Number of axis samples for both phi and theta axes
A_m = 30-8;         % Maximum attenuation [dB]
HPBW = 65;
path = sprintf('./Data/StdRadiationPattern_HPBW_%d',HPBW);
StdRadiationPattern = load(path).StdRadiationPattern;
maxvalue = max(StdRadiationPattern,[],'all');

RadiationPattern_dB = -min(-10*log10(repmat( StdRadiationPattern(91:271)...
                        , 1, 181 ) .* ...
                        repelem( StdRadiationPattern(91:271)...
                        , 1, 181 )/maxvalue), A_m);
RadiationPattern_linear = 10.^(RadiationPattern_dB/10);
% RadiationPattern_linear = ones(size(RadiationPattern_dB));
Volume = 0;
constant = pi/180;
for phi = -90:90% elevation
    for theta = -90:90% azimuth
        Volume = Volume + (RadiationPattern_linear((phi+90)*181 + theta+91))^3 * sind(90-phi) * constant * constant /3;
    end
end
% for phi = -90:0.1:90% elevation
%     for theta = 0:0.1:360% azimuth
%         Volume = Volume + 1 * sind(90-phi) * constant * constant * 0.1^2 / 3;
%     end
% end
Equivalent_Omin_Gain = Volume/(2*pi/3);
fprintf('HPBW = %4.2f\n', HPBW)
fprintf('Radiation Pattern should be divided by %4.2f\n', nthroot(Equivalent_Omin_Gain, 3));