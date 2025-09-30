clear
clc
%% 1. Generate standard radiation pattern
N = 7; % Number of axis samples for both phi and theta axes
A_m = 30-8;       % Maximum attenuation [dB]
HPBW = 45;

% Preallocate result matrix
num_combinations = N*N;
num_samples = 181*181; % 181*181 = 32761
Result = (8-30)*ones(num_combinations, num_samples);

StdRadiationPattern = generate_gain_pattern(HPBW);
% path = sprintf('./Data/StdRadiationPattern_HPBW_%d',HPBW);
% save(path,'StdRadiationPattern')

% path = sprintf('../../Data/RadiationPattern/HPBW_%d/RadiationPattern_%d', HPBW, N);
% StdRadiationPattern = load(path).StdRadiationPattern;
maxvalue = max(StdRadiationPattern,[],'all');


%% 2. Generate sensing matrix

bias_theta = round(linspace(-90, 90, N));
tic
for i = 1:N% big row, elevation
    for j=1:N% small row, azimuth
            Result((i-1)*N+j, :) = -min(-10*log10(repmat( StdRadiationPattern(91-bias_theta(j):271-bias_theta(j))...
                                    , 1, 181 ) .* ...
                                    repelem( StdRadiationPattern(91-bias_theta(i):271-bias_theta(i))...
                                    , 1, 181 )/maxvalue), A_m);
    end
end
toc
%% 3. Plot and Verification
figure;
imagesc(Result);
colormap(jet);
colorbar;
title('Codebook');
xlabel('Row');
ylabel('Column');

% tmp = load('../../Data/RadiationPattern/HPBW_65_Axis_90_New/RadiationPattern_5.mat').Result;
% fprintf('Error = %4.2f\d',sum(10*log10(tmp)-Result,'all'))
%% Function: 
function Gain = generate_gain_pattern(HPBW)
    deg2rad_factor = pi/180;
    
    % 3GPP TR 38.901 pattern parameters
    SLA_V = 30.0;     % Vertical side-lobe attenuation [dB]
    theta_3dB = HPBW; % Vertical HPBW [deg]
    A_m = 30.0;       % Maximum attenuation [dB]
    phi_3dB = HPBW;   % Horizontal HPBW [deg]
    G_max = 8.0;      % Maximum directional gain [dBi]
    
    phi_samples_180 = -180:1:180;
    theta_samples_180 = -180:1:180;
    [PHI_deg, THETA_deg] = meshgrid(phi_samples_180, theta_samples_180);
    
    % Shift angles relative to (phi_line, theta_line)
%     PHI_rel_deg = PHI_deg - phi_line;
%     THETA_rel_deg = THETA_deg - theta_line;
    PHI_rel_deg = PHI_deg;
    THETA_rel_deg = THETA_deg;
    
    PHI_rel = PHI_rel_deg * deg2rad_factor;
    THETA_rel = THETA_rel_deg * deg2rad_factor;
    
    A_EV0 = -min(12*((PHI_rel/(phi_3dB*deg2rad_factor)).^2), SLA_V);
    A_EH0 = -min(12*((THETA_rel/(theta_3dB*deg2rad_factor)).^2), A_m);
    
    A0 = -min(-(A_EV0 + A_EH0), A_m);
    A0_linear = 10.^((A0 + G_max)/10);
    
    P = (10.^((G_max)/10))*A0_linear / max(A0_linear,[],'all');
    Gain = P(181,:); % linear scale gain
end