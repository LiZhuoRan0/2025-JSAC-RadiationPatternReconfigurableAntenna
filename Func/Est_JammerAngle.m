function [varphi_J, theta_J] = Est_JammerAngle(Para, Y_J2U)
%% Initial sensing of jammer's angle
% input
%       Para
%       Y_J2U           received signal from jammer to UAV, 
%                       Para.N_ant_U × Para.N_s × Para.N_h
% output
%       varphi_J        estimated elevation angle
%       theta_J         estimated azimuth angle
%%

% 1. sum of abs of the Y_J2U along the sampling points dimension
S_J = mean(abs(Y_J2U), 2);
[a,~,c] = size(S_J);
S_J = reshape(S_J,a,c);

% 2. obtain channel from jammer to UAV
H_J_hat = sqrt(S_J.^2*pi/2-Para.sigma_C^2)/Para.sigma_U_est;

% 3. obtain estimate jammer's angle
a = sum((H_J_hat*Para.C_norm_alg), 1).';
[~, I] = max(abs(a));

varphi_J = floor((I-1)/Para.N_a_azi)-90;
theta_J = mod(I-1, Para.N_a_azi)-90;
% fprintf('%f seconds elapsed for estimating Jammer''s angles\n', toc);
% fprintf('True Jammer Elevation: %d\n', round(Para.varphi_J_ture))
% fprintf('True Jammer Azimuth  : %d\n\n', round(Para.theta_J_ture))
% fprintf('Est. Jammer Elevation: %d\n', varphi_J)
% fprintf('Est. Jammer Azimuth  : %d\n', theta_J)
% fprintf('------------------------\n')
end

